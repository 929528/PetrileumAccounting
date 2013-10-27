class Catalogs::Organization < ActiveRecord::Base
	has_many :departments, dependent: :destroy, inverse_of: :organization

	validates_associated :departments
	validates :name, presence: true, uniqueness: true

	accepts_nested_attributes_for :departments
end