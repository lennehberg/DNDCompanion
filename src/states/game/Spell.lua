Spell = Class{}

function Spell:init(x, y)
    self.x = x
    self.y = y

    self.play = true
end

function Spell:update(dt)

end

function Spell:shoot(target, toHit)
    Timer.tween(1, {
        [self] = {x = target.x, y = target.y}
    }):finish (function() 
        self.play = false
        if toHit > target.armorClass then
            self:damage(target)
        end
    end)
end

function Spell:damage(target)
    local damage = math.random(10)
    target:damage(damage)
end

function Spell:render()
    if self.play then
        love.graphics.draw(gTextures['firebolt'],
                            (self.x - 1) * TILE_SIZE + MAP_RENDER_OFFSET_X,
                            (self.y - 1) * TILE_SIZE + MAP_RENDER_OFFSET_Y, 0, 
                            2.5, 2.5)
    end
end