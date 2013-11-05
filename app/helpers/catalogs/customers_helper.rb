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
	def get_talons_on contract
		Catalogs::Talon.where contract: contract, state: Catalogs::Talons::State.find_by_name('issued')
	end
	def progress_bar talon 
		exp = (talon.expires.to_datetime - DateTime.now).to_i
		return (exp / (talon.contract.validity.to_f / 100)).to_i
	end
end