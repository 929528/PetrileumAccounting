$.fn.scrollpagination = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)
methods =
	load_content: ->
		obj = this
		childrens_count = obj.children('li').length
		path = $(location).attr('href')
		$.ajax path,
			dataType: 'script',
			data: 
				childrens_count: childrens_count,
			success: ->
				childrens_count = obj.children('li').length
	init: (object) ->
		target = this
		object = $(object)
		object.attr 'scrollPagination', 'enabled'
		target.scroll (e) ->
			if object.attr('scrollPagination') == 'enabled'
				object.scrollpagination 'load_content' if (target.scrollTop()+10 >= $(document).height() - target.height())
			else
				e.stopPropagation()
	stop_pagination: ->
		this.attr 'scrollPagination', 'disabled'






