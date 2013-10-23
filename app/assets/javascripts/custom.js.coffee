$ ->
	$('#flash_notice').autohide(1000)

	$('#list > li.media').on 'click', ->
		$(this).mw('request', $(this).data('path'))

	$('.media-window').on 'show', ->
		that = $(this)
		$('#talon_barcode').on 'keypress', (event) ->
			if event.which == 13
				that.mw 'request_action', $(this).data('path'), barcode: $(this).val()
				$(this).val ''
