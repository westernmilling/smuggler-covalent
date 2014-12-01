# Controller to manager entity translations.
#
# NOTE: We decorate the model for the view to pass on the entity name.
class EntityTranslationsController < ApplicationController
  respond_to(:html)

  def create
    @entity_translation = EntityTranslation.new(translation_params).decorate

    if @entity_translation.save
      notice_redirect(
        @entity_translation, 
        'Translation created successfully', 
        [@entity_translation])
    else
      respond_with(@entity_translation)
    end
  end

  def index
    # TODO: Implement Ransack searching
    @entity_translations = EntityTranslation.all
  end

  def new
    @entity_translation = EntityTranslation.new.decorate
  end

  protected

  def translation_params
    params.
      require(:entity_translation).
      permit(
        :entity_id,
        :sender_value,
        :source_field,
        :source_value)
  end

end
