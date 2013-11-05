module PricesHelper
	def stored_control_panel
		content_for :control_panel do
			render "navigation/top_panel/control_panel"
		end
	end
	def setup_price department, product
		Price.find_or_initialize_by department_id: department.id, product_id: product.id
	end

	def get_previous_record record
		PriceRecord.where(price_id: record.price.id, created_at: Time.at(AppConfig['release_date'].to_i)...(record.created_at)).last
	end
end
