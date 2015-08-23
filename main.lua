local sti = require "lib/sti"

arc_path = 'lib/arc/'
require(arc_path .. 'arc')
_navi = require(arc_path .. 'navi')

function love.load()

  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  love.physics.setMeter(8)

  map = sti.new("main_map.lua")
  world = love.physics.newWorld(0, 0)

  collision = map:initWorldCollision(world)

  map:addCustomLayer("Sprite Layer", 2)

  august_spr = love.graphics.newImage("assets/images/august.png")
  august_anim = {
    up = {
      love.graphics.newQuad(32, 0, 16, 16, 64, 32)
    },
    down = {
      love.graphics.newQuad(0, 0, 16, 16, 64, 32)
    },
    left = {
      love.graphics.newQuad(48, 0, 16, 16, 64, 32)
    },
    right = {
      love.graphics.newQuad(16, 0, 16, 16, 64, 32)
    }
  }
  print(august_spr)

  local spriteLayer = map.layers["Sprite Layer"]
  spriteLayer.sprite = {
    image = august_anim["down"][1],
    x = 16 * 25,
    y = 16 * 75,
    -- change w & h to radius or something
    w = 8,
    h = 8,
    ox = 48/2,
    oy = 48/2,
    r = 0
  }



  spriteLayer.sprite.body = love.physics.newBody(world, spriteLayer.sprite.x/2,
                                                 spriteLayer.sprite.y/2,
                                                 "dynamic")
  spriteLayer.sprite.body:setLinearDamping(10)
  spriteLayer.sprite.body:setFixedRotation(true)

  spriteLayer.sprite.shape = love.physics.newRectangleShape(16, 16)
  spriteLayer.sprite.fixture = love.physics.newFixture(spriteLayer.sprite.body,
                                                       spriteLayer.sprite.shape)

  function spriteLayer:update(dt)

  end

  function spriteLayer:draw()
    local x = math.floor(self.sprite.x)
    local y = math.floor(self.sprite.y)
    local r = self.sprite.r
    love.graphics.draw(august_spr, self.sprite.image, x, y, r, 1, 1, 8, 8)
  end

  m = {}
  m[1] = _navi:new('Our first date.')
  m[2] = _navi:new('Remember that night?')


  m2 = {}
  m2[1] = _navi:new('This is another test')

end

function love.draw()
  -- debug
  -- print(map.tileInstances[10][10].gid)

  love.graphics.scale(3, 3)
  local translateX = 0
  local translateY = 0
  local sprite = map.layers["Sprite Layer"].sprite

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()
  local tx = math.floor(-sprite.x + ww / 2 - 160)
  local ty = math.floor(-sprite.y + wh / 2 - 144)


  love.graphics.push()
	love.graphics.translate(tx, ty)
	map:setDrawRange(-tx, -ty, ww, wh)
  -- note: this no longer accepts scale parameters, thus l.g.scale above
  map:draw()
  draw_event_debug(200, 184, 16, 16)

  love.graphics.setColor(255, 0, 0, 255)
  -- map:drawWorldCollision(collision)
  love.graphics.setColor(255, 0, 0, 255)
  -- love.graphics.polygon("line", sprite.body:getWorldPoints(sprite.shape:getPoints()))
  love.graphics.pop()
  love.graphics.setColor(255, 255, 255, 255)

  love.graphics.scale(0.5, 0.5)
  if stepping_on_event(200, 184, 16, 16) then
    _navi.play_list(m,25,200)
  elseif stepping_on_event(41 * 8, 47 * 8, 32, 16) then
    _navi.play_list(m2,20,20)
  end

end

function love.update(dt)

  world:update(dt)
  arc.check_keys(dt)

  local sprite = map.layers["Sprite Layer"].sprite
  local down = love.keyboard.isDown
  print(sprite.x, sprite.y)

  local x, y = 0, 0

  -- elseifs to stop diagonal movement
  if down("w") or down("up") then
    sprite.image = august_anim["up"][1]
    y = y - 8000
  elseif down("s") or down("down") then
    sprite.image = august_anim["down"][1]
    y = y + 8000
  elseif down("a") or down("left") then
    sprite.image = august_anim["left"][1]
    x = x - 8000
  elseif down("d") or down("right") then
    sprite.image = august_anim["right"][1]
    x = x + 8000
  end

  -- sprite.body:setMass(20)
  sprite.body:applyForce(x, y)
  sprite.x, sprite.y = sprite.body:getWorldCenter()

  map:update(dt)

end

function draw_event_debug(event_x, event_y, event_width, event_height)
  love.graphics.setColor(0, 125, 50, 100)
  love.graphics.rectangle("fill", event_x, event_y, event_width,event_height)
  love.graphics.rectangle("line", event_x, event_y, event_width,event_height)
end

function stepping_on_event(event_x, event_y, event_width, event_height)
  local sprite = map.layers["Sprite Layer"].sprite

  if sprite.x - sprite.w < event_x + event_width and
     event_x < sprite.x + sprite.w and
     sprite.y - sprite.h < event_y + event_height and
     event_y < sprite.y + sprite.h then
     return true
  end
  return false
end

function love.keypressed(key)
  arc.set_key(key)
end
