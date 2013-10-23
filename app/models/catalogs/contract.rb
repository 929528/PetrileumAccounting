class Catalogs::Contract < ActiveRecord::Base
	belongs_to :customer, inverse_of: :contracts

	validates_presence_of :name, :customer
end
