# Translation class representing the mapping between a CovalentWorks
# source value and a Product.
#
# Uses the sender value to scope the source field and value.
#
# Currently limited to a single source field and value, not sure if a 
# Covalent file would use more than one field.
class ProductTranslation < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :product
  validates_presence_of :sender_value
  validates_presence_of :source_field
  validates_presence_of :source_value

  class << self
    def find_mapped(
      translation_sender_value, 
      translation_source_field, 
      translation_source_value)
      where { sender_value == my { translation_sender_value } }.
      where { source_field == my { translation_source_field } }.
      where { source_value == my { translation_source_value } }
    end
  end

  def translate(hash)
    translations = ProductTranslation.find_mapped(
      *hash.slice(:sender_value, :source_field, :source_value).values)

    if translations.any?
      @translated_value = translations.first.product
    end

    self
  end  

  def translated_value
    @translated_value
  end

end
