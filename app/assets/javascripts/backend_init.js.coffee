$ ->
	$('#flash_notice').flash('show', 2000)
	$('#list > li.media:not(.active)').media('init')
	$('#control-panel a.btn').media 'init'
	$('#preload').preload 'init'