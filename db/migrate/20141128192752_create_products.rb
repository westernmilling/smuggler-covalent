class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :display_name, :null => false
      t.string :name, :null => false
      t.string :reference, :null => false
      t.string :source, :null => false
      t.string :uuid, :limit => 36, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
