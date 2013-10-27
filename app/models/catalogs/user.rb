class Catalogs::User < ActiveRecord::Base
	belongs_to :department
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_secure_password

	validates :name, presence: true, length: {maximum: 30, minimum: 4}, uniqueness: true
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: {minimum: 6, maximum: 15}
	validates :password_confirmation, presence: true

	before_save do |user|
		user.email.downcase!
		user.send :create_remember_token
	end

	def organization_name
		self.department.organization.name
	end

	private 

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
