class Catalogs::Employee < ActiveRecord::Base
	belongs_to :department
	has_one :profile, as: :user, dependent: :destroy
	accepts_nested_attributes_for :profile
	validates_associated :profile
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates_presence_of :name, :surname, :email
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }, allow_blank:true

	before_save do |employee|
		employee.email.downcase!
	end

	def organization_name; self.try(:department).try(:organization).try :name end

	def view
		Array.new.push(self.try(:surname), self.try(:name), self.try(:lastname)).delete_if {|i| i.nil?}.map {|item, index| item.capitalize}.each_with_index.map {|item, index| (index == 0) ? item : "#{item[0]}." }* ' '
	end
end
