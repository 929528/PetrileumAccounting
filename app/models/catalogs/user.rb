class Catalogs::User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_secure_password

	validates :name , length: {maximum: 30, minimum: 4}, uniqueness: true
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }

	before_save do |user|
		user.email.downcase!
		user.send :create_remember_token
	end

	private 

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
