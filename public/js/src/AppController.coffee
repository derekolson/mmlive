###
 AppController wires up various views
 This is heavily unfinished..
###

define ['view/AppView', 'VideoController'], (AppView, VideoController) ->
	class AppController
		init: () ->
			@appView = new AppView()

			VideoController.appView = @appView;

			$(window).resize(@resize);
			@resize();

		resize: (e) =>
			@appView.resize()

	return new AppController()