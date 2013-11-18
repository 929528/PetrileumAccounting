class Documents::Actions::Talons::RepaidsController < Documents::Actions::ActionsController
	def new
		@repaid = Documents::Actions::Talons::Repaid.new repaid_params
		@repaid.talon.valid? ? (super @repaid.tap {|a| a.send :init}) : 
		(render partial: 'errors', locals: {item: @repaid.talon})
	end

	private

	def repaid_params 
		params.require(:request).require(:data).permit :barcode
	end
end