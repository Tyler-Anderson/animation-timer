AnimationTimer (anim-timer on npm) 
==================================

timing library with easing functions
------------------------------------

timer = require('anim-timer')(length/time in milliseconds, easing method name [if blank then linear], warpArgs )

timer.start() starts the timer

timer.stop() stops the timer (huge surprise right?)

changeDuration(length) can be used to change the duration or more likely reset it for reuse

getRealElapsedTime() gets time since the internal timer was started

getElapsedTime() //gets the elapsed time in relation to easing function

isRunning() checks if running

isOver() checks if over 

reset() reset timer

setEasing(easingName, args) sets the easing function by name and supplies the args

makeEaseOut(strength) easing function 

makeEaseInOut() easing function with no args, equal ease and in

makeElastic(passes) elastic easing function that takes a passes arg, defaults to 3

makeBounce(bounces) bouncing easing function takes the number of bounces

makeLinear() linear easing, default like no easing.
