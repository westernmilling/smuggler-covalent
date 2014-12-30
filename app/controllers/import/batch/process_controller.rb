# Process batch
class Import::Batch::ProcessController < ApplicationController
  respond_to :html

  # PUT /import/batch/:id/process
  def update
    batch = Import::Batch.find(params[:id])

    interactor = Import::ProcessBatch.call(
      :batch_id => batch.id, :user => current_user)

    if interactor.success?
      redirect_with_notice(batch, interactor.message, [batch])
    else
      redirect_with_alert(batch, interactor.message, [batch])
    end
  end
end
