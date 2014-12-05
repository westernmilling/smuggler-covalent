class PurchaseOrder::Line < ActiveRecord::Base
  belongs_to :created_by, :class => User, :foreign_key => :created_by_user_id
  belongs_to :product
  belongs_to :purchase_order
  belongs_to :unit_of_measure

  has_paper_trail

  validates_presence_of :line_number
  validates_presence_of :product
  validates_presence_of :purchase_order
  validates_presence_of :quantity
  validates_presence_of :unit_of_measure
  validates_presence_of :unit_price
end
