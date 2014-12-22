# Translation class representing the mapping between a CovalentWorks
# source value and a Product.
#
# Uses the sender value to scope the source field and value.
#
# Currently limited to a single source field and value, not sure if a 
# Covalent file would use more than one field.
class ProductTranslation < ActiveRecord::Base
  include FieldTranslation

  belongs_to :product

  validates_presence_of :product
  validates_presence_of :source_field
  validates_presence_of :source_value

  def get_value(*)
    product
  end

  def match?(hash)
    hash[source_field.to_sym] == source_value
  end
end
