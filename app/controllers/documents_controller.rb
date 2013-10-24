class DocumentsController < ApplicationController
	before_filter :initialize_document 
	def index 
		@documents = @Document.paginate(page: params[:page], per_page: 10)
	end
	def new
		document = @Document.new
		render partial: 'media/js/new', locals: {item: document}
	end
	def create
		document = @Document.new document_params
		document.status = params[:status]
		if document.save
			flash.now[:success] = "#{@Document.model_name.human}: #{document} создан"
			render partial: 'media/js/create', locals: {item: document}
		else
			render partial: 'media/js/errors', locals: {item: document}
		end
	end
	def update
		document = @Document.find params[:id]
		document.status = params[:status]
		if document.valid? && document.update_attributes(document_params)
			flash.now[:success] = "#{@Document.model_name.human}: #{document} обновлен"
			render partial: 'media/js/update', locals: {item: document}
		else
			render partial: 'media/js/errors', locals: {item: document}
		end
	end
	def edit
		document = @Document.find params[:id]
		render partial: 'media/js/edit', locals: {item: document}
	end
	def new_actions
		document = @Document.new
		@action = document.actions.build talon_barcode: params[:request][:barcode]
		unless @action.valid?
			render partial: 'media/js/errors', locals: {item: @action}
		end
	end
	
	private

	def document_params
		params.require(:document).permit @Document.strong_params
	end

	def initialize_document
		@timestamp = params[:timestamp]
		str, params = request.path.split('?')
		model_name = str.split('/')[1]
		unless @Document = Documents::KNOWN_DOCUMENTS.find {|i| i.model_name.route_key == model_name}
			redirect_to profile_path, 
			flash: {error: "Внутренняя ошибка инициализации документов. Звони #{AppConfig['admin_phone']}"}
		end
	end
end
