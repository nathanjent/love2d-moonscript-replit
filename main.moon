love.load = ->
  require "replitdbclient"
  export sti = require "lib.sti.sti"
  export map = sti "assets/maps/volcanosaur.lua"

  db=ReplitDbClient!
  db\set "animal", "dog"
  animal = db\get "animal"
  print animal

  layer = map\addCustomLayer "Sprites"

  player = ([obj for _,obj in pairs(map.objects) when obj.name == "player"])[1]
  
  -- Create player object
  sprite = love.graphics.newImage "assets/sprites/volcanosaur.png"
  layer.player =
    sprite: sprite
    x: player.x
    y: player.y
    ox: sprite\getWidth! / 2
    oy: 0

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
    
  export game = {
    state: "menu"
    states:
      menu:
        name: "menu"
        input_handler: (input) =>
          --print "state: #{state.name} 1"
          switch input
            when "backToGame"
              print "state: #{state.name} 2"
              state = game_states.game_loop
              print "state: #{state.name} 3"
        keys:
          escape: "backToGame"
        keys_released: {}
      game_loop:
        name: "loop"
        input_handler: (input) ->
          switch input
            when "openMenu"
              state = game_states.menu
        keys:
          escape: "openMenu"
        keys_released: {}
  }
  
love.keypressed = (k)->
  print "key pressed: #{k}"
  state = game.states[game.state]
  binding = state.keys[k]
  state.input_handler binding

love.keyreleased = (k)->
  state = game.states[game.state]
  binding = state.keys_released[k]
  state.input_handler binding

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