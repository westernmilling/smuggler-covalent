# Entity Translation Input class
# NOTE: This was a proof of concept that I chose to not use 
# in favor of applying a decorator.
class EntityTranslationInput
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :entity_translation

  attribute :entity_id, Integer
  attribute :entity_string, String
  attribute :sender_value, String
  attribute :source_field, String
  attribute :source_value, String

  validates_presence_of :entity_id
  validates_presence_of :sender_value
  validates_presence_of :source_field
  validates_presence_of :source_value

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

private

  def persist!
    @entity_translation = EntityTranslation.create!(
      :entity_id => entity_id,
      :sender_value => sender_value,
      :source_field => source_field,
      :source_value => source_value)
  end
end