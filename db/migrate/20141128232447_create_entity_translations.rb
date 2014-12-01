class CreateEntityTranslations < ActiveRecord::Migration
  def change
    create_table :entity_translations do |t|
      t.references :entity, :null => false
      t.string :sender_value, :null => false
      t.string :source_field, :null => false
      t.string :source_value, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
