class Catalogs::Customer < ActiveRecord::Base
	has_many :contracts, dependent: :destroy, inverse_of: :customer

	validates :name, presence: true, uniqueness: true
	validates_associated :contracts

	accepts_nested_attributes_for :contracts
end
