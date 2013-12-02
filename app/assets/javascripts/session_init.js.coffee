$ ->
	$('#flash_notice').flash('show', 2000)
	$('#slider').carousel
		interval: 100000
		pause: 'hover'

	$('.info i').popover()
	# $('#slider').on 'slide', ->
	# 	$(this).find('.title, .descr').fadeOut 200
	# $('#slider').on 'slid', ->
	# 	$(this).find('.title, .descr').fadeIn 200


	$('#slider .title, .descr').each (index) ->
		parent = $(this)
		div = $(this).find('.resize')
		parent.closest('.item').css('display', 'inline-block').css('visibility', 'hidden')
		while div.outerHeight() > (parent.innerHeight())
			console.log index + " : " + "div:" + div.outerHeight() + " -" + " parent:" + $(this).innerHeight() + " font: " + div.css('font-size')
			div.css('font-size', (parseFloat(div.css('font-size'), 12) - 1) + "px" )
			console.log div.css 'font-size'
		parent.closest('.item').css('display', '').css('visibility', 'visible')

accordion_show = (target) ->
	$('#accordion').find('.accordion-body').collapse('hide')
	$(target).collapse('show')

window.accordion_show = accordion_show

