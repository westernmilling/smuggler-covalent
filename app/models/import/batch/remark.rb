# Represents system remarks for a +Batch+.
# @author Joseph Bridgwater-Rowe
class Import::Batch::Remark < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :batch, :class => Import::Batch, :foreign_key => :import_batch_id
  belongs_to(
    :line,
    :class => Import::Batch::Line,
    :foreign_key => :import_batch_line_id)

  symbolize :remark_type, :in => [:error]

  validates_presence_of :batch
  validates_presence_of :line
  validates_presence_of :remark_message
  validates_presence_of :remark_type
end
