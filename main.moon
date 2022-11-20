require "lib.love-animation.animation"
cartographer = require "lib.cartographer.cartographer"

love.load = ->
  export map = cartographer.load "maps/level1.lua"
  love.graphics.setBackgroundColor {0, 0, 0}
  file = "sprites/animation1.lua"
  export anim = LoveAnimation.new file
  anim\setSpeedMultiplier 1
	-- export states = anim\getAllStates()

love.update = (dt)->
  map\update dt
  anim\update dt

love.draw = ->
  love.graphics.setColor {255,255,255}
  map\draw!
  anim\draw!