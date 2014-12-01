class ProductTranslationsController < ApplicationController
  respond_to(:html)

  def create
    @product_translation = ProductTranslation.new(translation_params).decorate

    if @product_translation.save
      notice_redirect(
        @product_translation, 
        'Translation created successfully', 
        [@product_translation])
    else
      respond_with(@product_translation)
    end
  end

  def index
    # TODO: Implement Ransack searching
    @product_translations = ProductTranslation.all.decorate
  end

  def new
    @product_translation = ProductTranslation.new.decorate
  end

  protected

  def translation_params
    params.
      require(:product_translation).
      permit(
        :product_id,
        :sender_value,
        :source_field,
        :source_value)
  end

end
