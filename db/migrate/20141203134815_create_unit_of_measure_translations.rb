class CreateUnitOfMeasureTranslations < ActiveRecord::Migration
  def change
    create_table :unit_of_measure_translations do |t|
      t.references :unit_of_measure, :null => false
      t.string :sender_value, :null => false
      t.string :source_field, :null => false
      t.string :source_value, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
