# Represents a customer purchase order.
class PurchaseOrder < ActiveRecord::Base
  belongs_to :ship_to_entity, :class => Entity
  has_many(
    :lines,
    :autosave => true,
    :class => PurchaseOrder::Line,
    :foreign_key => :purchase_order_id)

  has_paper_trail

  validates :date, :date => true
  validates(
    :latest_request_date,
    :date => {
      :after_or_equal_to => :earliest_request_date,
      :allow_nil => true,
      :message => 'must be after earliest request date'
    })
  # validates(
  #   :lines,
  #   :length => { :minimum => 1, :message => 'must have at least one line' })
  validates_presence_of :date
  validates_presence_of :number
  validates_presence_of :ship_to_entity
  validates_presence_of :earliest_request_date
  validates_presence_of :latest_request_date
end
