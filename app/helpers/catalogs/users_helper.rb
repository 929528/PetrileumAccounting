module Catalogs::UsersHelper
	def buttons
		buttons = []
		buttons << {title: "Создать пользователя", request_path: new_catalogs_user_path}
		return buttons
	end
	def setup_form user 
		if user.new_record?
			user.build_department 
			user.department.build_organization
		end
		return user
	end
end