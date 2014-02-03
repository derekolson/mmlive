###
 Main Application View
 Sets up EaselJS stage / canvas
###
define ['jquery', 'hogan', 'text!../../templates/alertbox.html', 'ServiceManager'], ($, Hogan, template, ServiceManager) ->
	class AppView
		constructor: () ->			
			@buildGridView()
			@buildAlertView()

			$('#mainVideo').click(() ->
				$('#mainVideo').fadeOut('fast')
			)

		buildAlertView: () ->
			# alert template stub
			data = 
				alertTitle: 'Jenkins Alert (Compass)'
				alertBody: 'Derek Olson broke the build!'

			@alertboxCompiled = Hogan.compile(template)
			$('#alertHolder').hide()
			

			$(window).keyup( (e) -> 
				if(e.keyCode == 32)
					ServiceManager.send("alert", data)		
			)

		showAlert: (data) ->
			$('#alertHolder').html(@alertboxCompiled.render(data))

			$('#alertHolder').fadeIn('fast')
			setTimeout( () ->
				$('#alertHolder').fadeOut('slow')
			, 15000)

		buildGridView: () ->
			colors = ['color1', 'color2', 'color3', 'color4', 'color5', 'color6', 'color7']
			@tiles = []

			TILES_HORIZ = 5
			TILES_VERT = 3

			screenWidth = $(window).width()
			screenHeight = $(window).height()
			# tileWidth = tileHeight = screenWidth / 5
			tileWidth = 100 / TILES_HORIZ
			tileHeight = (tileWidth * screenWidth) / screenHeight # 100 / TILES_VERT

			ratio = tileWidth / tileHeight
			# numTilesVert = Math.floor(ratio)
			# if (ratio - numTilesVert >= 0.5)
			# 	numTilesVert = Math.ceil(ratio)
			numTiles = TILES_HORIZ * TILES_VERT
			colorCount = 0

			# console.log(screenWidth)
			# console.log(screenHeight)
			# console.log(tileWidth)
			# console.log(numTilesVert)
			# console.log(numTiles)
			console.log(tileWidth + " : " + screenWidth + "-" + tileHeight + " : " + screenHeight)

			for i in [0..numTiles-1]
				tile = $('<div></div>')
				tile.addClass('gridItem' + ' ' + colors[colorCount])
				tile.css({width: tileWidth + '%', height: tileHeight + '%'})
				$('#remoteVideos').append(tile)
				# cycle thru colors
				++colorCount
				colorCount = 0 if colorCount > colors.length-1
				@tiles.push(tile)


		addVideo: (video, location) ->
			index = Math.floor(Math.random() * @tiles.length)
			tile = @tiles.splice(index, 1)[0];

			locEl = $('<h2></h2>')
			locEl.addClass('locale')
			locEl.html(location)

			tile.append(video)
			tile.append(locEl)

			tile.click(() ->
				$('#mainVideo video')[0].src = video.src;
				$('#mainVideo').fadeIn('fast')
				$('#mainVideo h2').html(location)
			)

		removeVideo: (video) ->
			tile = $(video.parentNode)
			tile.empty()
			tile.unbind("click")
			@tiles.push(tile)