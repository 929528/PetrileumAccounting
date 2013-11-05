$ ->
	$('html').on 'ajaxStart', ->
		$(this).addClass 'busy'
	$('html').on 'ajaxStop', ->
		$(this).removeClass 'busy'

	$('#flash_notice').autohide(1000)

	$('#list > li.media').media('init')
	$('#control-panel button').media 'init'

	$(window).scrollpagination 'init', '#list'

	$('.media-window').on 'show', ->
		that = $(this)
		that.find(".barcode input").on 'keypress', (event) ->
			if event.which == 13
				barcode = $(this).val()
				unless that.find(".action[data-barcode=#{barcode}]").length != 0
					data = {}
					data['department'] = that.find('form:first').find('select[name="document[department_id]"] option:selected').val()
					data['contract'] = that.find('form:first').find('select[name="document[contract_id]"] option:selected').val()
					data['barcode'] = barcode
					that.media 'request', $(this).data('path'), data: data
				else
					show_error that, "Талон существует в списе"
				$(this).val ''

		that.find('input[data-provide="typeahead"]').each ->
			$(this).autocomplete 'init'
		
show_error = (target, error) ->
	div = target.find('.form-errors:first')
	div.html('<div class="alert alert-error">'+error+'</div>').autohide 1000
	return false