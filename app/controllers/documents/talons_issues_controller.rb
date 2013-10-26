class Documents::TalonsIssuesController < DocumentsController
	def index
		super Documents::TalonsIssue
	end
	def new
		@TalonsIssue = Documents::TalonsIssue.new
		render 'new'
	end
	def create
		render nothing: true
	end
	def create
		p "!!!!!!! #{talons_issue_params}"
		@TalonsIssue = Documents::TalonsIssue.new talons_issue_params
		if @TalonsIssue.save
			flash.now[:success] = "Документ: #{@TalonsIssue} создан!"
			render 'create'
		else 
			render partial: 'errors', locals: {item: @TalonsIssue}
		end
	end
	def edit
		@TalonsIssue = Documents::TalonsIssue.find params[:id]
		render 'edit'
	end
	def update
		@TalonsIssue = Documents::TalonsIssue.find params[:id]
		@TalonsIssue.status = params[:status]
		if @TalonsIssue.update_attributes talons_issue_params
			flash.now[:success] = "Документ: #{@TalonsIssue} обновлен!"
			render 'update'
		else
			render partial: 'errors', locals: {item: @TalonsIssue}
		end
	end

	private

	def talons_issue_params
		params.require(:document).permit(:contract_id, :department, issues_attributes: [:id, :talon_barcode, :price, :expires])
	end
end