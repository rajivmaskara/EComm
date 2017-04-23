class Order < ActiveRecord::Base

	belongs_to :user
	has_many :order_products

	#Call Back

	before_save :generate_initial_order_details
	after_save :copy_cart_line_items_to_order_products
	after_save :delete_cart_line_items
	#after_save :send_order_confirmation_email

	def generate_initial_order_details
		self.order_number = "DCT - #{Random.rand(10..500)}"
		#self.order_date = Date.today
		self.total = calculate_order_total 
	end

	def copy_cart_line_items_to_order_products
		self.user.cart_line_items.each do |line_item|
			order_product = OrderProduct.new
			order_product.order_id = self.id
			order_product.product_id = line_item.product_id
			order_product.quantity = line_item.quantity
			order_product.price = line_item.product.price
			order_product.save
		end
	end

	def delete_cart_line_items
		CartLineItem.where('user_id = ?', self.user_id).delete_all
	end

	def send_order_confirmation_email
		Notification.order_confirmation(self).deliver
	end



	private

	def calculate_order_total
		total = 0
		self.user.cart_line_items.each do |line_item|
			total+= line_item.quantity * line_item.product.price
		end
		return total
	end



end
