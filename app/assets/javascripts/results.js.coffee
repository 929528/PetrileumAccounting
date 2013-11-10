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
		sum = 0
		count = 0
		for talon in talons
			if !products[talon.product]
				product = {sum: 0, amount: 0, count: 0}
				products[talon.product] = product
			products[talon.product].amount += talon.amount
			products[talon.product].sum += talon.price*talon.amount
			++ products[talon.product].count
			sum += talon.price * talon.amount
			++ count
		if Object.keys(products).length != 0
			a = ''
			for key, value of products
				a += "<div class=\"product #{key}\">#{key}: #{value.count}
					<div class=\"sum\">#{value.sum}</div>
						<div class=\"amount\">#{value.amount}</div>
							</div>"
		else
			a = 'талонов нет'
		results.html(a)
		# console.log products