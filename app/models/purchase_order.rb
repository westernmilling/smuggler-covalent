class PurchaseOrder < ActiveRecord::Base
  belongs_to :created_by, :class => User, :foreign_key => :created_by_user_id
  belongs_to :ship_to_entity, :class => Entity

  validates :date, :date => true
  validates_presence_of :date
  validates_presence_of :number
  validates_presence_of :ship_to_entity
  validates_presence_of :earliest_request_date
  validates_presence_of :latest_request_date
  validates :latest_request_date, date: { after_or_equal_to: :earliest_request_date,
                                    message: 'must be after earliest request date' }

end