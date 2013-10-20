$.fn.autohide = (delay) ->
	self = this
	this.slideDown ->
		int = setInterval ->
			unless self.css('cursor') == 'wait'
				self.slideUp 300
				clearInterval int
		, delay