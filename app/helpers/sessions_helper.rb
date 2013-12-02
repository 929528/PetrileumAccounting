module SessionsHelper

	def signed_in?
		!current_profile.nil?
	end
	def current_profile
		@current_profile ||= session[:current_profile_id] ? Catalogs::Profile.find_by_id(session[:current_profile_id]) : nil
	end
	def current_user
		@current_user ||= current_profile.user
	end
	def sign_in profile
		session[:current_profile_id] = profile.id
		self.current_profile = profile
	end
	def current_profile= profile
		@current_profile = profile
	end
	def sign_out
		self.current_profile = nil
		session[:current_profile_id] = nil
	end
	def can_signup? customer
		customer.errors[:base] << "Email пустой" if customer.email.blank?
		customer.errors[:base] << "Пользователь не найден в базе" if !customer.email.blank? && customer.new_record?
		customer.errors[:base] << "Пользователь уже создан" if customer.activated? || customer.profile.present?
		if customer.errors.any?
			false
		else
			true
		end
	end
	def can_reset_password? profile 
		profile.errors[:base] << "Email пустой" if profile.login.blank?
		profile.errors[:base] << "Профиль пользователя не найден" if profile.errors.empty? && profile.new_record?
		# profile.errors[:base] << "Профиль пользователя не найден" if profile.errors.empty? && !profile.customer?
		if profile.errors.any?
			false
		else
			true
		end
	end
end