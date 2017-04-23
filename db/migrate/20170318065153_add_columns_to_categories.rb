class AddColumnsToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :description, :text
  	# add_column :table_name,column_name, type
  end
end
