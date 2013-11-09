$.fn.results = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)
methods =
	init: ->
		@this = this
		talons = []
		this.find('.action').each ->
			talon = $(this).data()
			talons.push talon
		results = this.closest('.body').find('.results')
		products = {}
		for talon in talons
			products[talon.product]['price'] = 1
		console.log products
