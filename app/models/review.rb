class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :product

	validates_presence_of :title, :user_id, :product_id, :rating
	validates_numericality_of :rating
end
