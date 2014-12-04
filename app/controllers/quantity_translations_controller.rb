class QuantityTranslationsController < ApplicationController
  respond_to(:html)

  def create
    @translation = QuantityTranslation.new(translation_params)

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
    @translations = QuantityTranslation.all
  end

  def new
    @translation = QuantityTranslation.new
  end

  protected

  def translation_params
    params.
      require(:quantity_translation).
      permit(
        :sender_value,
        :expression)
  end

end
