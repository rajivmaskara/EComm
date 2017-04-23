task :setup_data => :environment do 
	10.times do 
		category = Category.new
		category.name = Faker::Commerce.department(1)
		category.description = Faker::Lorem.paragraph
		category.save
	end

	1000.times do 
		product = Product.new
		product.category_id = Category.all.pluck(:id).sample
		product.name = Faker::Commerce.product_name
		product.description = Faker::Lorem.paragraph
		product.price = Faker::Commerce.price(50..1000)
		product.availability = [true,false].sample
		margin = (-30..30).to_a.sample
		product.base_price = product.price - ((margin*product.price)/100)
		if !(product.availability)
			product.stock = 0
		else
			product.stock = (1..1000).to_a.sample
		end

		product.product_code = product.name[0..2] + Random.rand(100).to_s
		product.save
	end
end