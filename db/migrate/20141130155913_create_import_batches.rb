class CreateImportBatches < ActiveRecord::Migration
  def change
    create_table :import_batches do |t|
      t.attachment :upload
      t.references :user, :null => false
      t.string :status, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
