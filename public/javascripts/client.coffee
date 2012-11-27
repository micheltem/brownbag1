
$(document).ready ->

	app = {}
	app.server = io.connect("/")
	console.log "Hello"

	_log = (message) ->
		console.log message
	_s_log = (o) ->
		console.log JSON.stringify o

	templates:
		welcome: "<h1>#{message}</h1>"

	app.server.on "connect", ->
		_log "connected to the server"
		_log "Connected to the server" + arguments
		app.server.on "message", (data) ->
			_log "Received message: " + data.message
			alert data.message
			user = prompt "Who are you?"
			app.server.emit "userName", user



	window.app = app
