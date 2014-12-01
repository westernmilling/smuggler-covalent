class EntityTranslationDecorator < Draper::Decorator
  delegate_all

  def entity_string
    if entity
      entity.cached_full_name
    end
  end

end
