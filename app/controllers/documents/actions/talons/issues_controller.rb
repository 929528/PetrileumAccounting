class Documents::Actions::Talons::IssuesController < Documents::Actions::ActionsController
	def new
		talon = Catalogs::Talon.find_or_initialize_by barcode: params[:request][:barcode]
		if talon.valid?
			@issue = Documents::Actions::Talons::Issue.new talon_barcode: talon.barcode
			super @issue
		else
			render partial: 'errors', locals: {item: talon}
		end
	end
end