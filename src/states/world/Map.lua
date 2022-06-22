Map = Class{}

function Map:init(width, height)
    self.tiles = {}
    self.width = width
    self.height = height
end

function Map:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.tiles[y][x]:render()
        end
    end
end