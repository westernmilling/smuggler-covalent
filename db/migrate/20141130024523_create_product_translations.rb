class CreateProductTranslations < ActiveRecord::Migration
  def change
    create_table :product_translations do |t|
      t.references :product, :null => false
      t.string :sender_value, :null => false
      t.string :source_field, :null => false
      t.string :source_value, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
