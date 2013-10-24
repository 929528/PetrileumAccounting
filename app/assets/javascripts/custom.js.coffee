$ ->
	$('#flash_notice').autohide(1000)

	$('#list > li.media').media('init')

	$('#list .media-window').on 'show', ->
		$(this).closest('.media').addClass('active')
	$('#list .media-window').on 'hide', ->
		$(this).closest('.media').removeClass('active')

	$('.media-window').on 'show', ->
		that = $(this)
		that.find(".barcode input").on 'keypress', (event) ->
			if event.which == 13
				that.media 'request', $(this).data('path'), barcode: $(this).val()
				$(this).val ''