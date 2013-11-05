class Catalogs::Talons::Amount < ActiveRecord::Base
	validates :value, presence: true, inclusion: {in: [5, 20]}, uniqueness: true
	validates :symbol, presence: true, inclusion: {in: %w(2 5)}, uniqueness: true
end
