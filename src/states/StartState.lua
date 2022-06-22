StartState = Class{__includes = BaseState}
function StartState:init()

end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateStack:pop()
        gStateStack:push(PlayState())
    end
end

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0,
        VIRTUAL_HEIGHT / gTextures['background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('D&D Companion', VIRTUAL_WIDTH / 2 + 100, 30, VIRTUAL_WIDTH, "left")
    -- for y = 1, MAP_HEIGHT, MAP_TILE_SIZE do
    --     for x = 1, MAP_WIDTH, MAP_TILE_SIZE do
    --         love.graphics.draw(gTextures['map-tiles'], x + MAP_TILE_SIZE, y + MAP_TILE_SIZE , 0,
    --         TILE_SIZE, TILE_SIZE)
    --     end
    -- end
end
