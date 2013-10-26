class Documents::Actions::ActionsController < DocumentsController
	def new action
		render partial: (action.valid?? 'new_action' : 'errors'), locals: {item: action}
	end
end