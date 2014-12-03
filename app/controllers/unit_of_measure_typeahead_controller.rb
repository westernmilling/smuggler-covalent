class UnitOfMeasureTypeaheadController < ApplicationController
  respond_to(:json)

  def index
    respond_with(unit_of_measures)
  end

  def unit_of_measures
    query = "%#{params[:q]}%"

    UnitOfMeasure.where { (name =~ query) | (reference =~ query) }
  end 
end
