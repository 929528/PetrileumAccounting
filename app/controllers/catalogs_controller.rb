class CatalogsController < ApplicationController
	layout 'journal'
	before_filter :init
	def index catalog
		elements_count = params[:elements_count]
		@catalogs = catalog.all.offset(elements_count).limit(9)
		respond_to do |format|
			format.html
			format.js {render 'index', status: @catalogs.empty? ? 204 : 200 }
			format.json {render json: catalog.all.pluck(:name)}
		end
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