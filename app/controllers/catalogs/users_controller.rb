class Catalogs::UsersController < CatalogsController
	def index
		super Catalogs::User
	end
	def new
		@user = Catalogs::User.new
		render 'new'
	end
	def create
		@user = Catalogs::User.new user_params
		if @user.save
			flash.now[:success] = "Пользователь: #{@user.name} создан!"
			render 'create'
		else
			render partial: 'errors', locals: {item: @user}
		end
	end
	def edit
		@user = Catalogs::User.find params[:id]
		render 'edit'
	end
	def update
		@user = Catalogs::User.find params[:id]
		if @user.update_attributes user_params
			flash.now[:success] = "Продукт: #{@user.name} обновлен!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @user}
		end
	end
	private

	def user_params
		params.require(:user).permit  [:name, :surname, :department_id, :email, :password, :password_confirmation]
	end
end