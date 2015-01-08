require 'string_extensions'

# Represents a line of a file in an import batch.
class Import::Batch::Line < ActiveRecord::Base
  using StringExtensions

  acts_as_paranoid

  belongs_to :batch, :class => Import::Batch, :foreign_key => :import_batch_id
  belongs_to :purchase_order
  belongs_to :purchase_order_line, :class => PurchaseOrder::Line
  has_many(
    :values,
    :autosave => true,
    :class => Import::Batch::Line::FieldValue,
    :foreign_key => :import_batch_line_id)

  validates_presence_of :batch
  validates_presence_of :purchase_order_number
  validates_presence_of :sender
  validates_presence_of :status

  def add_field_value(name, value)
    values.build do |field_value|
      field_value.batch = self.batch
      field_value.line = self
      field_value.name = name
      field_value.value = value
    end
  end

  def attach_purchase_order_line(line)
    self.purchase_order = line.purchase_order
    self.purchase_order_line = line
  end

  def value_hash
    # If we converted this hash to have keys that were the same as the purchase
    # order then this would make create new purchase orders "simpler".
    values.each_with_object({}) do |field_value, hash|
      hash.store(field_value.name.brute_underscore.to_sym, field_value.value)
    end
  end
end
