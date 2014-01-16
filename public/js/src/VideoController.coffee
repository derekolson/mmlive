###
 Maintains local and remote video streams
###

define ['AppController'], (AppController) ->
	class VideoController
		constructor: ->
			
		init: (location) ->
			@remoteVideos = []
			@location = location

			# Ask client to use local video stream
			if(PeerConnection)
				rtc.createStream({video: true, audio: true}, @videoSuccess)

		videoSuccess: (stream) =>
			# Set Background Video to Client Video Stream
			@addRemoteStream(stream, "main", @location, true)

		videoError: ->
			#Stubbed in / not implemented

		addRemoteStream: (stream, id, location, muted) ->

			video = document.createElement('video')

			video.id = 'remote' + id
			rtc.attachStream(stream, video)
			video.play()

			$(video).attr("muted", "muted")
			
			@remoteVideos.push(video)
			@appView.addVideo(video, location);
			return video

		#Clone DOM video object
		cloneVideo: (domId, id) ->
			video = document.getElementById(domId)
			clone = video.cloneNode(false)
			clone.id = 'remote' + id
			return clone
		
		#Remove DOM video object
		removeVideo: (id) ->
			video = document.getElementById('remote' + id)
			if(video)
				@appView.removeVideo(video)
				@remoteVideos.splice(@remoteVideos.indexOf(video), 1)
				

	return new VideoController()