class DocumentsController < ApplicationController
	layout 'journal'
	before_filter :init
	def index documents 
		elements_count = params[:elements_count]
		@documents = documents.all.order('id DESC').offset(elements_count).limit(5)
		respond_to do |format|
			format.html
			format.js {render 'index', status: @documents.empty? ? 204 : 200 }
		end
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
