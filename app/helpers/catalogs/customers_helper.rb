module Catalogs::CustomersHelper
	def buttons
		buttons = []
		buttons << {title: "Создать контрагента", request_path: new_catalogs_customer_path}
		return buttons
	end
	def setup_contract contract
		if contract.new_record?
			contract.type = Catalogs::ContractType.find(1) 
			contract.validity = 365
		end
		return contract
	end
	def setup_discount customer, product
		Discount.find_or_initialize_by customer_id: customer.id, product_id: product.id
	end
end