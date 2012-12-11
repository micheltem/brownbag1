
###
Module dependencies.
###
express = require("express")
socket = require("socket.io")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")
nano = require("nano")('http://localhost:5984')

db = nano.db.use('brownbag1')

# db.insert {name: "turtle", size: "small"}, "turtle", (err, body, header) ->
#   console.log err if err?
#   console.log body

app = module.exports = express.createServer()
io = socket.listen(app)


app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))
  app.use require("stylus").middleware(src: __dirname + "/public")


app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/users", user.list
app.listen 3000, ->
  console.log "==> Server listening on port %d in %s mode", app.address().port, app.settings.env

users = []

io.sockets.on "connection", (socket) ->
  console.log "User connected"
  socket.emit "message",
    message: "Welcome to the brownbag1 chat"

  socket.on "userName", (user) ->
    console.log user + " has joined"
    users.push user
    socket.broadcast.emit "joined",
      userName: user
    socket.broadcast.emit "message",
      message: user + " has joined... " + new Date()

    # console.log users.contains(data)

  socket.on "chat", (data) ->
    console.log data
    socket.broadcast.emit "message",
      message: data


