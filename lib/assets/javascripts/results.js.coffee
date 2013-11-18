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
				a += "<div class=\"product muted\">#{key}: #{value.count} шт.
					<div class=\"sum\">#{value.sum} грн.</div>
						<div class=\"amount\">#{value.amount} л.</div></div>"
			a += "<div class=\"total pull-right text-right muted\"><span>ИТОГО: талонов: #{count} шт.</span> <span>на сумму: #{sum} грн.</span></div>"
		else
			a = "<div class=\"text-center muted\" style=\"font-size: 1.2em\">ТАЛОНОВ НЕТ</div>"
		results.html(a)
	init_action: ->
		@this = this
		this.find('a.close').on 'click', =>
			results = @this.closest('.actions')
			@this.remove()
			results.trigger 'removeAction'
		return @this