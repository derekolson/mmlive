// Generated by CoffeeScript 1.6.3
/*
 Main Application View
 Sets up EaselJS stage / canvas
*/


(function() {
  define(['jquery', 'hogan', 'text!../../templates/alertbox.html'], function($, Hogan, template) {
    var AppView;
    return AppView = (function() {
      function AppView(canvasId) {
        var alertboxCompiled, colorCount, colors, data, i, numSquares, numSquaresVert, screenHeight, screenWidth, square, squareHeight, squareWidth, _i, _ref,
          _this = this;
        if (canvasId == null) {
          canvasId = "canvas";
        }
        data = {
          alertTitle: 'Alert Message Example',
          alertBody: 'Lorem ipsum dolor sit amet, con secte tur ad ipiscing elit.'
        };
        alertboxCompiled = Hogan.compile(template);
        $('#alertHolder').html(alertboxCompiled.render(data));
        $('.close').click(function(e) {
          return $('#alertHolder').fadeOut('slow');
        });
        colors = ['color1', 'color2', 'color3', 'color4', 'color5', 'color6', 'color7'];
        this.squares = [];
        screenWidth = $(window).width();
        screenHeight = $(window).height();
        squareWidth = squareHeight = screenWidth / 4;
        numSquaresVert = Math.floor(screenHeight / squareHeight);
        numSquares = numSquaresVert * 4;
        colorCount = 0;
        console.log(screenWidth);
        console.log(screenHeight);
        console.log(squareWidth);
        console.log(numSquaresVert);
        console.log(numSquares);
        for (i = _i = 0, _ref = numSquares - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          square = $('<div></div>');
          square.addClass('gridItem' + ' ' + colors[colorCount]);
          square.css({
            width: squareWidth,
            height: squareHeight
          });
          $('#remoteVideos').append(square);
          ++colorCount;
          if (colorCount > colors.length - 1) {
            colorCount = 0;
          }
          this.squares.push(square);
        }
      }

      AppView.prototype.addVideo = function(video) {
        var index, square;
        index = Math.floor(Math.random() * this.squares.length);
        square = this.squares[index];
        this.squares.slice(index, 1);
        return square.append($(video));
      };

      AppView.prototype.removeVideo = function(video) {
        var square;
        square = $(video.parentNode);
        video.parentNode.removeChild(video);
        return this.squares.push(square);
      };

      AppView.prototype.resize = function(w, h) {};

      return AppView;

    })();
  });

}).call(this);
