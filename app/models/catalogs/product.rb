class Catalogs::Product < ActiveRecord::Base

	validates :name, uniqueness: true, presence: true
	validates :symbol, uniqueness: true, presence: true

	def price_for department
		price = Price.find_by product: self, department: department
	end
end