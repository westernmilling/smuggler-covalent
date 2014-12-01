# Import Batch upload input model.
# 
# We'll use this to validate the form details before invoking an interactor.
class Import::BatchInput
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :upload_file, String

  validates_presence_of :upload_file
  # REVIEW: Do we want/need to validate the upload_file 
  # In which case verify it should be a ActionDispatch::Http::UploadedFile?

end