module Catalogs::UsersHelper
	def buttons
		buttons = []
		buttons << {title: "Создать пользователя", request_path: new_catalogs_user_path}
		return buttons
	end
end