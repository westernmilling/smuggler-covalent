class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :cached_full_name, :null => false
      t.string :display_name, :null => false
      t.string :name, :null => false
      t.string :contact_name                
      t.string :comments                    
      t.string :reference, :null => false   
      t.string :street_address, :null => false
      t.string :city, :null => false
      t.string :region, :null => false
      t.string :region_code, :null => false
      t.string :country, :null => false
      t.string :roles, :null => false # CSV list of entity roles, we should know what to do with the roles
      t.string :source, :null => false
      t.string :uuid, :limit => 36, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
