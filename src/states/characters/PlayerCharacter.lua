PlayerCharacter = Class{}

function PlayerCharacter:init(params, class)
    self.x = params.x
    self.y = params.y
    self.type = params.type

    self.race = params.race
    self.subrace = params.subrace

    self.class = class
    self.class.subclass = self.class.subclass
    self.level = params.level

    self.prof = math.floor(1 + (self.level / 4))

    self.stats = {
        ['str'] = params.str,
        ['dex'] = params.dex,
        ['const'] = params.const,
        ['int'] = params.int,
        ['wis'] = params.wis,
        ['chr'] = params.chr
    }

    self.modifiers = {
        ['strMod'] = math.floor((self.stats['str'] - 10) / 2),
        ['dexMod'] = math.floor((self.stats['dex'] - 10) / 2),
        ['constMod'] = math.floor((self.stats['const'] - 10) / 2),
        ['intMod'] = math.floor((self.stats['int'] - 10) / 2),
        ['wisMod'] = math.floor((self.stats['wis'] - 10) / 2),
        ['chrMod'] = math.floor((self.stats['chr'] - 10) / 2)
    }

    self.health = params.health + self.modifiers['constMod'] * self.level
    self.initiative = self.modifiers['dexMod']
    self.speed = (params.speed / 5)
    self.remainingSpeed = self.speed

    self.armorClass = 10 + self.modifiers['dexMod']

    self.SpellMod = self.modifiers[self.class.spellMod]
    self.SpellAttack = self.class:CalculateSpellAttack(self.prof, self.SpellMod)
    self.SpellSave = self.class:CalculateSpellAttack(self.prof, self.SpellMod)

    self.tileX = 0
    self.tileY = 0

    self.takenAction = false
    self.takenBonusAction = false
    self.finished = true
end

function PlayerCharacter:update(dt)

end

function PlayerCharacter:action(enemy)
    self.spell = Spell(self.x, self.y - 1)
    local toHit = math.random(20) + self.SpellAttack
    self.spell:shoot(enemy, toHit)
end

function PlayerCharacter:damage(dmg)
    self.health = self.health - dmg
end

function PlayerCharacter:move(tile)
    
    -- figure out distance to tile
    self.tileX = tile.x
    self.tileY = tile.y
    if ((math.abs(self.x - self.tileX)) > self.speed) or
     ((math.abs(self.y - self.tileY)) > self.speed) then
        goto continue
    else
        -- calculate how much speed player has left
        -- TODO
        -- tween position to the tile position 
        Timer.tween(1,{
            [self] = {x = tile.x, y = tile.y},
        })
        :finish(function() tile.selected = false end)
        return true
    end
    :: continue ::
    
end



function PlayerCharacter:render()
    -- health debug
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('health: ' .. self.health, self.x + MAP_RENDER_OFFSET_X, self.y + MAP_RENDER_OFFSET_Y, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    if self.health > 0 then
        
        love.graphics.draw(gTextures['entities'], gFrames['entities'][2],
                            (self.x - 1) * TILE_SIZE + MAP_RENDER_OFFSET_X,
                            (self.y - 1) * TILE_SIZE + MAP_RENDER_OFFSET_Y, 0,
                            2.5, 2.5)
    end

    if not (self.spell == nil) then
        self.spell:render()
    end
    -- position debug
    -- love.graphics.setFont(gFonts['small'])
    -- love.graphics.setColor(34/255, 34/255, 34/255, 1)
    -- love.graphics.printf(self.remainingSpeed, self.x + MAP_RENDER_OFFSET_X, self.y + MAP_RENDER_OFFSET_Y, VIRTUAL_WIDTH, "center")    
end