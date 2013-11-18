$.fn.flash = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)

methods =
	init: ->
		this.flash 'show' unless this.data('show')
	show: ->
		that = this
		that.data 'show', true
		this.show 'slide', {direction: 'right'}, 500, ->
			int = setInterval ->
				if that.children('.alert').length == 1 && (that.css('cursor') != 'wait')
					that.flash 'hide'
					clearInterval int
				else
					that.children('.alert:first').flash('hideAlert') unless (that.css('cursor') == 'wait')
			, 2000
	hide: ->
		that = this
		this.hide 'slide', {direction: 'right'}, 500, ->
			that.data 'show', false
			$(this).empty()
	hideAlert: ->
		this.hide 'slide', {direction: 'right'}, 500, ->
			$(this).remove()
			
show_notice = (type, message) ->
	$('#flash_notice').append('<div class="alert alert-'+type+'">'+message+'</div>').flash 'init'

window.show_notice = show_notice
