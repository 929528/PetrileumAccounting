module Catalogs::OrganizationsHelper
	def buttons
		buttons = []
		buttons << {title: "Создать организацию", request_path: new_catalogs_organization_path}
		return buttons
	end
end