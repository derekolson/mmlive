
/**
 * Module dependencies.
 */
var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path')


var app = express()
  , server = require('http').createServer(app)
  , io = require('socket.io').listen(server)
  , webrtc = require('./webrtc');


//Configure Express Server
app.configure(function(){
  app.set('port', process.env.PORT || 8000);
  app.use(express.basicAuth('process.env.MM_USER' || 'mediamath', 'process.env.MM_PSK') || 'live');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

//Socket IO Config
io.configure(function () {
  io.enable('browser client minification');  // send minified client
  io.set("transports", ["xhr-polling"]);  //XHR required for Heroku
  io.set("polling duration", 10); 
  io.set('log level', 1)  //reduce logging
});


//Start HTTP Server
server.listen( app.get('port'), function(){
  console.log("Express/socket.io server running on port "+app.get('port'));
});


//WebRTC Signaling Channel (project_root/webrtc)
webrtc.init(io)

io.sockets.on('connection', function(socket) {
  socket.on('alert', function (data) {
    io.sockets.emit('alert', data);
  });
});


//Routing
app.get('/', routes.index);
