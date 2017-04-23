class OrdersController < ApplicationController

	before_action :authenticate_user!

	def create
		@order = Order.new
		@order.user_id = current_user.id
		if @order.save
			#redirect_to root_path, notice: "Successfully created Order"
			redirect_to order_path(@order), notice: "Successfully added Order"
		end
	end

	def index
		@orders = current_user.orders
	end


	def show
		@order = Order.find(params[:id])
	end


end
