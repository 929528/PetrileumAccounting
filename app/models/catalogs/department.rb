class Catalogs::Department < ActiveRecord::Base
	belongs_to :organization, inverse_of: :departments

	validates_presence_of :name, :organization

	def get_price_on product
		Price.find_by(product_id: product.id, department_id: self.id)
	end
end
