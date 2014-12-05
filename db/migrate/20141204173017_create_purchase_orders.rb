class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.datetime :date, :null => false
      t.integer :ship_to_entity_id, :null => false
      t.string :number, :null => false
      t.datetime :earliest_request_date, :null => false
      t.datetime :latest_request_date, :null => false
      t.string :status, :limit => 32, :null => false
      t.references :user, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
