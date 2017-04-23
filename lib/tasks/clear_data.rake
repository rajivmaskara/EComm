task :clear_data => :environment do 
	Product.delete_all
	Category.delete_all
	Vendor.delete_all
end