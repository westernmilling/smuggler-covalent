# Unit of Measure class.
class UnitOfMeasure < ActiveRecord::Base
  symbolize :source

  validates_presence_of :conversion_to_pounds
  validates_presence_of :name
  validates_presence_of :reference
  validates_presence_of :source
  validates_presence_of :uuid
end
