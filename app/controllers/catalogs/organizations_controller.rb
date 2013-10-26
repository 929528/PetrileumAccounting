class Catalogs::OrganizationsController < CatalogsController
	def index
		super Catalogs::Organization
	end
	def new
		@organization = Catalogs::Organization.new.tap {|organization| organization.departments.build name: 'Основное подразделение'}
		render 'new'
	end
	def create
		@organization = Catalogs::Organization.new organization_params
		if @organization.save
			flash.now[:success] = "Организация: #{@organization.name} создана!"
			render 'create'
		else
			render partial: 'errors', locals: {item: @organization}
		end
	end
	def edit
		@organization = Catalogs::Organization.find params[:id]
		render 'edit'
	end
	def update
		@organization = Catalogs::Organization.find params[:id]
		if @organization.update_attributes organization_params
			flash.now[:success] = "Организация: #{@organization.name} обновлена!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @organization}
		end
	end
		def new_department
		department = Catalogs::Department.new name: 'Новое подразделение'
		@id = Time.now.to_i
		render partial: 'add_tab', locals: {item: department}
	end
	private

	def organization_params
		params.require(:organization).permit  :name, :fullname, departments_attributes: [:id, :name]
	end
end