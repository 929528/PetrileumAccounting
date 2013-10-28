class DocumentsController < ApplicationController
	respond_to :html, :js
	before_filter :init
	def index documents 
		childrens_count = params[:childrens_count]
		@documents = documents.all.limit(20).offset childrens_count
	end
	
	private

	def init
		@timestamp = params[:timestamp]
	end
end
