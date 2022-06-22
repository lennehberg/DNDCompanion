Level = Class{}

-- function Level:init()
--     self.map = Map()

--     self:createMap()
-- end

-- -- function Level:createMap()
-- --     for y = 1, TILE_SIZE, TILE_SIZE do
-- --         for x = 1, MAP_WIDTH, TILE_SIZE do
-- --             table.insert(self.map.tiles, Tile(x, y))
-- --         end
-- --     end
-- -- end
-- function Level:createMap()
--     for y = 1, TILE_SIZE, TILE_SIZE do
--         table.insert(self.map.tiles, {})
--         for x = 1, TILE_SIZE, TILE_SIZE do
--             table.insert(self.map.tiles[y], Tile(x, y))
--         end
--     end
-- end
function Level:init()
    self.tileWidth = MAP_WIDTH
    self.tileHeight = MAP_HEIGHT
    self.map = Map(self.tileWidth, self.tileHeight)

    self:createMap()
end

function Level:createMap()
    for y = 1, self.tileHeight do
        table.insert(self.map.tiles, {})
        for x = 1, self.tileWidth do
            table.insert(self.map.tiles[y], Tile(x, y))
        end
    end
end