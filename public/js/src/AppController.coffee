###
 AppController wires up various views
 This is heavily unfinished..
###

define ['view/AppView'], (AppView) ->
	class AppController
		init: () ->
			@appView = new AppView()

			$(window).resize(@resize);
			@resize();

		resize: (e) =>
			w = window.innerWidth
			h = window.innerHeight

	return new AppController()