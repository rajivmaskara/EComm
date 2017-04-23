class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|

    	t.string :name
    	t.string :company_name
    	t.string :tin_number
    	t.timestamps null: false
    end
  end
end
