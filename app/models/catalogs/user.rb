class Catalogs::User < ActiveRecord::Base
	belongs_to :department
	belongs_to :role, class_name: 'Users::Role'
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_secure_password

	validates_presence_of :name, :email, :password, :role
	validates :name, length: {maximum: 30, minimum: 4}, uniqueness: true, allow_blank:true
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }, allow_blank:true
	validates :password, length: {minimum: 6, maximum: 15}, allow_blank:true

	before_save do |user|
		user.email.downcase!
		user.send :create_remember_token
	end

	def organization_name; self.try(:department).try(:organization).try :name end

	def employee?
		@employee ||= (self.role.name == "Employee")
	end
	def guest?; !employee? end

	private 

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
