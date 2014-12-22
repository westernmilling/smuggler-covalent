class Import::BatchesController < ApplicationController
  respond_to(:html)

  def create
    @import_batch_input = Import::BatchInput.new(batch_params)

    if @import_batch_input.valid?
      context = Import::CreateBatch.call(
        :upload_file => @import_batch_input.upload_file,
        :user => current_user)

      if context.success?
        notice_redirect(context.batch, context.message, [context.batch])
      else
        render :new
      end
    else
      render :new
    end
  end

  def index
    @import_batches = Import::Batch.all
  end

  def new
    @import_batch_input = Import::BatchInput.new
  end

  def show
    @import_batch = Import::Batch.find(params[:id])
  end

  protected

  def batch_params
    params.require(:import_batch_input).permit(:upload_file)
  rescue ActionController::ParameterMissing ; {}
  end

end
