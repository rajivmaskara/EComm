class ReviewsController < ApplicationController

	before_action :authenticate_user!

	def new
		@review = Review.new
		@product = Product.find(params[:product_id])
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@product = Product.find(params[:product_id])
		if(@review.save)
			redirect_to product_path(@review.product), notice: "Thank You for adding a review"
		else
			render action: "new"	
		end



	end

	private

	def review_params
		params[:review].permit(:title, :body, :product_id, :rating)
	end

end
