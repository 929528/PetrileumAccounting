class Catalogs::Customer < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	has_many :contracts, class_name: 'Catalogs::CustomerContract', dependent: :destroy, inverse_of: :customer

	accepts_nested_attributes_for :contracts

	def self.strong_params
		return [:name, :fullname, contracts_attributes: [:id, :name, :def]]
	end
end
