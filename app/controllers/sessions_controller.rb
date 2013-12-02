class SessionsController < ApplicationController
	layout 'session'
	def new
		if signed_in?
			if current_profile.employee?
				flash[:success] = "Добро пожаловать %s" % current_user.view
				redirect_to employee_profile_path
			elsif current_profile.customer?
				flash.now[:success] = "Добро пожаловать %s" % current_user.name
				redirect_to customer_profile_path
			end
		else
			render 'signin_form'
		end
	end
	def create
		if (profile = Catalogs::Profile.find_by_login session_params[:login]) && (profile.authenticate session_params[:password])
			sign_in profile
			flash.now[:success] = "Авторизация клиента прошла успешно"
			redirect_to root_path 
		else
			flash[:error] = "Ошибка авторизации клиента, неверный логин/пароль"
			render 'signin_form'
		end
	end
	def destroy
		sign_out
		redirect_to root_url
	end
	def signup
		if params[:commit] == 'return'
			session[:customer_id] = nil
			render 'signin'
		elsif params.try(:[],:customer).try(:[],:email) && (customer = Catalogs::Customer.find_or_initialize_by_email params[:customer][:email])
			if can_signup? customer
				session[:customer_id] = customer.id
				render js: "accordion_show('#collapsePassword')"
			else
				render partial: 'errors', locals: {item: customer}
			end
		elsif session[:customer_id] && (customer = Catalogs::Customer.find_by id: session[:customer_id])
			customer.build_profile profile_password_params
			if customer.save
				session[:customer_id] = nil
				UserMailer.signup(customer).deliver
				render js: "accordion_show('#collapseDone')"
			else
				render partial: 'errors', locals: {item: customer}
			end
		else
			render 'signup'
		end
	end

	def reset_password
		if params[:commit] == 'return'
			session[:profile_id] = nil
			render 'signin'
		elsif params.try(:[],:profile).try(:[],:login) && (profile = Catalogs::Profile.find_or_initialize_by login: params[:profile][:login])
			if can_reset_password? profile
				profile.create_remember_token
				UserMailer.reset_password(profile).deliver
				render js: "accordion_show('#collapseDone')"
			else
				render partial: 'errors', locals: {item: profile}
			end
		elsif params[:token] 
			if profile = (Catalogs::Profile.find_by_remember_token params[:token])
				profile.update_attribute :remember_token, nil
				session[:profile_id] = profile.id
				render 'new_password_form'
			else
				flash.now[:error] = "Произошла ошибка при востановлении пароля"
				render 'signin_form'
			end
		elsif session[:profile_id] && (profile = Catalogs::Profile.find_by id: session[:profile_id])
			profile.assign_attributes profile_password_params
			if profile.save
				session[:profile_id] = nil
				render js: "accordion_show('#collapseDone')"
			else
				render partial: 'errors', locals: {item: profile}
			end
		else
			session[:profile_id] = nil
			render 'reset_password'
		end
		# case params[:commit]
		# when 'Далее'
		# 	customer = Catalogs::Customer.find_or_initialize_by_email params[:customer][:email]
		# 	if can_reset_password? customer
		# 		customer.profile.create_remember_token
		# 		UserMailer.reset_password(customer.profile).deliver
		# 		render js: "$('#accordion').find('.accordion-body').collapse('hide');$('#collapseDone').collapse('show')"
		# 	else
		# 		render partial: 'errors', locals: {item: customer}
		# 	end
		# when 'return'
		# 	render 'signin'
		# when 'reset'
		# 	if profile = Catalogs::Profile.find_by_remember_token(params[:token])
		# 		@customer = profile.user
		# 		session[:profile_id] = profile.id
		# 		profile.update_attribute :remember_token, nil
		# 		render 'new_password_form'
		# 	else
		# 		render 'signin_form'
		# 	end
		# when 'Подтвердить'
		# 	if session[:profile_id] && (profile = Catalogs::Profile.find_by id: session[:profile_id], remember_token: params[:token])
		# 		profile.assign_attributes customer_password_params[:profile_attributes]
		# 		if profile.save
		# 			session[:profile_id] = nil
		# 			render js: "$('#accordion').find('.accordion-body').collapse('hide');$('#collapseDone').collapse('show')"
		# 		else
		# 			render partial: 'errors', locals: {item: profile}
		# 		end
		# 	else
		# 		render 'signin_form'
		# 	end
		# else
		# 	render 'reset_password'
		# end
	end
	private

	def session_params
		params.require(:session).permit(:login, :password, :remember_me)
	end
	def profile_password_params
		params.require(:profile_attributes).permit :password, :password_confirmation
	end
end