// Generated by CoffeeScript 1.10.0

/*
   Tyler Anderson
   Tyler@Brava.do
   old animationTimer i wrote i'm not sure it'll be of any use to anyone or not
 */

(function() {
  var AnimationTimer, Stopwatch;

  Stopwatch = (function() {
    function Stopwatch() {}

    Stopwatch.prototype.startTime = 0;

    Stopwatch.prototype.running = false;

    Stopwatch.prototype.start = function() {
      this.startTime = +new Date();
      this.running = true;
      return true;
    };

    Stopwatch.prototype.stop = function() {
      this.elapsed = +new Date() - this.startTime;
      this.running = false;
      return true;
    };

    Stopwatch.prototype.getElapsedTime = function() {
      if (this.running) {
        return (+new Date()) - this.startTime;
      } else {
        return this.elapsed;
      }
    };

    Stopwatch.prototype.isRunning = function() {
      return this.running;
    };

    Stopwatch.prototype.reset = function() {
      this.elapsed = 0;
      return true;
    };

    return Stopwatch;

  })();

  AnimationTimer = (function() {
    function AnimationTimer(duration, timeWarp) {
      this.duration = duration != null ? duration : 1000;
      this.timeWarp = timeWarp;
      this.stopwatch = new Stopwatch();
    }

    AnimationTimer.prototype.start = function() {
      this.stopwatch.start();
      return true;
    };

    AnimationTimer.prototype.stop = function() {
      this.stopwatch.stop();
      return true;
    };

    AnimationTimer.prototype.getRealElapsedTime = function() {
      return this.stopwatch.getElapsedTime();
    };

    AnimationTimer.prototype.getElapsedTime = function() {
      var elapsedTime, percentComplete;
      elapsedTime = this.stopwatch.getElapsedTime();
      percentComplete = elapsedTime / this.duration;
      if (!this.stopwatch.running) {
        return void 0;
      }
      if (!this.timeWarp) {
        return elapsedTime;
      }
      return elapsedTime * (this.timeWarp(percentComplete) / percentComplete);
    };

    AnimationTimer.prototype.isRunning = function() {
      this.stopwatch.running;
      return true;
    };

    AnimationTimer.prototype.isOver = function() {
      return this.stopwatch.getElapsedTime() > this.duration;
    };

    AnimationTimer.prototype.reset = function() {
      this.stopwatch.reset();
      return true;
    };

    return AnimationTimer;

  })();

  AnimationTimer.makeEaseOut = function(strength) {
    return function(percentComplete) {
      return 1 - Math.pow(1 - percentComplete, strength * 2);
    };
  };

  AnimationTimer.makeEaseIn = function(strength) {
    return function(percentComplete) {
      return Math.pow(percentComplete, strength * 2);
    };
  };

  AnimationTimer.makeEaseInOut = function() {
    return function(percentComplete) {
      return percentComplete - Math.sin(percentComplete * 2 * Math.PI) / (2 * Math.PI);
    };
  };

  AnimationTimer.makeElastic = function(passes) {
    passes = passes != null ? passes : 3;
    return function(percentComplete) {
      return ((1 - Math.cos(percentComplete * Math.PI * passes)) * (1 - percentComplete)) + percentComplete;
    };
  };

  AnimationTimer.makeBounce = function(bounces) {
    var fn;
    fn = AnimationTimer.makeElastic(bounces);
    return function(percentComplete) {
      percentComplete = fn(percentComplete);
      if (percentComplete <= 1) {
        return percentComplete;
      } else {
        return 2 - percentComplete;
      }
    };
  };

  AnimationTimer.makeLinear = function() {
    return function(percentComplete) {
      return percentComplete;
    };
  };

  module.exports = AnimationTimer;

}).call(this);
