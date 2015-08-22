local sti = require "lib/sti"

function love.load()

  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  love.physics.setMeter(8)

  map = sti.new("testmap.lua")
  world = love.physics.newWorld(0, 0)

  collision = map:initWorldCollision(world)

  map:addCustomLayer("Sprite Layer", 2)

  local spriteLayer = map.layers["Sprite Layer"]
  spriteLayer.sprite = {
    image = love.graphics.newImage("assets/images/august01.png"),
    x = 100,
    y = 100,
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
    love.graphics.draw(self.sprite.image, x, y, r, 1, 1, 8, 8)
  end

end

function love.draw()

  love.graphics.scale(3, 3)
  local translateX = 0
  local translateY = 0
  local sprite = map.layers["Sprite Layer"].sprite


  -- note: this no longer accepts scale parameters, thus l.g.scale above
  map:draw()

  love.graphics.setColor(255, 0, 0, 255)
  map:drawWorldCollision(collision)
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.polygon("line", sprite.body:getWorldPoints(sprite.shape:getPoints()))
  love.graphics.setColor(255, 255, 255, 255)

end

function love.update(dt)

  world:update(dt)

  local sprite = map.layers["Sprite Layer"].sprite
  local down = love.keyboard.isDown

  local x, y = 0, 0
  if down("w") or down("up")		then y = y - 4000 end
  if down("s") or down("down")	then y = y + 4000 end
  if down("a") or down("left")	then x = x - 4000 end
  if down("d") or down("right")	then x = x + 4000 end
  sprite.body:applyForce(x, y)
  sprite.x, sprite.y = sprite.body:getWorldCenter()

  map:update(dt)

end

function love.kepressed(key)

end
