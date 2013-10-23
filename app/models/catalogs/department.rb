class Catalogs::Department < ActiveRecord::Base
	belongs_to :organization, inverse_of: :departments

	validates_presence_of :name, :organization
end
