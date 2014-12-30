class CreateImportBatchRemarks < ActiveRecord::Migration
  def change
    create_table :import_batch_remarks do |t|
      t.integer :import_batch_id, :null => false
      t.integer :import_batch_line_id, :null => false
      t.string :remark_category, :null => false
      t.string :remark_type, :limit => 32, :null => false
      t.string :remark_message, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
