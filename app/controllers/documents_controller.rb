class DocumentsController < ApplicationController
	before_filter :init
	def index documents 
		@documents = documents.paginate(page: params[:page], per_page: 10)
	end
	
	private

	def init
		@timestamp = params[:timestamp]
	end
end
