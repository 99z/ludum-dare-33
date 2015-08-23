splash = {}

function splash.load()
  splash.dt_temp = 0
end

function splash.draw()

  love.graphics.setColor(100,100,100)

  love.graphics.draw(title, 20, 20)

  love.graphics.setColor(255, 255, 255)
end

function splash.update(dt)

end

function splash.keypressed(key)

end
