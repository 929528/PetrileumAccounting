module Documents::TalonsRepaidsHelper
	def buttons
		buttons = []
		buttons << {title: "Создать погашение талонов", request_path: new_documents_talons_repaid_path}
		return buttons
	end
end