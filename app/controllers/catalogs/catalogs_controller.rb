class Catalogs::CatalogsController < ApplicationController
	respond_to :html
	before_filter :initialize_catalog # TODO Придумать что-нить получше
	def index 
		@catalogs = @Catalog.paginate(page: params[:page], per_page: 10)
	end
	def new
		@catalog = @Catalog.new
	end
	def create
		@catalog = @Catalog.new catalog_params
		flash.now[:success] = "#{@Catalog.model_name.human}: #{@catalog.name} создан" if @catalog.save
	end
	def edit
		@catalog = @Catalog.find params[:id]
		@timestamp = params[:timestamp]
	end
	def update
		@catalog = @Catalog.find params[:id]
		flash.now[:success] = "#{@Catalog.model_name.human}: #{@catalog.name} обновлен" if (@catalog.update_attributes catalog_params)
		@timestamp = params[:timestamp]
	end

	private

	def catalog_params
		params.require(@Catalog.model_name.param_key.to_sym).permit @Catalog.strong_params
	end

	def initialize_catalog
		unless (@Catalog = Catalogs.initialize_self_from request.path)
			redirect_to profile_path, 
			flash: {error: "Внутренняя ошибка инициализации справочников. Звони #{AppConfig['admin_phone']}"}
		end
	end
end