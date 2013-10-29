$.fn.media = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)

methods = 
	show: ->
		that = this
		that.slideDown 300, ->
			that.trigger 'show'
			that.data 'show', true
			that.closest('.media').addClass('active')
			that.find('.media-footer > .buttons > .btn').on 'click', ->
				state = $(this).data('state')
				that.media('submit', state)

	request: (path, data) ->
		timestamp = $.now()
		this.attr 'timestamp', timestamp
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
