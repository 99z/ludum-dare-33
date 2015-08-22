function love.load()

  BGTiles = love.graphics.newImage('assets/images/map.png')

  TileW, TileH = 16, 16
  local tilesetW, tilesetH = BGTiles:getWidth(), BGTiles:getHeight()

  Quads = {
    -- 1 flowers
    love.graphics.newQuad(0, 0, TileW, TileH, tilesetW, tilesetH),
    -- 2 earth
    love.graphics.newQuad(16, 0, TileW, TileH, tilesetW, tilesetH),
    -- 3 dirt
    love.graphics.newQuad(0, 16, TileW, TileH, tilesetW, tilesetH),
    -- 4 bin
    love.graphics.newQuad(16, 16, TileW, TileH, tilesetW, tilesetH)
  }

  TileTable = {
    { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 },
    { 3, 3, 4, 3, 4, 3, 3, 4, 3, 3 },
    { 3, 3, 4, 3, 4, 3, 3, 4, 3, 3 },
    { 3, 3, 4, 3, 4, 3, 3, 4, 3, 3 },
    { 3, 3, 4, 4, 4, 3, 3, 4, 3, 3 },
    { 3, 3, 4, 3, 4, 3, 3, 4, 3, 3 },
    { 3, 3, 4, 3, 4, 3, 3, 4, 3, 3 },
    { 3, 3, 4, 3, 4, 3, 3, 4, 3, 3 },
    { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 },
  }

end

function love.draw()

  for rowIndex = 1, #TileTable do
    local row = TileTable[rowIndex]
    for columnIndex = 1, #row do
      local number = row[columnIndex]
      local x = (columnIndex - 1) * TileW * scale
      local y = (rowIndex - 1) * TileH * scale
      love.graphics.draw(BGTiles, Quads[number], x, y, 0, scale, scale )
     end
   end


end

function love.update(dt)

end

function love.kepressed(key)

end
