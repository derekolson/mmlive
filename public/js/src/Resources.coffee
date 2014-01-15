###
 Resource Loader
 Loads all required images/sounds/etc into memory for consumption
###
define [], ->
	class Resources
		load: (@callback) ->
			@queue = new createjs.LoadQueue(false)
			@queue.addEventListener("complete", @handleComplete)
			@queue.loadManifest([
				{id: "buzz_bg", src:"img/buzz_bg.png"},
				{id: "twitter_bg", src:"img/twitter_bg.png"}
			])

		handleComplete: =>
			console.log("Resources Loaded")
			@callback()

		get: (id) ->
			return @queue.getResult(id)

	return new Resources()