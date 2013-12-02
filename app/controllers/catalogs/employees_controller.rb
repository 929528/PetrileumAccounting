class Catalogs::EmployeesController < CatalogsController
	def index
		super Catalogs::Employee
	end
	def new
		@employee = Catalogs::Employee.new
		render 'new'
	end
	def create
		@employee = Catalogs::Employee.new employee_params
		if @employee.save
			flash.now[:success] = "Пользователь: #{@employee.name} создан!"
			super @employee
		else
			super @employee, errors = true
		end
	end
	def edit
		@employee = Catalogs::Employee.find params[:id]
		render 'edit'
	end
	def update
		@employee = Catalogs::Employee.find params[:id]
		if @employee.update_attributes employee_params
			flash.now[:success] = "Продукт: #{@employee.name} обновлен!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @employee}
		end
	end
	private

	def employee_params
		params.require(:employee).permit  [:name, :surname, :department_id, :email, :password, :password_confirmation]
	end
end