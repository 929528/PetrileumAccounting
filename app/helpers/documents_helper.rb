module DocumentsHelper
	def stored_control_panel
		content_for :control_panel do
			render "navigation/top_panel/control_panel", buttons: buttons
		end
	end
	def icon bool 
		bool ? 'icon-ok text-error' : 'icon-save text-info' 
	end
end
