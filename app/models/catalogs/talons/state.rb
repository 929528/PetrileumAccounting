class Catalogs::Talons::State < ActiveRecord::Base
	validates :name, presence: true, inclusion: {in: %w(new issued repaid)}, uniqueness: true
end
