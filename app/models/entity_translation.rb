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
end
