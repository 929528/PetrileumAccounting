$.fn.preload = (method) ->
	if methods[method]
		methods[method].apply this, Array.prototype.slice.call(arguments, 1)
methods =

	init: ->
		this.preload 'load_content'

	load_content: ->
		@this = this
		this.find('i').addClass 'icon-refresh icon-2x icon-spin'
		this.find('span').html 'загрузка списка'
		elements_count = this.parent().children().length - 1
		path = $(location).attr('href')
		$.ajax path,
			dataType: 'script',
			data: 
				elements_count: elements_count
			success: (data, status)=>
				if status != 'nocontent'
					this.find('i').removeClass()
					this.find('i').addClass 'icon-arrow-down icon-2x'
					this.find('span').html 'показать список'
				else 
					@this.preload 'stop_preload'

	show_content: ->
		@this = this
		time = 0
		this.parent().find('.media:hidden').each ->
			that = $(this)
			setTimeout ->
				that.show 'slide', { direction: 'up' }
			,time
			time += 100
		@this.preload 'load_content'

	stop_preload: ->
		this.prop 'onclick', null
		this.find('span').html 'конец списка'
		this.find('i').removeClass().addClass 'icon-ban-circle icon-2x'

		# alert this.closest('#list').children().length - 1
	# load_content: ->
	# 	obj = this
	# 	obj.data 'ajaxready', false
	# 	childrens_count = obj.children('li').length
	# 	path = $(location).attr('href')
	# 	$('#list-load').fadeIn()
	# 	$.ajax path,
	# 		dataType: 'script',
	# 		data: 
	# 			childrens_count: childrens_count
	# 		success: ->
	# 			$('#list-load').fadeOut()
	# 			obj.data 'ajaxready', true

	# init: (object) ->
	# 	target = this
	# 	object = $(object)
	# 	object.attr 'scrollPagination', 'enabled'
	# 	object.data 'ajaxready', true
	# 	target.on 'scroll', (e) ->
	# 		if (object.attr('scrollPagination') == 'enabled') && (object.data 'ajaxready')
	# 			object.scrollpagination 'load_content' if target.scrollTop() + 10 >= ($(document).height() - target.height())
	# 		else
	# 			e.stopPropagation()
	# stop_pagination: ->
	# 	this.attr 'scrollPagination', 'disabled'