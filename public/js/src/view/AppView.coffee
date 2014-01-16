###
 Main Application View
 Sets up EaselJS stage / canvas
###
define ['jquery', 'hogan', 'text!../../templates/alertbox.html'], ($, Hogan, template) ->
	class AppView
		constructor: (canvasId="canvas") ->

			# alert template stub
			data = 
				alertTitle: 'Alert Message Example'
				alertBody: 'Lorem ipsum dolor sit amet, con secte tur ad ipiscing elit.'
			alertboxCompiled = Hogan.compile(template)
			$('#alertHolder').html(alertboxCompiled.render(data))

			colors = ['color1', 'color2', 'color3', 'color4', 'color5', 'color6', 'color7']
			squares = []

			screenWidth = $(window).width()
			screenHeight = $(window).height()
			squareWidth = squareHeight = screenWidth/4
			numSquaresVert = Math.ceil(screenHeight/squareHeight)
			numSquares = numSquaresVert * 4
			colorCount = 0

			console.log(screenWidth)
			console.log(screenHeight)
			console.log(squareWidth)
			console.log(numSquaresVert)
			console.log(numSquares)

			for i in [0..numSquares]
				square = $('<div></div>')
				square.addClass('gridItem' + ' ' + colors[colorCount])
				square.css({width: squareWidth, height: squareHeight})
				$('#remoteVideos').append(square)
				# cycle thru colors
				++colorCount
				colorCount = 0 if colorCount > colors.length-1
				squares.push(square)

		update: ->

		resize: (w, h) ->