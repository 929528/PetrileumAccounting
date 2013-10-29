$.fn.scrollpagination = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)
methods =
	load_content: ->
		obj = this
		obj.data 'ajaxready', false
		childrens_count = obj.children('li').length
		path = $(location).attr('href')
		$('#list-load').fadeIn()
		$.ajax path,
			dataType: 'script',
			data: 
				childrens_count: childrens_count
			success: ->
				$('#list-load').fadeOut()
				obj.data 'ajaxready', true

	init: (object) ->
		target = this
		object = $(object)
		object.attr 'scrollPagination', 'enabled'
		object.data 'ajaxready', true
		target.on 'scroll', (e) ->
			if (object.attr('scrollPagination') == 'enabled') && (object.data 'ajaxready')
				object.scrollpagination 'load_content' if target.scrollTop() + 10 >= ($(document).height() - target.height())
			else
				e.stopPropagation()
	stop_pagination: ->
		this.attr 'scrollPagination', 'disabled'