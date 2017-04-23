class AddColumnsToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :cost_price, :integer
  	rename_column :products, :cost_price, :base_price
  	change_column :products, :base_price, :float
  end
end
