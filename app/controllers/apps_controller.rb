class AppsController < ApplicationController
	respond_to :html, :json
	def new_customer_contract
		@customer = (params[:customer_id].present?)? Catalogs::Customer.find(params[:customer_id]) :
		Catalogs::Customer.new
		@contract = @customer.contracts.build name: 'Новый договор'
		@id = Time.now.to_i
	end
	def new_organization_department
		@organization = (params[:organization_id].present?)? Catalogs::Organization.find(params[:organization_id]) :
		Catalogs::Organization.new
		@department = @organization.departments.build name: 'Новое подразделение'
		@id = Time.now.to_i
	end
end