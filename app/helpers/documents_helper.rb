module DocumentsHelper
	def stored_control_panel
		content_for :control_panel do
			render "navigation/top_panel/control_panel", panel: {btn: {add: {title: "Добавить", path: "#{@Document.model_name.route_key}/new"}}}
		end
	end
end
