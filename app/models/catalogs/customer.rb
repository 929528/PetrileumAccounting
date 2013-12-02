class Catalogs::Customer < ActiveRecord::Base
	has_many :contracts, dependent: :destroy, inverse_of: :customer
	has_many :discounts
	has_one :profile, as: :user, dependent: :destroy
	accepts_nested_attributes_for :profile
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, uniqueness: true
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }, allow_blank:true
	validates_associated :contracts
	validate :check_email, on: :update

	before_save do |customer|
		customer.email.downcase! if customer.email?
		customer.fullname = customer.name if customer.fullname.blank?
	end

	accepts_nested_attributes_for :contracts
	accepts_nested_attributes_for :discounts, reject_if: proc { |attributes| attributes['value'].blank? },
	allow_destroy: true

	def get_discount_on product
		Discount.find_by(product_id: product.id, customer_id: self.id)
	end

	private

	def check_email
		errors[:base] << "Нельзя менять адрес электронной почты у активированного пользователя" if self.activated? && (self.email != Catalogs::Customer.find(self).email)
	end
end