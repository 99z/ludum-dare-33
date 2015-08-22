local sti = require "lib/sti"

function love.load()

  BGTiles = love.graphics.newImage('assets/images/map.png')
  BGTiles:setFilter("nearest", "linear")

  TileW, TileH = 16, 16
  local tilesetW, tilesetH = BGTiles:getWidth(), BGTiles:getHeight()

  local quadInfo = {
    { 0, 0 },
    { 16, 0 },
    { 0, 16 },
    { 16, 16 }
  }

  Quads = {}
  for i,info in ipairs(quadInfo) do
    Quads[i] = love.graphics.newQuad(info[1], info[2],
                                     TileW, TileH,
                                     tilesetW, tilesetH )
   end

  TileTable = {
    { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 },
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

  -- for rowIndex = 1, #TileTable do
  --   local row = TileTable[rowIndex]
  --   for columnIndex = 1, #row do
  --     local number = row[columnIndex]
  --     local x = (columnIndex - 1) * TileW * scale
  --     local y = (rowIndex - 1) * TileH * scale
  --     love.graphics.draw(BGTiles, Quads[number], x, y, 0, scale, scale )
  --    end
  --  end

  for rowIndex,row in ipairs(TileTable) do
    for columnIndex,number in ipairs(row) do
      local x,y = (columnIndex - 1) * TileW * scale, (rowIndex - 1) * TileH * scale
      love.graphics.draw(BGTiles, Quads[number], x, y, 0, scale, scale)
    end
  end

end

function love.update(dt)

end

function love.kepressed(key)

end
