module Import
  # Represents a purchase order import batch.
  class Batch < ActiveRecord::Base
    acts_as_paranoid

    has_attached_file :upload, :use_timestamp => false
    has_many(
      :lines,
      :autosave => true,
      :class => Import::Batch::Line,
      :dependent => :destroy,
      :foreign_key => :import_batch_id)
    has_many(
      :purchase_orders,
      -> { uniq },
      :class => PurchaseOrder,
      :through => :lines)
    has_many(
      :remarks,
      :class => Import::Batch::Remark,
      :dependent => :destroy,
      :foreign_key => :import_batch_id)

    has_paper_trail

    symbolize :status, :in => [:complete, :failed, :new, :pending]

    validates_attachment_content_type(
      :upload,
      :content_type => ['text/comma-separated-values', 'text/csv'])
    validates_presence_of :status
    validates_presence_of :upload

    class << self
      # NOTE: Consider moving the build methods below into "factory" classes.

      # Create a new +PurchaseOrder instance from hash of values
      # whos keys are named from the import file CSV columns.
      def build_purchase_order_from_import_hash(import_hash)
        PurchaseOrder.new do |po|
          po.date = import_hash[:po_date]
          po.number = import_hash[:po_number]
          po.status = :new
          po.earliest_request_date = import_hash[:delivery_date_requested]
          po.latest_request_date = import_hash[:last_delivery_date_requested]
          po.ship_to_entity = EntityTranslation.translate(import_hash)
        end
      end

      def build_purchase_order_line_from_import_hash(po, import_hash)
        PurchaseOrder::Line.new do |po_line|
          po_line.purchase_order = po
          po_line.line_number = import_hash[:line_nbr].to_i
          po_line.product = ProductTranslation.translate(import_hash)
          po_line.quantity = QuantityTranslation.translate(import_hash)
          po_line.unit_price = PriceTranslation.translate(import_hash)
          po_line.unit_of_measure =
            UnitOfMeasureTranslation.translate(import_hash)
        end
      end
    end

    def add_line(purchase_order_number, sender, values)
      select_line_by_number(values['Line Nbr']) || lines.build do |line|
        line.line_number = values['Line Nbr'].to_i
        line.purchase_order_number = purchase_order_number
        line.sender = sender
        line.status = :new
        values.each do |k, v|
          line.add_field_value(k, v)
        end
      end
    end

    def add_remark(category, line, message, type)
      remarks.build do |remark|
        remark.line = line
        remark.remark_category = category
        remark.remark_message = message
        remark.remark_type = type
      end
    end

    # Clears all the remark instances.
    def clear_remarks
      remarks.each(&:destroy)
    end

    def new?
      status == :new
    end

    def read_upload_file
      Paperclip.io_adapters.for(self.upload).read
    end

    def select_line_by_number(line_number)
      lines.select { |x| x.line_number == line_number }.first
    end
  end
end
