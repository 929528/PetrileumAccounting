class CatalogsController < ApplicationController
	respond_to :html, :json
	before_filter :init
	def index catalog
		@catalogs = catalog.paginate(page: params[:page], per_page: 10)
		respond_with @catalogs.pluck :name
	end

	private

	def init
		@timestamp = params[:timestamp]
	end
end