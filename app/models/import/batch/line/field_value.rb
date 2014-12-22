class Import::Batch::Line::FieldValue < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :batch, :class => Import::Batch, :foreign_key => :import_batch_id
  belongs_to :line, :class => Import::Batch::Line, :foreign_key => :import_batch_line_id

  validates_presence_of :batch
  validates_presence_of :line
  validates_presence_of :name
  validates_presence_of :value
end
