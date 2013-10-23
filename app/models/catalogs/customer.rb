class Catalogs::Customer < ActiveRecord::Base
	has_many :contracts, dependent: :destroy, inverse_of: :customer

	validates :name, presence: true, uniqueness: true
	validates_associated :contracts

	accepts_nested_attributes_for :contracts

	after_initialize {|customer| customer.contracts.build(name: 'Новый договор') if customer.new_record?}

	def self.strong_params
		return [:name, :fullname, contracts_attributes: [:id, :name, :def]]
	end
end
