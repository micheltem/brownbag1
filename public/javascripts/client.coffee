
$(document).ready ->

	app = {}
	app.server = io.connect("/")
	console.log "Hello"

	_log = (message) ->
		console.log message
	s_log = (o) ->
		console.log JSON.stringify o


	((server) ->
		server.on "connect", ->
			log "Connected to the server" + arguments

		server.on "userEligible", (response) ->


