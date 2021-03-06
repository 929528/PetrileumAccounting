class Documents::Actions::Talons::IssuesController < Documents::Actions::ActionsController
	def new
		@issue = Documents::Actions::Talons::Issue.new issue_params
		@issue.talon.valid? ? (super @issue.tap {|a| a.send :init}) : 
		(render partial: 'errors', locals: {item: @issue.talon})
	end

	private

	def issue_params
		params.require(:request).require(:data).permit :department, :barcode, :contract
	end
end