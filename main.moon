require "lib.love-animation.animation"
require "lib.cartographer.cartographer"

love.load = ->
  love.graphics.setBackgroundColor {0, 0, 0}
  file = 'sprites/animation1.lua'
  export anim = LoveAnimation.new file
  anim\setSpeedMultiplier 1
	-- export states = anim\getAllStates()

love.update = (dt)->
  anim\update dt

love.draw = ->
  love.graphics.setColor {255,255,255}
  anim\draw!