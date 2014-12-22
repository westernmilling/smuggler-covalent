module Import
  # Represents a purchase order import batch.
  class Batch < ActiveRecord::Base
    acts_as_paranoid

    has_attached_file :upload, :use_timestamp => false
    has_many(
      :lines,
      :autosave => true,
      :class => Import::Batch::Line,
      :foreign_key => :import_batch_id)

    has_paper_trail

    symbolize :status, :in => [:complete, :failed, :new, :pending]

    validates_attachment_content_type(
      :upload,
      :content_type => ['text/comma-separated-values', 'text/csv'])
    validates_presence_of :status
    validates_presence_of :upload

    def add_line(purchase_order_number, sender, values)
      lines.build do |line|
        # TODO: Remove me and the underlying column from db and migration
        line.import_data = 'lala'
        line.purchase_order_number = purchase_order_number
        line.sender = sender
        line.status = :new
        values.each do |k, v|
          line.add_field_value(k, v)
        end
      end
    end
  end
end
