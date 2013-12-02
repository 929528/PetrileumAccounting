class Catalogs::Profile < ActiveRecord::Base
	belongs_to :user, polymorphic: true
	has_secure_password
	validates :password, length: {minimum: 6, maximum: 15}
	validates_presence_of :user
	before_save do |profile|
		profile.login = employee? ? user.name : user.email
	end 

	def role
		@role ||= user_type.split('::').last
	end
	def employee?; role == 'Employee' end
	def customer?; role == 'Customer' end

	# def login
	# 	@login ||= (employee?) ? user.name : user.email 
	# end
	def view
		user.name
	end

	def create_remember_token
		self.update_attribute :remember_token, SecureRandom.urlsafe_base64
	end
end