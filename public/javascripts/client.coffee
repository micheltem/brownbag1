
$(document).ready ->

	app = {}
	app.server = io.connect("/")
	console.log "Hello"

	_log = (message) ->
		console.log message
	_s_log = (o) ->
		console.log JSON.stringify o


	app.server.on "connect", ->
		_log "connected to the server"
		_log "Connected to the server" + arguments
		app.server.on "message", (message) ->
			_log "Received message"
			_s_log message


	window.app = app
