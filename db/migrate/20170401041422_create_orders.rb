class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number
      t.date :order_date
      t.float :total
      t.integer :user_id

      t.timestamps
    end
  end
end
