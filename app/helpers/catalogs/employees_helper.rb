module Catalogs::EmployeesHelper
	def buttons
		buttons = []
		buttons << {title: "Создать пользователя", request_path: new_catalogs_employee_path}
		return buttons
	end
	def setup_form employee 
		if employee.new_record?
			employee.build_department 
			employee.department.build_organization
		end
		return employee
	end
end