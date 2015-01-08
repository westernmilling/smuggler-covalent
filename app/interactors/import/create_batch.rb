require 'creator'

class Import::CreateBatch
  include Interactor::Creator

  def call
    model.whodunnit(context.user) { model.save! }

    # TODO: Queue processing

    context.message = 'Batch successfully created'
  end

  def after_build
    model.status = :new
    # TODO: Refactor this
    if context.upload_file
      if context.upload_file.is_a?(String)
        File.open(context.upload_file, 'r') do |file|
          model.upload = file
        end
      else
        model.upload = context.upload_file
      end
    end
  end

  def build_params
    base_params.except(:upload_file, :user)
  end

  def context_key; :batch ; end

  def klazz
    Import::Batch
  end
end
