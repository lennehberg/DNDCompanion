Tile = Class{}

function Tile:init(x, y)
    self.x = x
    self.y = y
    self.selected = false
end

function Tile:update(dt)

end

function Tile:render()
    love.graphics.draw(gTextures['map-tiles'], gFrames['map-tiles'][107], 
    (self.x - 1) * TILE_SIZE + MAP_RENDER_OFFSET_X,
    (self.y - 1) * TILE_SIZE + MAP_RENDER_OFFSET_Y,
    0, 
    4,
    4)
    if self.selected then
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.rectangle("line", (self.x) * TILE_SIZE, (self.y + 0.45) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
        love.graphics.setColor(255, 255, 255, 255)
    end
end