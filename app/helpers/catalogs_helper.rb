module CatalogsHelper
	def stored_control_panel
		content_for :control_panel do
			render "navigation/top_panel/control_panel", panel: {btn: {add: {title: "Добавить", path: "#{@Catalog.model_name.route_key}/new"}}}
		end
	end
end