module Catalogs::OrganizationsHelper
	def setup_organizations_form organization
		organization.departments.build(name: 'Основное подразделение') if organization.new_record?
		return organization
	end
end