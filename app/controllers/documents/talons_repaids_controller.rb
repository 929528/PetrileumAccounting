class Documents::TalonsRepaidsController < DocumentsController
	def index
		super Documents::TalonsRepaid
	end
	def new
		@TalonsRepaid = Documents::TalonsRepaid.new
		render 'new'
	end
	def create
		@TalonsRepaid = Documents::TalonsRepaid.new talons_repaid_params
		@TalonsRepaid.department = current_user.department
		@TalonsRepaid.user = current_user
		if @TalonsRepaid.save
			flash.now[:success] = "Документ: #{@TalonsRepaid} создан!"
			render 'create'
		else 
			render partial: 'errors', locals: {item: @TalonsRepaid}
		end
	end
	def edit
		@TalonsRepaid = Documents::TalonsRepaid.find params[:id]
		render 'edit'
	end
	def update
		@TalonsRepaid = Documents::TalonsRepaid.find params[:id]
		@TalonsRepaid.user = current_user
		@TalonsRepaid.status = params[:status]
		if @TalonsRepaid.update_attributes talons_repaid_params
			flash.now[:success] = "Документ: #{@TalonsRepaid} обновлен!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @TalonsRepaid}
		end
	end

	private

	def talons_repaid_params
		params.require(:document).permit :department, repaids_attributes: [:id, :talon_barcode, :price]
	end
end