class EntityTypeaheadController < ApplicationController
  respond_to(:json)

  def index
    # @entities = entities

    respond_with(entities)
  end

  def entities
    query = "%#{params[:q]}%"

    Entity.where { cached_full_name =~ query }
  end
end
