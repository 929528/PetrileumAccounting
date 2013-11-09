$ ->
	$('.collapse').on 'show', ->
		$(this).prev().addClass 'active'
	$('.collapse').on 'hide', ->
		$(this).prev().removeClass 'active'	


	$('#flash_notice').flash('showAndHide', 2000)

	$('#list > li.media:not(.active)').media('init')
	$('#control-panel a.btn').media 'init'

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
					show_notice 'error', 'Талон существует в списе'
				$(this).val ''

		that.find('input[data-provide="typeahead"]').each ->
			$(this).autocomplete 'init'

		$('.actions').on 'addAction', ->
			show_notice 'success', 'Талон добавлен в список'
		$('.actions').on 'removeAction', ->
			show_notice 'success', 'Талон удален из списка'
		that.find('.actions').results 'init'
			
	$('#preload').preload 'init'
		
show_notice = (type, message) ->
	$('#flash_notice').append('<div class="alert alert-'+type+'">'+message+'</div>').flash 'init'

window.show_notice = show_notice