class DashboardController < ApplicationController
	before_action :check_is_admin
  
  def index
  	@products = Product.all
  	@categories = Category.all
  	@orders = Order.all
  	@users = User.where('is_admin = ?',false)
  end
end
