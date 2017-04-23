class CartLineItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :product

	# When we have created an object in the controller and passing the cart directly to the model
	#This function returns three values : 
	#"updated_cart" : When a product exists in a cart and the same is added to the cart and the total quantity is below the limit
	#"max_cart" : When a product exists in a cart and the same is added to the cart but the limit of 5 has been reached
	#"added_cart" : When a product does not exist in the cart and a new line item is created
	def add_or_update
		success = ""

		user = self.user
		
		if user.cart_line_items.pluck(:product_id).include? self.product_id
			line_item = user.cart_line_items.find_by_product_id(self.product_id)
			if ((line_item.quantity + self.quantity)<=5)
				line_item.update_attributes(quantity: line_item.quantity + self.quantity)
				success = "updated_cart"
			else
				line_item.update_attributes(quantity: 5)
				success = "max_cart"
			end

		else
			self.save
			success = "added_cart"
		end
		return success
	end

	# When we have not created an object in the controller and passing the cart directly to the model
	# This is a class method for CartLineItem
	def self.add_or_update(cart_line_item)
		user = User.find(cart_line_item["user_id"])

		if user.cart_line_items.pluck(:product_id).include? cart_line_item[:product_id]

			line_item = user.cart_line_items.find_by_product_id(cart_line_item[:product_id])
			line_item.update_attributes(quantity: line_item.quantity + cart_line_item[:quantity])
		else 
			CartLineItem.create(cart_line_item)
		end
	end
end
