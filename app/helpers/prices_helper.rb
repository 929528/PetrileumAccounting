module PricesHelper
	def stored_control_panel
		content_for :control_panel do
			render "navigation/top_panel/control_panel"
		end
	end
	def setup_price department, product
		Price.find_or_initialize_by department_id: department.id, product_id: product.id
	end
end
