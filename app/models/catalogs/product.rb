class Catalogs::Product < ActiveRecord::Base

	validates :name, uniqueness: true, presence: true
	validates :symbol, presence: true
end