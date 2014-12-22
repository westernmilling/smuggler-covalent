class CreateImportBatches < ActiveRecord::Migration
  def change
    create_table :import_batches do |t|
      # t.integer :created_by_user_id, :null => false
      t.string :status, :null => false
      t.attachment :upload

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
