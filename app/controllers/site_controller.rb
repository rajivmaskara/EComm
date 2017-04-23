class SiteController < ApplicationController

	def hello
		@names = ["rajiv","poku"]
	end

	def goodbye
	end

	def categories
		@categories = Category.all
	end

	def products
		if(!params[:sort])
			@products = Product.all
		
		elsif (params[:sort] == "low-high")
			@products = Product.order('price')

		elsif(params[:sort] == "high-low")
			@products = Product.order('price DESC')
		end
			
	end


end
