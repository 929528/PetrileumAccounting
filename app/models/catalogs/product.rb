class Catalogs::Product < ActiveRecord::Base

	validates :name, uniqueness: true, presence: true
	validates :symbol, uniqueness: true, presence: true

	def price_for department
		Catalogs::Products::Price.find_or_initialize_by product: self, department: department
	end
end