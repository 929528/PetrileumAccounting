class Documents::TalonsIssuesController < DocumentsController
	def index
		super Documents::TalonsIssue
	end
	def new
		@TalonsIssue = Documents::TalonsIssue.new department: current_user.department
		render 'new'
	end
	def create
		@TalonsIssue = Documents::TalonsIssue.new talons_issue_params
		@TalonsIssue.user = current_user
		@TalonsIssue.status = params[:status]
		if @TalonsIssue.save
			flash.now[:success] = "Документ: #{@TalonsIssue} создан!"
			super @TalonsIssue
		else 
			super @TalonsIssue, errors = true
		end
	end
	def edit
		@TalonsIssue = Documents::TalonsIssue.find params[:id]
		render 'edit'
	end
	def update
		@TalonsIssue = Documents::TalonsIssue.find params[:id]
		@TalonsIssue.user = current_user
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
		params.require(:document).permit(:contract_id, :department_id, issues_attributes: [:id, :barcode, :price, :expires])
	end
end