class Import::Batch < ActiveRecord::Base
  belongs_to :user

  has_attached_file :upload, :use_timestamp => false

  symbolize :status, :in => [:new]

  validates_attachment_content_type :upload, 
    :content_type => ['text/comma-separated-values', 'text/csv']
  validates_presence_of :status
  validates_presence_of :upload
end
