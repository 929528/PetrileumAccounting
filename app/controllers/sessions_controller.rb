class SessionsController < ApplicationController
	layout 'session'
	def new
		if signed_in?
			redirect_to profile_path, flash: {success: "Добро пожаловать #{current_user.name}"}
		else
			render 'form'
		end
	end
	def create
		user = Catalogs::User.find_by_name session_params[:name]
		unless user 
			user = Catalogs::User.find_by_email session_params[:name]
		end
		if user && user.authenticate(session_params[:password])
			sign_in user
			redirect_to root_path, flash: {success: "Авторизация прошла успешно"} 
		else
			redirect_to root_path, flash: {error: "Ошибка авторизации, неверный логин/пароль"} 
		end
	end
	def destroy
		sign_out
		redirect_to root_url
	end
	def sign_up
		case params[:commit]
		when 'Проверить адрес'
			@customer = Catalogs::Customer.find_by(email: params[:customer][:email])
			if @customer && !@customer.activated?
				render 'password'
			elsif @customer && @customer.activated?
				@customer.errors[:base] << "Ваш аккаунт активирован в системе"
				render partial: 'errors', locals: {item: @customer}
			else
				@customer = Catalogs::Customer.new email: params[:customer][:email]
				render 'error_notice'
			end
		when 'Зарегистрироваться'
			@customer = Catalogs::Customer.find_by_email params[:customer][:email]
			if @customer && !@customer.activated?
				user = Catalogs::User.new
				user.name = @customer.name
				user.email = @customer.email
				user.role = Catalogs::Users::Role.find_by_name 'Guest'
				user.password = params[:customer][:password]
				user.password_confirmation = params[:customer][:password_confirmation]
				if user.save
					@customer.update_attribute :activated, true
					sign_in user 
					render 'success_notice'
				else
					render partial: 'errors', locals: {item: user}
				end
			end
		else
			render 'index'
		end
	end

	private

	def session_params
		params.require(:session).permit(:name, :password)
	end
end