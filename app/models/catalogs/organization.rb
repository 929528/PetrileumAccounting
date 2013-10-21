class Catalogs::Organization < ActiveRecord::Base
	has_many :departments, class_name: 'Catalogs::OrganizationDepartment', dependent: :destroy

	accepts_nested_attributes_for :departments

	def self.strong_params
		return [:name, :fullname, departments_attributes: [:id, :name]]
	end
end
