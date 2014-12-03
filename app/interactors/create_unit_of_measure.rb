require 'creator'

class CreateUnitOfMeasure
  include Interactor::Creator

  def call
    if model.save
      context.message = 'Unit of measure successfully created'
    else
      fail!(:message => 'Unit of measure not created')
    end
  end

  # Create a new unit of measure in context using the parameters passed into the
  # interactors call method.
  #
  # We'll set some defaults here for missing values.
  # def create_unit_of_measure
  def create
    model.uuid = UUID.generate(:compact)
    model.source = source ||= :local
  end

  # Prevalidate the new unit of measure before attempting to persist.
  def validate
    unless model.valid?
      context.fail!(:message => 'Invalid unit of measure details')
    end
  end
end
