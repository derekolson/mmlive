###
 Maintains socket connection to Node/Socket.io Server
###

define ['VideoController'], (VideoController) ->
	class ServiceManager
		constructor: ->

		connect: (onConnected) ->
			@socket = io.connect('/')
			
			# WebRTC Signaling Channel API 
			# 
			location = prompt("Enter your location", "Chicago")
			rtc.connect(@socket, "", location)
			rtc.on('connect', ->
				console.log("WebRTC Connected")
				VideoController.init(location)
			
				# Add remote video streams as they connect
				rtc.on('add remote stream', (stream, id) =>
					console.log("Video Stream Connected: " + id)
					VideoController.addRemoteStream(stream, id, rtc.locations[id])
				)

				# Remove remote streams as they disconnect
				rtc.on('disconnect stream', (id) =>
					console.log("Video Stream Disconnected: " + id)
					VideoController.removeVideo(id)
				)

				onConnected()
			)

			

			# SocketIO Connection
			@socket.on('alert', (data) ->
				VideoController.appView.showAlert(data)
			)

		# Send Data to Server
		send: (event, data) ->
			console.log "Socket Send Event: " + event
			@socket.emit(event, data)

	return new ServiceManager()