###
 Maintains local and remote video streams
###

define ['AppController'], (AppController) ->
	class VideoController
		constructor: ->
			
		init: () ->
			@remoteVideos = []

			# Ask client to use local video stream
			if(PeerConnection)
				rtc.createStream({video: true, audio: false}, @videoSuccess)

		videoSuccess: (stream) =>
			# Set Background Video to Client Video Stream
			@mainVideo = document.getElementById('mainVideo')
			@mainVideo.src = window.webkitURL.createObjectURL(stream)
			@remoteVideos.push(@mainVideo)

		videoError: ->
			#Stubbed in / not implemented

		addRemoteStream: (stream, id) ->

			# frag = document.createDocumentFragment()
			# video = frag.appendChild(document.createElement('video'))
			# 
			video = document.createElement('video')
			square.appendChild(video)

			video.id = 'remote' + id
			rtc.attachStream(stream, video)
			video.play()
			
			@remoteVideos.push(video)
			document.getElementById('remoteVideos').appendChild(video)
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
				@remoteVideos.splice(@remoteVideos.indexOf(video), 1)
				video.parentNode.removeChild(video)

	return new VideoController()