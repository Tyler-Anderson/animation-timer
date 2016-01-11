###
   Tyler Anderson
   Tyler@Brava.do
###
stopwatch = ->
  @startTime = 0
  @running = false
  
  start : ->
    @startTime = +new Date()
    @running = true
    true

  stop : ->
    @elapsed = +new Date() - @startTime
    @running = false
    true

  getElapsed : ->
    if @running then (+new Date()) - @startTime
    else
      @elapsed

  isRunning : -> @running

  reset : ->
    @elapsed = 0
    true


class AnimationTimer
  constructor : (duration = 1000, timeWarp) ->
    if not (this instanceof AnimationTimer)
      return new AnimationTimer(duration, timeWarp)
    else
      @duration = duration
      if (typeof timeWarp == "string")
        @timeWarp = this[timeWarp]
      else @timeWarp = @makeLinear
      @stopwatch = new stopwatch()
      return this

  changeDuration : (@duration) ->
    
  start : ->
    @stopwatch.start()
    true

  stop : ->
    @stopwatch.stop()
    true

  getRealElapsedTime : -> @stopwatch.getElapsed()

  getElapsedTime : ->
    elapsedTime = @stopwatch.getElapsed()
    percentComplete = elapsedTime / @duration

    if not @stopwatch.running then return undefined
    if not @timeWarp then return elapsedTime

    elapsedTime * (@timeWarp(percentComplete) / percentComplete)

  isRunning : ->
    @stopwatch.running unless @isOver() then false

  isOver : -> @stopwatch.getElapsedTime() > @duration

  reset : ->
    @stopwatch.reset()
    true

  makeEaseOut : (strength) ->
    (percentComplete) ->
       1 - Math.pow(1 - percentComplete, strength*2)

  makeEaseIn : (strength) ->
    (percentComplete) ->
      Math.pow(percentComplete, strength*2)

  makeEaseInOut : ->
    (percentComplete) ->
      percentComplete - Math.sin(percentComplete*2*Math.PI) / (2*Math.PI)

  makeElastic : (passes) ->
    passes = passes ? 3
    (percentComplete) ->
      ((1-Math.cos(percentComplete * Math.PI * passes)) *
        (1 - percentComplete)) + percentComplete

  makeBounce : (bounces) ->
    fn = AnimationTimer.makeElastic bounces
    (percentComplete) ->
      percentComplete = fn percentComplete
      if percentComplete <= 1 then percentComplete else 2-percentComplete

  makeLinear : ->
    (percentComplete)-> percentComplete

module.exports = AnimationTimer
