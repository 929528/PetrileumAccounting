class Catalogs::Contract < ActiveRecord::Base
	belongs_to :customer, inverse_of: :contracts
	belongs_to :type, class_name: 'Catalogs::ContractType', foreign_key: :contract_type_id
	validates_presence_of :name, :customer
end
