###
 Main requireJS kick-off
 Loads all dependencies and Starts Application
###

require.config({
    paths: {
        jquery: '../vendor/jquery.min',
        text:'../vendor/text',
        hogan: '../vendor/hogan-2.0.0.amd'
    }
});

requirejs ['Resources', 'AppController', 'ServiceManager'], (Resources, AppController, ServiceManager) ->
	# Kick-off App
	AppController.init()
	
	# Connect to Socket IO Server
	ServiceManager.connect( ->
		# socket connection handler
	)
	
	# Disconnect on refresh / close
	window.onbeforeunload = (e) ->
		rtc.disconnect()
		message = "Client has disconnected.."
		e = e || window.event
		if (e)
			e.returnValue = message
		return message;

	window.onunload = () ->
		rtc.disconnect()