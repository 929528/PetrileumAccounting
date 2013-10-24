$.fn.media = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)

methods = 
	show: ->
		that = this
		unless that.data('show')
			that.slideDown 400, ->
				that.trigger 'show'
				that.data 'show', true
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
		that = this
		if state == 'close'
			that.media 'hide'
		else
			inputs = []
			inputs.push $("<input>").attr("type", "hidden").attr("name", "status").val(state)
			inputs.push $("<input>").attr("type", "hidden").attr("name", "timestamp").val(that.attr 'timestamp')
			form = that.find('.media-body form:first')
			form.append input for input in inputs
			form.submit()

	hide: ->
		that = this
		that.slideUp 400, ->
			that.trigger 'hide'
			that.data 'show', false
			$(this).html ''

	init: ->
		this.on 'click', ->
			item = $(this).find('.media-window')
			unless item.data 'show'
				item.media('request', $(this).data('path'))