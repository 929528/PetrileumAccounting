$.fn.media = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)

methods = 
	show: ->
		that = this
		that.trigger 'show'
		that.slideDown 300, ->
			that.trigger 'shown'
			that.data 'show', true
			that.closest('.media').addClass('active')
			that.find('.media-footer > .buttons > .btn').on 'click', ->
				state = $(this).data('state')
				that.media('submit', state)
			init_window that

	request: (path, data) ->
		timestamp = $.now()
		media_window = this.closest('.media-window')
		media_window.attr 'timestamp', timestamp
		$.ajax path,
			dataType: 'script',
			data: 
				timestamp: timestamp
				request: data if data

	submit: (state) ->
		if state == 'close'
			this.media 'hide'
		else
			inputs = []
			inputs.push $("<input>").attr("type", "hidden").attr("name", "status").val(state)
			inputs.push $("<input>").attr("type", "hidden").attr("name", "timestamp").val(this.attr 'timestamp')
			form = this.find('.media-body form:first')
			form.append input for input in inputs
			form.submit()

	hide: ->
		@this = this
		$('#flash_notice').flash 'hide'
		this.slideUp 300, =>
			@this.trigger 'hide'
			@this.data 'show', false
			@this.closest('.media').removeClass('active')
			@this.html ''

	init: ->
		this.on 'click', ->
			object = $(this).data 'target'
			item = 
				if object? then $(object) else $(this).find('.media-window')
			unless item.data 'show'
				item.media('request', $(this).data('path'))

init_window = (mw) ->
	that = mw
	that.find('.actions').results 'init'
	that.find(".barcode input").on 'keypress', (event) ->
		if event.which == 13
			barcode = $(this).val()
			unless that.find(".action[data-barcode=#{barcode}]").length != 0
				data = {}
				data['department'] = that.find('form:first').find('select[name="document[department_id]"] option:selected').val()
				data['contract'] = that.find('form:first').find('select[name="document[contract_id]"] option:selected').val()
				data['barcode'] = barcode
				that.media 'request', $(this).data('path'), data: data
			else
				show_notice 'error', 'Талон существует в списе'
			$(this).val ''
	that.find('input[data-provide="typeahead"]').each ->
		$(this).autocomplete 'init'
	$('.actions').on 'addAction', ->
		that.find('.actions').results 'init'
	$('.actions').on 'removeAction', ->
		that.find('.actions').results 'init'