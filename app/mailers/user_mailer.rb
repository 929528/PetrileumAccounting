class UserMailer < ActionMailer::Base
	default from: "xado.portal@gmail.com"

	def signup customer 
		@customer  = customer 
		@url  = AppConfig['url']
		mail(to: customer.email, subject: "Создан пользователь #{customer.email} в службе Talon-XADO.")
	end
	def reset_password profile
		@user = profile.user
		param = "#{reset_password_path}?token=%s&commit=%s" % [profile.remember_token, 'reset']
		@url = AppConfig['url'] + param
		mail(to: @user.email, subject: "Восстановление пароля")
	end
end