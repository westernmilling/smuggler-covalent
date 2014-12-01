class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user
      t.string    :first_name
      t.string    :last_name
      t.string    :display_name, :null => false
      t.string    :uuid, :limit => 36 # Compact UUID is 32, UUID with hyphens is 36
      t.integer   :is_active
      t.string    :roles # Basic CSV list of roles 

      t.timestamps
    end
  end
end
