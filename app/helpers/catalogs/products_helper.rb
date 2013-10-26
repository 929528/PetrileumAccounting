module Catalogs::ProductsHelper
	def buttons
		buttons = []
		buttons << {title: "Создать продукт", request_path: new_catalogs_product_path}
		return buttons
	end
end