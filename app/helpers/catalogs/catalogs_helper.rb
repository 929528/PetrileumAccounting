module Catalogs::CatalogsHelper
	include CustomersHelper
	def stored_control_panel
		content_for :control_panel do
			render "navigation/top_panel/control_panel", panel: {btn: {add: {title: "Добавить"}}}
		end
	end
end