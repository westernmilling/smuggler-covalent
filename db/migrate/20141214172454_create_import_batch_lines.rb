class CreateImportBatchLines < ActiveRecord::Migration
  def change
    create_table :import_batch_lines do |t|
      t.references :import_batch, :null => false
      t.integer :line_number, :null => false
      t.string :purchase_order_number, :limit => 10, :null => false
      t.string :sender, :limit => 12, :null => false
      t.string :status, :limit => 32, :null => false
      t.references :purchase_order
      t.references :purchase_order_line

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
