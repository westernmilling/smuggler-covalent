class Import::BatchesController < ApplicationController
  respond_to(:html)

  before_filter :build_batch, :only => [:create, :new]
  before_filter :load_batch, :only => [:destroy, :show]

  def create
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

  def destroy
    if @import_batch.destroy
      notice_redirect(@import_batch, 'Batch deleted', [:import_batches])
    else
      alert_redirect(@import_batch, 'Failed to delete batch', [:import_batches])
    end
  end

  def index
    @import_batches = Import::Batch.all
  end

  def new; end

  def show; end

  protected

  def batch_params
    params.require(:import_batch_input).permit(:upload_file)
  rescue ActionController::ParameterMissing; {}
  end

  def build_batch
    @import_batch_input = Import::BatchInput.new(batch_params)
  end

  def load_batch
    @import_batch = Import::Batch.find(params[:id])
  end

end
