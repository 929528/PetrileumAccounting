class Catalogs::User < ActiveRecord::Base
	belongs_to :department
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_secure_password

	validates_presence_of :name, :email, presence: true
	validates :name, length: {maximum: 30, minimum: 4}, uniqueness: true, allow_blank:true
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }, allow_blank:true
	validates :password, length: {minimum: 6, maximum: 15}, allow_blank:true

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
