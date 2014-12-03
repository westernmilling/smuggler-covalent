class UnitOfMeasureTranslationsController < ApplicationController
  respond_to(:html)

  def create
    @translation = UnitOfMeasureTranslation.new(translation_params).decorate

    if @translation.save
      notice_redirect(
        @translation, 
        'Translation created successfully', 
        [@translation])
    else
      respond_with(@translation)
    end
  end

  def index
    # TODO: Implement Ransack searching
    @translations = UnitOfMeasureTranslation.all.decorate
  end

  def new
    @translation = UnitOfMeasureTranslation.new.decorate
  end

  def translation_params
    params.
      require(:unit_of_measure_translation).
      permit(
        :unit_of_measure_id, 
        :name, 
        :sender_value, 
        :source_field, 
        :source_value)
  rescue ActionController::ParameterMissing
    {}
  end
end
