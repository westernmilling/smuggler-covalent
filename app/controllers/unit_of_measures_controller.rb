class UnitOfMeasuresController < ApplicationController
  respond_to(:html)

  def create
    context = CreateUnitOfMeasure.call(unit_of_measure_params)

    if context.success?
      notice_redirect(
        context.unit_of_measure, 
        context.message, 
        [context.unit_of_measure])
    else
      respond_with(@unit_of_measure = context.unit_of_measure)
    end 
  end

  def index
    # TODO: Implement Ransack search
    @unit_of_measures = UnitOfMeasure.all
  end

  def new
    @unit_of_measure = UnitOfMeasure.new
  end

  protected

  def unit_of_measure_params
    params.
      require(:unit_of_measure).
      permit(
        :conversion_to_pounds,
        :name, 
        :reference)
  rescue ActionController::ParameterMissing
    {}
  end
end
