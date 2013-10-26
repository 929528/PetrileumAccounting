module Documents::TalonsIssuesHelper
	def buttons
		buttons = []
		buttons << {title: "Создать реализацию талонов", request_path: new_documents_talons_issue_path}
		return buttons
	end
	def setup_form document 
		if document.new_record?
			document.build_contract 
			document.contract.build_customer
		end
		return document
	end
end