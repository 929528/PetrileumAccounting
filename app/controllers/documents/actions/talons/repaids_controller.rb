class Documents::Actions::Talons::RepaidsController < Documents::Actions::ActionsController
	def new
		talon = Catalogs::Talon.find_or_initialize_by barcode: params[:request][:barcode]
		if talon.valid?
			@repaid = Documents::Actions::Talons::Repaid.new talon_barcode: talon.barcode
			super @repaid
		else
			render partial: 'errors', locals: {item: talon}
		end
	end
end