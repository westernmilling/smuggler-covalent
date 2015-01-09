require 'csv'
require 'hash_extensions'

module Import
  # Process an import batch
  class ProcessBatch
    include Interactor
    using HashExtensions
    using StringExtensions

    TRANSLATIONS = [
      EntityTranslation,
      PriceTranslation,
      ProductTranslation,
      QuantityTranslation,
      UnitOfMeasureTranslation]

    before :load_batch
    before :check_batch_status
    before :init_batch_lines
    before :init_purchase_orders
    before :reset_batch
    before :check_translations
    before :check_batch

    def call
      build_purchase_orders

      save_purchase_orders!

      context.batch.status = :complete
      context.batch.save!
      context.message = 'Batch proccessed successfully'
    end

    def check_batch
      return if context.batch.status != :failed

      context.batch.save!
      context.fail!(:message => 'Batch proccess failed')
    end

    def check_batch_status
      return unless [:complete, :pending].include?(context.batch.status)

      fail "Cannot process a #{context.batch.status} batch"
    end

    def reset_batch
      context.batch.clear_remarks
      context.batch.status = :pending
      context.batch.save!
    end

    def check_translations
      context.batch.lines.each do |line|
        TRANSLATIONS.each do |klass|
          check_translation(klass, line)
        end
      end
    end

    def check_translation(klass, line)
      translation_result = klass.translate(line.value_hash)

      return if translation_result.success

      line.status = :failed
      context.batch.status = :failed
      context.batch.add_remark(
        klass.to_s,
        line,
        translation_result.message,
        :error)
    end

    def init_batch_lines
      return unless context.batch.new?

      CSV.parse(context.batch.read_upload_file, :headers => true) do |row|
        context.batch.add_line(row['PO Number'], row['Sender'], row.to_h)
      end
    end

    def build_purchase_order(import_line)
      # PurchaseOrder.build_from_import_hash(import_line.value_hash)
      Import::Batch.build_purchase_order_from_import_hash(
        import_line.value_hash)
    end

    def build_purchase_order_line(purchase_order, value_hash)
      Import::Batch.build_purchase_order_line_from_import_hash(
        purchase_order, value_hash)
    end

    def build_purchase_orders
      context.batch.lines.group_by(&:purchase_order_number).each do |_k, lines|
        process_group_of_batch_lines(lines)
      end
    end

    def process_group_of_batch_lines(lines)
      purchase_order = build_purchase_order(lines.first)
      lines.each do |line|
        po_line = build_purchase_order_line(
          purchase_order, line.value_hash)

        purchase_order.lines << po_line

        line.attach_purchase_order_line(po_line)
      end

      context.purchase_orders << purchase_order
    end

    def init_purchase_orders
      context.purchase_orders = []
    end

    def load_batch
      context.batch = Import::Batch.find(context.batch_id)
    end

    def save_purchase_orders!
      context.purchase_orders.each(&:save!)
    end
  end
end
