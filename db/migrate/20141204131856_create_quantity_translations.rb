class CreateQuantityTranslations < ActiveRecord::Migration
  def change
    create_table :quantity_translations do |t|
      t.string :sender_value, :null => false
      t.string :expression, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
