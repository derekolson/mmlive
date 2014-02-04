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
			@addRemoteStream(stream, {id: "main", location: @location, mute: true })

		videoError: ->
			#Stubbed in / not implemented

		addRemoteStream: (stream, options) ->
			video = document.createElement('video')

			video.id = 'video-' + options.id
			rtc.attachStream(stream, video)
			$(video).attr("autoplay", "autoplay")
			# video.muted = false

			if(options.mute)
				video.muted = true
				# $(video).attr("muted", "muted")
			
			@remoteVideos.push(video)
			@appView.addVideo(video, options.location);
			return video

		#Clone DOM video object
		cloneVideo: (domId, id) ->
			video = document.getElementById(domId)
			clone = video.cloneNode(false)
			clone.id = 'remote' + id
			return clone
		
		#Remove DOM video object
		removeVideo: (id) ->
			video = document.getElementById('video-' + id)
			if(video)
				@appView.removeVideo(video)
				@remoteVideos.splice(@remoteVideos.indexOf(video), 1)
				

	return new VideoController()