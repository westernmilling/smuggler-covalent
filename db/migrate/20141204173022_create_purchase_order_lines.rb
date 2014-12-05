class CreatePurchaseOrderLines < ActiveRecord::Migration
  def change
    create_table :purchase_order_lines do |t|
      t.references :purchase_order, :null => false
      t.integer :line_number, :null => false      
      t.references :product, :null => false
      t.integer :quantity, :null => false
      t.decimal :unit_price, :null => false, :scale => 4, :precision => 13
      t.references :unit_of_measure, :null => false
      
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
