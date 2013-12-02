$.fn.flash = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)

methods =
	show: (delay) ->
		that = this
		if this.children().length != 0
			this.show 'slide', {direction: 'right'}, 500, ->
				that.data 'show', true
				if delay?
					int = setInterval ->
						that.flash 'hide'
						clearInterval int
					, delay
	hide: (callback) ->
		that = this
		if this.data 'show'
			this.hide 'slide', {direction: 'right'}, 500, ->
				that.data 'show', false
				$(this).empty()
				callback.call() if callback?
		else
			callback.call() if callback?
			
show_notice = (type, message) ->
	$('#flash_notice').append('<div class="alert alert-'+type+'">'+message+'</div>').flash 'show', 1000

window.show_notice = show_notice
