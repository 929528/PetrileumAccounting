methods = 
	show: ->
		that = this
		that.data 'show', true
		this.trigger 'show'
		this.slideDown 400, ->
			that.data 'show', true
			that.find('.media-footer > .buttons > .btn').on 'click', ->
				state = $(this).data('state')
				that.mw('submit', state)
	submit: (state) ->
		that = this
		if state == 'close'
			that.mw 'hide'
		else
			inputs = []
			inputs.push $("<input>").attr("type", "hidden").attr("name", "status").val(state)
			inputs.push $("<input>").attr("type", "hidden").attr("name", "timestamp").val(that.attr 'timestamp')
			form = that.find('.media-body form:first')
			form.append input for input in inputs
			form.submit()
	hide: ->
		that = this
		this.slideUp 400, ->
			that.data 'show', false
			$(this).html ''
	request: (path) ->
		unless this.find('.media-window').data 'show' 
			timestamp = $.now()
			this.find('.media-window:first').attr('timestamp', timestamp)
			$.ajax path,
				dataType: 'script',
				data: 
					timestamp: timestamp

	request_action: (path, user_data) ->
		timestamp = $.now()
		this.attr('timestamp', timestamp)
		$.ajax path,
				dataType: 'script',
				data: 
					timestamp: timestamp
					request: user_data if user_data
	add_tab: ->
		$.ajax this.data('path'),
			dataType: 'script',
			data: 
				timestamp: this.closest('.media-window').attr('timestamp')

$.fn.mw = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)
	else if typeof method == 'object' || ! method
		methods.init.apply this, arguments