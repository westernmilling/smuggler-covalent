# Translation class representing the mapping between a CovalentWorks
# source value and an Entity.
#
# Uses the sender value to scope the source field and value.
#
# Currently limited to a single source field and value, not sure if a 
# Covalent file would use more than one field.
class EntityTranslation < ActiveRecord::Base
  belongs_to :entity

  validates_presence_of :entity
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
    translations = EntityTranslation.find_mapped(
      *hash.slice(:sender_value, :source_field, :source_value).values)

    if translations.any?
      @translated_value = translations.first.entity
    end

    self
  end  

  def translated_value
    @translated_value
  end

end
