module Catalogs::CustomersHelper
	def setup_customers_form customer
		customer.contracts.build(name: 'Основной контракт') if customer.new_record?
		return customer
	end
end