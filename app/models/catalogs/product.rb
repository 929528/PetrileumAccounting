class Catalogs::Product < ActiveRecord::Base

	validates :name, uniqueness: true, presence: true
	validates :symbol, uniqueness: true, presence: true

	def self.strong_params
		return [:name, :fullname, :symbol]
	end
end