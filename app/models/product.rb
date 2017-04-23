class Product < ActiveRecord::Base

	#Associations
	belongs_to :category
	has_many :cart_line_items
	has_many :order_products
	has_many :reviews

	validates_presence_of :category_id, :name, :base_price, :price, :stock
	validates_length_of :description, minimum: 4
	validates_numericality_of :base_price, :price, :stock

	mount_uploader :product_image, ProductImageUploader

	def get_category_name
		if(self.category_id.nil?)
			"N/A"
		else
			Category.find(self.category_id).name
		end
	end

	def is_sufficient_quantity_available(quantity)
		if(self.stock < quantity)
			return false
		else
			return true
		end
	end


end
