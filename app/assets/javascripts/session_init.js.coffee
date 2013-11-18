$ ->
	$('.carousel').carousel {interval: 10000, pause: "hover"}

	$('.brand').hover(
		-> $(this).find('.add').fadeIn 100
		-> $(this).find('.add').hide 10
	) 
	$('#flash_notice').fadeIn(200).delay(5000).fadeOut 200, ->
		$(this).empty()
