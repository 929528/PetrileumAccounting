class DocumentsController < ApplicationController
	respond_to :html, :js
	before_filter :init
	def index documents 
		childrens_count = params[:childrens_count]
		@documents = documents.all.limit(20).offset childrens_count
	end

	def create document, errors = false
		unless errors
			@document = document
			render 'create'
		else
			render partial: 'errors', locals: {item: document}
		end
	end
	
	private

	def init
		@timestamp = params[:timestamp]
	end
end
