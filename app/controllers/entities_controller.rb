class EntitiesController < ApplicationController
  respond_to(:html)

  def create
    context = CreateEntity.call(entity_params)

    if context.success?
      notice_redirect(context.entity, context.message, [context.entity])
    else
      respond_with(@entity = context.entity)
    end 
  end

  def index
    # TODO: Implement Ransack search
    @entities = Entity.all
  end

  def new
    @entity = Entity.new
  end

  protected

  def entity_params
    params.
      require(:entity).
      permit(
        :name, 
        :display_name, 
        :reference, 
        :street_address, 
        :city, 
        :region, 
        :region_code, 
        :country, 
        :roles)
  end

end
