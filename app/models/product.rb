# Product class representing a tradable product.
class Product < ActiveRecord::Base
  symbolize :source

  validates_presence_of :display_name
  validates_presence_of :name
  validates_presence_of :reference
  validates_presence_of :source
  validates_presence_of :uuid

end
