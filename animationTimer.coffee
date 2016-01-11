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
  constructor : (duration = 1000, timeWarp, @warpArgs) ->
    if not (this instanceof AnimationTimer)
      return new AnimationTimer(duration, timeWarp)
    else
      @duration = duration
      if (typeof timeWarp == "string")
        @timeWarp = this[timeWarp]
      else @timeWarp = @makeLinear
      @stopwatch = new stopwatch()
      return this

  setDuration: (@duration) ->
    
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

  setEasing : (easingName, args) ->
    @timeWarp = @[easingName](args)

  makeEaseOut : (strength) ->
    if strength is undefined then strenght = @warpArgs
    (percentComplete) ->
       1 - Math.pow(1 - percentComplete, strength*2)

  makeEaseIn : (strength) ->
    if strength is undefined then strenght = @warpArgs

    (percentComplete) ->
      Math.pow(percentComplete, strength*2)

  makeEaseInOut : ->
    (percentComplete) ->
      percentComplete - Math.sin(percentComplete*2*Math.PI) / (2*Math.PI)

  makeElastic : (passes) ->
    if passes = undefined then passes = @warpArgs
    passes = passes ? 3
    (percentComplete) ->
      ((1-Math.cos(percentComplete * Math.PI * passes)) *
        (1 - percentComplete)) + percentComplete

  makeBounce : (bounces) ->
    if bounces is undefined then bounces = @warpArgs
    fn = AnimationTimer.makeElastic bounces
    (percentComplete) ->
      percentComplete = fn percentComplete
      if percentComplete <= 1 then percentComplete else 2-percentComplete

  makeLinear : ->
    (percentComplete)-> percentComplete

module.exports = AnimationTimer
