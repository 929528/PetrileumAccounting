$.fn.my_document = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)

methods =
	init_action: ->
		@this = this
		this.find('a.close').on 'click', =>
			@this.closest('.actions').trigger 'removeAction'
			@this.remove()
		return @this