// Generated by CoffeeScript 1.6.3
/*
 AppController wires up various views
 This is heavily unfinished..
*/


(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['view/AppView', 'VideoController'], function(AppView, VideoController) {
    var AppController;
    AppController = (function() {
      function AppController() {
        this.resize = __bind(this.resize, this);
      }

      AppController.prototype.init = function() {
        this.appView = new AppView();
        VideoController.appView = this.appView;
        $(window).resize(this.resize);
        return this.resize();
      };

      AppController.prototype.resize = function(e) {
        return this.appView.resize();
      };

      return AppController;

    })();
    return new AppController();
  });

}).call(this);
