return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.13.0",
  orientation = "orthogonal",
  width = 20,
  height = 18,
  tilewidth = 8,
  tileheight = 8,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "map",
      firstgid = 1,
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      image = "assets/images/map.png",
      imagewidth = 32,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 16,
      tiles = {
        {
          id = 10,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 11,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 14,
          properties = {
            ["collidable"] = "true"
          }
        },
        {
          id = 15,
          properties = {
            ["collidable"] = "true"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 20,
      height = 18,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12,
        15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16,
        11, 12, 9, 9, 9, 9, 9, 9, 9, 10, 9, 9, 9, 9, 9, 9, 9, 10, 11, 12,
        15, 16, 9, 10, 13, 13, 13, 13, 9, 9, 13, 13, 13, 13, 13, 9, 9, 10, 15, 16,
        11, 12, 9, 5, 10, 10, 10, 10, 5, 13, 13, 5, 5, 5, 5, 5, 9, 10, 11, 12,
        15, 16, 13, 5, 9, 10, 10, 10, 5, 13, 14, 13, 13, 5, 9, 9, 10, 10, 15, 16,
        11, 12, 9, 5, 9, 10, 14, 14, 5, 9, 13, 14, 10, 5, 13, 9, 9, 10, 11, 12,
        15, 16, 9, 5, 9, 10, 13, 14, 5, 13, 9, 13, 14, 5, 13, 13, 9, 10, 15, 16,
        11, 12, 13, 5, 5, 5, 5, 5, 5, 9, 10, 13, 9, 5, 13, 13, 9, 10, 11, 12,
        15, 16, 9, 5, 10, 13, 9, 9, 5, 9, 9, 9, 9, 5, 13, 13, 9, 10, 15, 16,
        11, 12, 9, 5, 10, 10, 10, 10, 5, 9, 9, 9, 13, 5, 9, 13, 9, 10, 11, 12,
        15, 16, 9, 5, 14, 14, 14, 10, 5, 13, 13, 13, 13, 5, 13, 13, 9, 10, 15, 16,
        11, 12, 9, 5, 9, 9, 9, 10, 5, 10, 13, 14, 14, 5, 13, 9, 10, 10, 11, 12,
        15, 16, 13, 5, 9, 9, 9, 9, 5, 9, 9, 5, 5, 5, 5, 5, 14, 14, 15, 16,
        11, 12, 9, 13, 13, 9, 9, 13, 9, 9, 9, 9, 13, 13, 13, 14, 10, 10, 11, 12,
        15, 16, 13, 13, 14, 13, 13, 14, 13, 13, 13, 13, 13, 14, 13, 14, 14, 14, 15, 16,
        11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12, 11, 12,
        15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16, 15, 16
      }
    }
  }
}
