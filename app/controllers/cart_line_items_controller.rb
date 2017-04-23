class CartLineItemsController < ApplicationController
	before_action :authenticate_user!

	def index
		@cart_line_items = current_user.cart_line_items



	end


	def create
		#################### Without adding an object ##################################
		#CartLineItem.add_or_update(cart_line_item_params.merge({user_id: current_user.id}))
		@cart_line_item = CartLineItem.new(cart_line_item_params)
		@cart_line_item.user_id = current_user.id

		if(@cart_line_item.product.is_sufficient_quantity_available(@cart_line_item.quantity) == true)
			add_update = @cart_line_item.add_or_update
			if(add_update == "updated_cart")
				redirect_to cart_line_items_path, notice: "Successfully updated the Quantity of the Product to Cart"
			elsif add_update == "max_cart"
				redirect_to cart_line_items_path, notice: "Max Items of 5 allowed in the cart for a given product"
			elsif add_update == "added_cart"
				redirect_to cart_line_items_path, notice: "Successfully added the product to the cart"
			end
		else
			redirect_to product_path(@cart_line_item.product), notice: "Insufficient quantity available, Please select lesser quantity"
		end

	end


	def update
		@cart_line_item = CartLineItem.find(params[:id])
		if @cart_line_item.update_attributes(cart_line_item_params)
			redirect_to :back, notice: "Successfully updated the cart"
		end

	end

	def destroy
		@cart_line_item = CartLineItem.find(params[:id])
		@cart_line_item.destroy
		redirect_to cart_line_items_path, notice: "Successfully removed #{@cart_line_item.product.name} from your cart"
	end



	private

	def cart_line_item_params
		params[:cart_line_item].permit(:product_id, :quantity)
	end


end
