// Generated by CoffeeScript 1.6.3
/*
 Maintains local and remote video streams
*/


(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['AppController'], function(AppController) {
    var VideoController;
    VideoController = (function() {
      function VideoController() {
        this.videoSuccess = __bind(this.videoSuccess, this);
      }

      VideoController.prototype.init = function(location) {
        this.remoteVideos = [];
        this.location = location;
        if (PeerConnection) {
          return rtc.createStream({
            video: true,
            audio: true
          }, this.videoSuccess);
        }
      };

      VideoController.prototype.videoSuccess = function(stream) {
        return this.addRemoteStream(stream, "main", this.location, true);
      };

      VideoController.prototype.videoError = function() {};

      VideoController.prototype.addRemoteStream = function(stream, id, location, muted) {
        var video;
        video = document.createElement('video');
        video.id = 'remote' + id;
        rtc.attachStream(stream, video);
        video.play();
        $(video).attr("muted", "muted");
        this.remoteVideos.push(video);
        this.appView.addVideo(video, location);
        return video;
      };

      VideoController.prototype.cloneVideo = function(domId, id) {
        var clone, video;
        video = document.getElementById(domId);
        clone = video.cloneNode(false);
        clone.id = 'remote' + id;
        return clone;
      };

      VideoController.prototype.removeVideo = function(id) {
        var video;
        video = document.getElementById('remote' + id);
        if (video) {
          this.appView.removeVideo(video);
          return this.remoteVideos.splice(this.remoteVideos.indexOf(video), 1);
        }
      };

      return VideoController;

    })();
    return new VideoController();
  });

}).call(this);
