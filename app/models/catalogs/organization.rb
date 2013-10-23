class Catalogs::Organization < ActiveRecord::Base
	has_many :departments, dependent: :destroy, inverse_of: :organization

	validates_associated :departments
	validates :name, presence: true, uniqueness: true

	accepts_nested_attributes_for :departments

	after_initialize {|organization| organization.departments.build(name: 'Новое подразделение') if organization.new_record?}

	def self.strong_params
		return [:name, :fullname, departments_attributes: [:id, :name]]
	end
end