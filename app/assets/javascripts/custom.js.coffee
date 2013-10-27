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
				barcode = $(this).val()
				unless that.find(".action[data-barcode=#{barcode}]").length != 0
					that.media 'request', $(this).data('path'), barcode: barcode
				else
					show_error that, "Талон существует в списе"
				$(this).val ''

		that.find('input[data-provide="typeahead"]').each ->
			$(this).autocomplete 'init'
		
show_error = (target, error) ->
	div = target.find('.form-errors:first')
	div.html('<div class="alert alert-error">'+error+'</div>').autohide 1000
	return false