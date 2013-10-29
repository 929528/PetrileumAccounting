module CatalogsHelper
	def stored_control_panel
		content_for :control_panel do
			render "navigation/top_panel/control_panel", buttons: buttons 
		end
	end
end