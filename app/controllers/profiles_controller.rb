class ProfilesController < ApplicationController
	layout :user_layout
	def show
		if current_user.employee?
			render 'employee'
		elsif current_user.guest? && (@customer = Catalogs::Customer.find_by_email(current_user.email))
			render 'catalogs/customers/workplace'
		end
	end

	private

	def user_layout
		current_user.employee? ? 'application' : 'session'
	end
end