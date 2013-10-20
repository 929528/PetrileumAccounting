methods = 
	show: ->
		that = this
		that.data 'show', true
		this.slideDown 300, ->
			that.data 'show', true
			that.find('.media-footer .btn').on 'click', ->
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
		this.slideUp 300, ->
			that.data 'show', false
			$(this).html ''
	request: ->
		unless this.find('.media-window').data 'show' 
			timestamp = $.now()
			this.find('.media-window:first').attr('timestamp', timestamp)
			$.ajax this.data('path'),
				dataType: 'script',
				data: 
					timestamp: timestamp

$.fn.mw = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call( arguments, 1 )