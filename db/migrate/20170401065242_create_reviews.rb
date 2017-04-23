class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.integer :product_id
      t.integer :user_id
      t.integer :rating

      t.timestamps
    end
  end
end
