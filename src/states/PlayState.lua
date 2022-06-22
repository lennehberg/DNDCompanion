PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level()
    self.mouseX = 0
    self.mouseY = 0

    self.player = PlayerCharacter({x = self.level.map.tiles[14][15].x, y = self.level.map.tiles[14][15].y, type = 'player',
                                str = 10,
                                dex = 15,
                                const = 19,
                                int = 20,
                                wis = 18,
                                chr = 13,
                                level = 5,
                                health = 6,
                                speed = 30},
                                PlayerClass(CLASSES_DEFS['wizard'], 'Abjuration'))

    self.enemy = PlayerCharacter({x = self.level.map.tiles[1][15].x, y = self.level.map.tiles[1][15].y, type = 'enemy',
                                str = 10,
                                dex = 13,
                                const = 19,
                                int = 20,
                                wis = 18,
                                chr = 13,
                                level = 5,
                                health = 6,
                                speed = 30},
                                PlayerClass(CLASSES_DEFS['wizard'], 'Abjuration'))
    

    self.takeTurn = 'menu'

    self.counter = 1
    self.order = {}
    -- calculate initiative
    self:rollInitiative()
end

function PlayState:rollInitiative()
    local playerInitiative = math.random(20) + self.player.initiative
    local enemyInitiative = math.random(20) + self.enemy.initiative

    if playerInitiative < enemyInitiative then
        self.enemy.finished = false
        table.insert(self.order, 1, self.enemy)
        table.insert(self.order, 2, self.player)
    else
        self.player.finished = false
        table.insert(self.order, 1, self.player)
        table.insert(self.order, 2, self.enemy)
    end
    
end

function PlayState:update(dt)
    
    -- if the character going is a player character, the proceed with pushing menu
    if self.order[self.counter].type == 'player' and not self.order[self.counter].finished then
        -- if a turn hasn't been taken yet, push the battle menu state
        if self.takeTurn == 'menu' then
            gStateStack:push(BattleMenuState(self, self.order[self.counter]))
        -- if a player selected move, proceed with moving player
        elseif self.takeTurn == 'move' then
            self:move()   
        elseif self.takeTurn == 'action' then
            self:action(self.enemy)  
        elseif self.takeTurn == 'end' then
            self.order[self.counter].takenAction = false
            -- at the end of the turn, go to the next character in the initiative count
            self.order[self.counter].finished = true
            -- if this character is the last in the intiative count, 
            -- go back to the top of the initiative count
            if self.order[self.counter + 1] == nil then
                self.counter = 1
            -- if there are characters after this intiative count,
            -- start their turn and continue with the game
            else
                self.counter = self.counter + 1
            end
            self.order[self.counter].finished = false
        end
    -- enemy turn
    elseif self.order[self.counter].type == 'enemy' and not self.order[self.counter].finished then
        -- process AI for enemy characters
        self.order[self.counter]:action(self.player)
        self.order[self.counter].finished = true

        -- at the end of the turn, if there are no more characters in the intiative order, 
        -- go back to the top of the intiative count
        if self.order[self.counter + 1] == nil then
            self.counter = 1
        -- if there are characters after this intiative count,
        -- start their turn and continue the game
        else
            self.counter = self.counter + 1
        end
        self.order[self.counter].finished = false
        -- push the menu 1 second after the turn has finished, to let spell affects take place
        self.takeTurn = ''
        Timer.after(1, function ()
            self.takeTurn = 'menu'
        end)
    end
    
    
end

function PlayState:action(enemy)
    self.player:action(enemy)
    
    self.takeTurn = ''
    
    -- push the menu 1 second after the turn has finished, to let the spell affects take place
    Timer.after(1, function ()
        self.takeTurn = 'menu'
    end)
end

function PlayState:move()
    -- select a tile on mouse click
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    -- transform position of the mouse to grid cooridnates
    mouseX = mouseX / 48
    mouseY = mouseY / 46.5 - 1.5
    
    self.mouseX = math.floor(mouseX)
    self.mouseY = math.floor(mouseY)
    -- out of bounds detection according to number of tiles
    if (self.mouseX < 1) or (self.mouseY < 1) or
        (self.mouseX > 28) or (self.mouseY > 14) then
        goto continue
    -- move player to selected tile
    elseif love.mouse.isDown(1) then
        self.level.map.tiles[self.mouseY][self.mouseX].selected = true
        local moved = self.player:move(self.level.map.tiles[self.mouseY][self.mouseX])
        if not moved then
            Timer.after(1, function() 
                self.level.map.tiles[self.mouseY][self.mouseX].selected = false
            end)
        else
            Timer.after(1, function ()
                self.takeTurn = 'menu'
            end)
        end
    end
    :: continue ::
    
end

function PlayState:render()
    self.level.map:render()
    self.player:render()
    self.enemy:render()
    -- debug for mouse postion
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Mouse Position x:' .. self.mouseX .. ' Mouse Position y: ' .. self.mouseY, VIRTUAL_WIDTH / 2, 30, VIRTUAL_WIDTH, "left")
    love.graphics.printf('take turn: '.. self.order[self.counter].type .. ''.. tostring(self.order[1].finished) .. ' Y' .. self.level.map.tiles[1][1].y, 0, 0, VIRTUAL_WIDTH, "center")
end