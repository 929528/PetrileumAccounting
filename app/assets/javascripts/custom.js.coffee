$ ->
	$('#flash_notice').autohide(1000)

	$('#list > li.media').media('init')

	$('#list .media-window').on 'show', ->
		$(this).closest('.media').addClass('active')
	$('#list .media-window').on 'hide', ->
		$(this).closest('.media').removeClass('active')

	$('.media-window').on 'show', ->
		that = $(this)
		that.find(".barcode input").on 'keypress', (event) ->
			if event.which == 13
				that.media 'request', $(this).data('path'), barcode: $(this).val()
				$(this).val ''

		that.find('input[data-provide="typeahead"]').autocomplete 'init'


		# 	that = $(this)
		# 	target = $($(this).data 'target')
		# 	update = $(this).data 'update'
		# 	that.attr 'placeholder', 'Инициализация...'
		# 	path = $(this).data 'source'
		# 	$.getJSON path,
		# 		name: 'sdf'
		# 	.done (data) ->
		# 		items = []
		# 		for val in data
		# 			items.push val
		# 		that.attr 'placeholder', 'Введите имя клиента'
		# 		that.typeahead
		# 			source: items
		# 			updater: (item) ->
		# 				if target
		# 					$.getJSON update,
		# 							name: item 
		# 						.done (data) ->
		# 							target.empty()
		# 							for val in data
		# 								target.append $('<option>',
		# 								selected: 'selected' if val.def
		# 								value: val.id
		# 								text: val.name)
		# 				return item



