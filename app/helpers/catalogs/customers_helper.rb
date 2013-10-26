module Catalogs::CustomersHelper
 def buttons
 	buttons = []
 	buttons << {title: "Создать контрагента", request_path: new_catalogs_customer_path}
 	return buttons
 end
end