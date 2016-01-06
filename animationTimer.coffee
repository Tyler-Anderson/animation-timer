###
   Tyler Anderson
   Tyler@Brava.do
   old animationTimer i wrote i'm not sure it'll be of any use to anyone or not
###
class Stopwatch
    constructor: ->
    startTime : 0
    running : false
    
    start : ->
        @startTime = +new Date()
        @running = true
        true

    stop : ->
        @elapsed = +new Date() - @startTime
        @running = false
        true

    getElapsedTime: ->
        if @running then (+new Date()) - @startTime
        else
            @elapsed

    isRunning : -> @running

    reset : ->
        @elapsed = 0
        true


class AnimationTimer
    constructor : (@duration = 1000, @timeWarp) ->
        @stopwatch = new Stopwatch()

    start : ->
        @stopwatch.start()
        true

    stop  : ->
        @stopwatch.stop()
        true

    getRealElapsedTime : -> @stopwatch.getElapsedTime()

    getElapsedTime : ->
        elapsedTime = @stopwatch.getElapsedTime()
        percentComplete = elapsedTime / @duration

        if not @stopwatch.running then return undefined
        if not @timeWarp then return elapsedTime

        elapsedTime * (@timeWarp(percentComplete) / percentComplete)

    isRunning : ->
        @stopwatch.running
        true
    isOver : -> @stopwatch.getElapsedTime() > @duration

    reset : ->
        @stopwatch.reset()
        true


AnimationTimer.makeEaseOut = (strength) ->
    (percentComplete) ->
        1 - Math.pow(1 - percentComplete, strength*2)

AnimationTimer.makeEaseIn = (strength) ->
    (percentComplete) ->
        Math.pow(percentComplete, strength*2)

AnimationTimer.makeEaseInOut = ->
    (percentComplete) ->
        percentComplete - Math.sin(percentComplete*2*Math.PI) / (2*Math.PI)

AnimationTimer.makeElastic = (passes) ->
    passes = passes ? 3
    (percentComplete) ->
        ((1-Math.cos(percentComplete * Math.PI * passes)) *
            (1 - percentComplete)) + percentComplete

AnimationTimer.makeBounce = (bounces) ->
    fn = AnimationTimer.makeElastic bounces
    (percentComplete) ->
        percentComplete = fn percentComplete
        if percentComplete <= 1 then percentComplete else 2-percentComplete

AnimationTimer.makeLinear = ->
    (percentComplete)-> percentComplete

module.exports = AnimationTimer
