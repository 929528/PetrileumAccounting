class Catalogs::Customer < ActiveRecord::Base
	has_many :contracts, dependent: :destroy, inverse_of: :customer
	has_many :discounts

	validates :name, presence: true, uniqueness: true
	validates_associated :contracts

	accepts_nested_attributes_for :contracts
	accepts_nested_attributes_for :discounts, reject_if: proc { |attributes| attributes['value'].blank? },
	allow_destroy: true

	def get_discount_on product
		Discount.find_by(product_id: product.id, customer_id: self.id)
	end
end