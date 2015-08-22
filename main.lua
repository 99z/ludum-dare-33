local sti = require "lib/sti"

function love.load()

  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  love.physics.setMeter(8)

  map = sti.new("testmap.lua")
  world = love.physics.newWorld(0, 0)

  collision = map:initWorldCollision(world)

end

function love.draw()

  love.graphics.scale(3, 3)
  local translateX = 0
  local translateY = 0

  map:draw()
  love.graphics.setColor(255, 255, 255, 255)

end

function love.update(dt)

  map:update(dt)

end

function love.kepressed(key)

end
