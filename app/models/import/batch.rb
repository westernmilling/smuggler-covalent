class Import::Batch < ActiveRecord::Base
  belongs_to :created_by, :class => User, :foreign_key => :created_by_user_id

  has_attached_file :upload, :use_timestamp => false

  symbolize :status, :in => [:new]

  validates_attachment_content_type :upload, 
    :content_type => ['text/comma-separated-values', 'text/csv']
  validates_presence_of :status
  validates_presence_of :upload
end
