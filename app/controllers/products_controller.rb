class ProductsController < ApplicationController


	before_action :authenticate_user!, except: [:index, :show]
	before_action :check_is_admin, except: [:index, :show]
	
	def index
		if(!params[:sort])
			@products = Product.all
		elsif params[:sort] == "low-high"
			@products = Product.order('price')
		elsif params[:sort] == "high-low"
			@products = Product.order('price DESC')
		end

	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		if(@product.save)
			redirect_to products_path, notice: "Succesfully created product #{@product.name}"
		else
			render action: "new"
		end
	end

	def show
		@product = Product.find(params[:id])

		@related_products = Product.where('category_id = ? AND price >= ? AND price <= ? AND id != ?',@product.category_id, @product.price - 100, @product.price + 100, @product.id).limit(5)
		#@product.category.products.where()

		@cart_line_item = CartLineItem.new
		@review = Review.new
		@reviews = @product.reviews.all
		
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if(@product.update_attributes(product_params))
			redirect_to product_path(@product), notice: "Successfully updated Product #{@product.name}"
		else
			render action: "edit"
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to products_path, notice: "Product #{@product.name} successfully deleted"
	end



	private

	def product_params
		params[:product].permit(:name, :description, :price, :base_price, :availability, :stock, :category_id, :product_image)
		# Protecting from mass assignment - which is a security feature.
	end


end
