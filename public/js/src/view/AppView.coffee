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
				$('#mainVideo video')[0].src = ""
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
			@vacantTiles = []
			@colors = ['color1', 'color2', 'color3', 'color4', 'color5', 'color6', 'color7']
			@colorCount = 0
			
			@MIN_TILES = 8

			for i in [0..@MIN_TILES-1]
				@addTile()


		addTile: () =>
			tile = $('<div></div>')
			# tile.addClass('gridItem' + ' ' + @colors[Math.floor(Math.random()*@colors.length)])
			tile.addClass('gridItem' + ' ' + @colors[@colorCount])
			$('#remoteVideos').append(tile)

			@colorCount++
			@colorCount = 0 if @colorCount > @colors.length-1
			@vacantTiles.push(tile)
			@resize();

			return tile


		resize: (w, h) ->
			$gridItem = $('.gridItem')
			$videoContainer = $('#remoteVideos')
			$video = $('.gridItem video')

			screenWidth = $(window).width()
			screenHeight = $(window).height()
			numTiles = $gridItem.length

			tileWidth = tileHeight = @gridPack(screenWidth, screenHeight, numTiles)
			
			$videoContainer.css({width: (tileWidth * Math.floor(screenWidth / tileWidth)) + 'px'})
			$gridItem.css({width: tileWidth + 'px', height: tileHeight + 'px'})
			
			# videoWidth = $video.width()
			# if(videoWidth && videoWidth > 0)
			# 	videoOffset = -(videoWidth - tileWidth) / 2
			# 	$video.css({left: videoOffset + 'px'})


		# Square Packing Algorithm 
		# - provide container width, height, number of squares
		# - returns optimal side length
		gridPack: (x, y, n) ->
			px = Math.ceil(Math.sqrt(n *  x / y))
			
			if(Math.floor(px * y / x) * px < n)
				sx = y / Math.ceil(px * y  / x)
			else
				sx = x / px
			
			py = Math.ceil(Math.sqrt(n * y / x))
			
			if(Math.floor(py * x / y) * py < n)
				sy = x / Math.ceil(x * py / y)
			else
				sy = y / py

			return Math.floor(Math.max(sx, sy))

		# gcd: (a, b) ->
		# 	if(b==0)
		# 		return a
		# 	return @gcd(b, a%b)

		addVideo: (video, location) ->
			if(@vacantTiles.length == 0)
				@addTile()

			index = Math.floor(Math.random() * @vacantTiles.length)
			tile = @vacantTiles.splice(index, 1)[0];

			locEl = $('<h2></h2>')
			locEl.addClass('locale')
			locEl.html(location)

			tile.append(video)
			tile.append(locEl)

			tile.click((e) ->
				mainVideo = $('#mainVideo video')[0]
				mainVideo.src = video.src;
				mainVideo.muted = video.muted

				$('#mainVideo').fadeIn('fast')
				$('#mainVideo h2').html(location)
			)

			video.addEventListener('loadeddata', (=>
				# @resize()
			), false)
			

		removeVideo: (video) ->
			$tile = $(video.parentNode)
			$tile.empty()
			$tile.unbind("click")

			$gridItem = $('.gridItem')
			if($gridItem.length > @MIN_TILES)
				$tile.remove()
				@resize()
				return

			@vacantTiles.push($tile)

