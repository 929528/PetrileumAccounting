class Catalogs::Product < ActiveRecord::Base
	has_many :talons
	validates :name, uniqueness: true, presence: true
	validates :symbol, presence: true
end