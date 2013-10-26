$.fn.autocomplete = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)

methods = 
	init: ->
		that = this
		target = $(this.data 'target')
		update = this.data 'update'
		that.attr 'placeholder', 'Инициализация...'
		path = this.data 'source'
		$.getJSON path,
			name: 'sdf'
		.done (data) ->
			items = []
			for val in data
				items.push val
			that.attr 'placeholder', 'Введите имя клиента'
			that.typeahead
				source: items
				updater: (item) ->
					if target
						$.getJSON update,
							name: item
						.done (data) ->
							target.empty()
							for val in data
								target.append $('<option>',
									selected: 'selected' if val.def
									value: val.id
									text: val.name)
					return item