{spawn} = require 'child_process'

# {exec} = require 'child_process'
# Rehab = require 'rehab'
# watcher_lib = require 'watcher_lib'

# task 'build', 'Build coffee2js using Rehab', sbuild = ->
# 	compile()


# task 'watch', 'Watch coffee files and compile', watch = ->
# 	watcher_lib.startDirectoryPoll('./public/src', findCoffeeFiles)


# WATCHED_FILES = []
# findCoffeeFiles = (dir) ->
#     watcher_lib.findFiles('*.coffee', dir, compileIfNeeded)

# compileIfNeeded = (file) ->
#     watcher_lib.compileIfNeeded(WATCHED_FILES, file, compileCoffeeScript)

# compileCoffeeScript = (file) ->
# 	compile()

# compile = ->
# 	console.log "Building project from src/*.coffee to lib/app.js"

# 	files = new Rehab().process './public/src'

# 	to_single_file = "--join public/lib/app.js"
# 	from_files = "--compile #{files.join ' '}"

# 	exec "coffee #{to_single_file} #{from_files}", (err, stdout, stderr) ->
# 		throw err if err

task 'build', 'Compile coffee files', ->
	spawn 'coffee', ['-o', 'public/js/lib/', '-c', 'public/js/src/'], customFds: [0..2]

task 'watch', 'Watch coffee files and compile', ->
	spawn 'coffee', ['-o', 'public/js/lib/', '-cw', 'public/js/src/'], customFds: [0..2]