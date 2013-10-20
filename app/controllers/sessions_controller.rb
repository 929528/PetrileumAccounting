class SessionsController < ApplicationController
	def new
		if signed_in?
			redirect_to profile_path, flash: {success: "Добро пожаловать #{current_user.name}"}
		else
			render 'new'
		end
	end
	def create
		user = Catalogs::User.find_by_name session_params[:name]
		if user && user.authenticate(session_params[:password])
			sign_in user
			redirect_to profile_path, flash: {success: "Авторизация прошла успешно"} 
		else
			flash.now[:error] = "Ошибка авторизации, неверный логин/пароль"
			render 'new'
		end
	end
	def destroy
		sign_out
		redirect_to root_url
	end

	private

	def session_params
		params.require(:session).permit(:name, :password)
	end
end