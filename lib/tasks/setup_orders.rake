task :setup_orders => :environment do 
	50.times do 
		user = User.new
		user.username = Faker::Name.name
		user.email = Faker::Internet.free_email(user.username)
		user.password = "secret123"
		user.save

		Random.rand(2..7).times do
			order = Order.new
			Random.rand(1..5).times do
				cart = CartLineItem.new
				cart.user_id = user.id
				cart.product_id = Product.all.pluck(:id).sample
				cart.quantity = Random.rand(1..3)
				cart.save
			end
			order.order_number = "DCT = #{Random.rand(10..10000)}"
			order.order_date = Faker::Date.between(Date.parse("2015-01-01"), Date.today)
			order.user_id = user.id
			order.save

		end


	end


	
end