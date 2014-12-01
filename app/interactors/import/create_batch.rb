class Import::CreateBatch
  include Interactor

  before :create_batch
  before :validate

  def call
    # do save in before block

    # queue file processing

    if context.batch.save!
      context.message = 'Batch successfully created'
    else
      fail!(:message => 'Batch not created') 
    end
  end

  def create_batch
    context.batch = Import::Batch.new(context.to_h.except(:upload_file_path, :upload_file))
    context.batch.status = :new
    # TODO: Refactor this
    if context.upload_file
      if context.upload_file.is_a?(String)
        File.open(context.upload_file, 'r') do |file|
          context.batch.upload = file
        end
      else
        context.batch.upload = context.upload_file
      end
    end
  end

  def validate
    unless context.batch.valid?
      context.fail!(:message => 'Invalid batch details')
    end
  end

end
