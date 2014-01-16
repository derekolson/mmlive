// Generated by CoffeeScript 1.6.3
/*
 Maintains socket connection to Node/Socket.io Server
*/


(function() {
  define(['VideoController'], function(VideoController) {
    var ServiceManager;
    ServiceManager = (function() {
      function ServiceManager() {}

      ServiceManager.prototype.connect = function(onConnected) {
        this.socket = io.connect('/');
        rtc.connect(this.socket, "", "Chicago");
        rtc.on('connect', function() {
          var _this = this;
          console.log("WebRTC Connected");
          VideoController.init();
          rtc.on('add remote stream', function(stream, id) {
            console.log("Video Stream Connected: " + id);
            return VideoController.addRemoteStream(stream, id);
          });
          rtc.on('disconnect stream', function(id) {
            console.log("Video Stream Disconnected: " + id);
            return VideoController.removeVideo(id);
          });
          return onConnected();
        });
        return this.socket.on('connect', function() {});
      };

      ServiceManager.prototype.send = function(event, data) {
        console.log("Socket Send Event: " + event);
        return this.socket.emit(event, data);
      };

      return ServiceManager;

    })();
    return new ServiceManager();
  });

}).call(this);