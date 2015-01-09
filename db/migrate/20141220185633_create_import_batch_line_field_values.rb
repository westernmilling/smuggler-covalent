class CreateImportBatchLineFieldValues < ActiveRecord::Migration
  def change
    create_table :import_batch_line_field_values do |t|
      t.references :import_batch, :null => false
      t.references :import_batch_line, :null => false
      t.string :name, :null => false
      t.string :value

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
