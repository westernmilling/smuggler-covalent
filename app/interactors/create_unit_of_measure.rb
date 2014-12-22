require 'creator'

class CreateUnitOfMeasure
  include Interactor::Creator

  def call
    if model.save
      context.message = 'Unit of measure successfully created'
    else
      context.fail!(:message => 'Unit of measure not created')
    end
  end

  # Set the defaults for the unit of measure instance
  def after_build 
    model.uuid = UUID.generate(:compact)
    model.source = source ||= :local
  end

end
