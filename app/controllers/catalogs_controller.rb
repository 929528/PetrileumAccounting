class CatalogsController < ApplicationController
	before_filter :initialize_catalog # TODO Придумать что-нить получше

	def index 
		@catalogs = @Catalog.paginate(page: params[:page], per_page: 10)
	end
	def new
		catalog = @Catalog.new
		@timestamp = params[:timestamp]
		render partial: 'media/js/new', locals: {item: catalog}
	end
	def create
		catalog = @Catalog.new catalog_params
		@timestamp = params[:timestamp]
		if catalog.save
			flash.now[:success] = "#{@Catalog.model_name.human}: #{catalog.name} создан"
			render partial: 'media/js/create', locals: {item: catalog}
		else
			render partial: 'media/js/errors', locals: {item: catalog}
		end
	end
	def edit
		catalog = @Catalog.find params[:id]
		@timestamp = params[:timestamp]
		render partial: 'media/js/edit', locals: {item: catalog}
	end
	def update
		catalog = @Catalog.find params[:id]
		@timestamp = params[:timestamp]
		if catalog.update_attributes catalog_params
			flash.now[:success] = "#{@Catalog.model_name.human}: #{catalog.name} обновлен"
			render partial: 'media/js/update', locals: {item: catalog}
		else
			render partial: 'media/js/errors', locals: {item: catalog}
		end
	end
	def add_departments
		catalog = Catalogs::Department.new name: 'Новое подразделение'
		@id = Time.now.to_i
		@timestamp = params[:timestamp]
		render partial: 'media/js/add_tab', locals: {item: catalog}
	end
	def add_contracts
		catalog = Catalogs::Contract.new name: 'Новый договор'
		@id = Time.now.to_i
		@timestamp = params[:timestamp]
		render partial: 'media/js/add_tab', locals: {item: catalog}
	end

	private

	def catalog_params
		params.require(@Catalog.model_name.param_key.to_sym).permit @Catalog.strong_params
	end

	def initialize_catalog
		str, params = request.path.split('?')
		model_name = str.split('/')[1]
		@Catalog = Catalogs::KNOWN_CATALOGS.find\
		{|i| i.model_name.route_key == model_name}
		unless (@Catalog)
			redirect_to profile_path, 
			flash: {error: "Внутренняя ошибка инициализации справочников. Звони #{AppConfig['admin_phone']}"}
		end
	end
end