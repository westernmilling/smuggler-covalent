class PriceTranslationsController < ApplicationController
  respond_to(:html)

  def create
    @translation = PriceTranslation.new(translation_params)

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
    @translations = PriceTranslation.all
  end

  def new
    @translation = PriceTranslation.new
  end

  protected

  def translation_params
    params.
      require(:price_translation).
      permit(
        :sender_value,
        :expression)
  end

end
