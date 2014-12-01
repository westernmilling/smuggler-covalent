# An interactor for creating new Entity instances.
#
# Creates a new Entity ensuring that they meet system requisites.
class CreateEntity
  include Interactor

  before :create_entity
  before :validate

  # Creates a new Entity.
  def call
    if context.entity.save
      context.message = 'Entity successfully created'
    else
      fail!(:message => 'Entity not created')
    end
  end

  # Create a new entity in context using the parameters passed into the
  # interactors call method.
  #
  # We'll set some defaults here for missing values.
  def create_entity
    context.entity = Entity.new(context.to_h)
    context.entity.uuid = UUID.generate(:compact)
    context.entity.display_name ||= context.entity.name
    context.entity.cached_full_name ||= context.entity.decorate.full_name
    context.entity.source ||= :local
  end

  # Prevalidate the new Entity before attempting to persist.
  def validate
    unless context.entity.valid?
      context.fail!(:message => 'Invalid Entity details')
    end
  end
end
