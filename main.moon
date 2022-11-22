love.load = ->
  export sti = require "lib.sti.sti"
  export map = sti "assets/maps/level1.lua"
  layer = map\addCustomLayer("Sprites", 8)

love.update = (dt)->
  map\update dt

love.draw = ->
  map\draw!