class CatalogsController < ApplicationController
	respond_to :html, :json, :js
	before_filter :init
	def index catalog
		childrens_count = params[:childrens_count]
		@catalogs = catalog.all.limit(20).offset childrens_count
		respond_with @catalogs.pluck :name
	end

	def create catalog, errors = false
		unless errors
			@catalog = catalog
			render 'create'
		else
			render partial: 'errors', locals: {item: catalog}
		end
	end


	private

	def init
		@timestamp = params[:timestamp]
	end
end