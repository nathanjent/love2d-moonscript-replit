love.load = ->
  export sti = require "lib.sti.sti"
  export map = sti "assets/maps/volcanosaur.lua"

  layer = map\addCustomLayer "Sprites"

  player = ([obj for _,obj in pairs(map.objects) when obj.name == "player"])[1]
  
  -- Create player object
  sprite = love.graphics.newImage "assets/sprites/volcanosaur.png"
  layer.player =
        sprite: sprite
        x: player.x
        y: player.y
        ox: sprite\getWidth! / 2
        oy: 0 --sprite\getHeight!

  -- Add controls to player
  layer.update = (dt) =>
    -- 96 pixels per second
    speed = 96

    -- Move player up
    if love.keyboard.isDown("w") or love.keyboard.isDown("up")
        @.player.y -= speed * dt

    -- Move player down
    if love.keyboard.isDown("s") or love.keyboard.isDown("down")
        @.player.y += speed * dt

    -- Move player left
    if love.keyboard.isDown("a") or love.keyboard.isDown("left")
        @.player.x -= speed * dt

    -- Move player right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right")
        @.player.x += speed * dt

  -- Draw player
  layer.draw = () =>
    love.graphics.draw @.player.sprite,
        math.floor(@.player.x),
        math.floor(@.player.y),
        0,
        1,
        1,
        @.player.ox,
        @.player.oy

    -- Temporarily draw a point at our location so we know
    -- that our sprite is offset properly
    love.graphics.setPointSize 5
    love.graphics.points math.floor(@.player.x), math.floor(@.player.y)

love.update = (dt)->
  map\update dt

love.draw = ->
  -- Scale world
  scale = 2
  screen_width = love.graphics.getWidth! / scale
  screen_height = love.graphics.getHeight! / scale

  -- Translate world so that player is always centred
  player = map.layers["Sprites"].player

  tx = math.floor player.x - screen_width / 2
  ty = math.floor player.y - screen_height / 2

  -- Transform world
  love.graphics.scale scale
  love.graphics.translate -tx, -ty

  -- Draw world
  map\draw!