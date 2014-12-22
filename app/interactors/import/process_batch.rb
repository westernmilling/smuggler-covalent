require 'hash_extensions'

module Import
  # Process an import batch
  class ProcessBatch
    include Interactor
    using HashExtensions
    using StringExtensions

    before :load_batch
    before :check_status
    before :init_purchase_orders
    before :create_lines

    # TODO: Reduce the complexity of the call method
    # Assignment Branch Condition size for call is too high. [49.16/15]
    # Method has too many lines. [31/10]
    def call
      context.batch.lines.group_by(&:purchase_order_number).each do |_k, lines|
        purchase_order = create_purchase_order(lines.first)

        lines.each do |line|
          value_hash = line.value_hash
          po_line = PurchaseOrder::Line.new
          po_line.purchase_order = purchase_order
          po_line.line_number = value_hash[:line_nbr].to_i
          po_line.product = ProductTranslation.translate(value_hash)
          po_line.quantity = QuantityTranslation.translate(value_hash)
          po_line.unit_price = PriceTranslation.translate(value_hash)
          po_line.unit_of_measure =
            UnitOfMeasureTranslation.translate(value_hash)

          purchase_order.lines << po_line

          line.purchase_order = purchase_order
        end

        # puts "PO Lines: #{purchase_order.lines.to_yaml}"

        purchase_order.save!
        context.purchase_orders << purchase_order
      end

      context.batch.status = :complete
      context.batch.save!
      context.message = 'Batch proccessed successfully'
    end

    def check_status
      return unless [:complete, :pending].include?(context.batch.status)

      fail "Cannot process a #{context.batch.status} batch"
    end

    def create_lines
      raw_file = Paperclip.io_adapters.for(context.batch.upload).read

      CSV.parse(raw_file, :headers => true) do |row|
        context.batch.add_line(row['PO Number'], row['Sender'], row.to_h)
      end
    end

    def create_purchase_order(import_line)
      value_hash = import_line.value_hash
      PurchaseOrder.new do |po|
        po.date = value_hash[:po_date]
        po.number = value_hash[:po_number]
        po.status = :new
        po.earliest_request_date = value_hash[:delivery_date_requested]
        po.latest_request_date = value_hash[:last_delivery_date_requested]
        po.ship_to_entity = EntityTranslation.translate(value_hash)
      end
    end

    def init_purchase_orders
      context.purchase_orders = []
    end

    def load_batch
      context.batch = Import::Batch.find(context.batch_id)
    end
  end
end
