class CategoriesController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]
	
	def index
		@categories = Category.all
	end

	def show
		@category = Category.find(params[:id])
		if params[:sort].nil?
			@products = @category.products
		elsif params[:sort] == "low-high"
			@products = @category.products.order('price')
		elsif params[:sort] == "high-low"
			@products = @category.products.order('price DESC')
		end
				
			
	end
		

end
