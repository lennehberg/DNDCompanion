Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = def.font or gFonts['small']

    self.character = def.character

    self.gapHeight = self.height / #self.items

    self.currentSelection = 1
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') then
        if self.currentSelection == 1 then
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
            -- if the player already took an action, skip the selection
            if self.currentSelection == 2 and self.character.takenAction then
                self.currentSelection = self.currentSelection - 1
            end
        end
    elseif love.keyboard.wasPressed('down') then
        if self.currentSelection == #self.items then
            self.currentSelection = 1
        else
            self.currentSelection = self.currentSelection + 1
             -- if the player already took an action, skip the selection
            if self.currentSelection == 2 and self.character.takenAction then
                self.currentSelection = self.currentSelection + 1
            end
        end
    elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        self.items[self.currentSelection].onSelect()
    end
end

function Selection:render()
    love.graphics.setColor(255, 255, 255, 255)
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw un-selectable in grey with low alpha (doesn't work)
        if i == 2 and self.character.takenAction then
            love.graphics.setColor(178, 153, 110, 50)
            love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, "center")
            currentY = currentY + self.gapHeight
            
        -- draw selection in red font if we're at the right index
        elseif i == self.currentSelection then
            love.graphics.setColor(255, 0, 0, 255)
            love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')
            currentY = currentY + self.gapHeight
            love.graphics.setColor(255, 255, 255, 255)
        else
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')
            currentY = currentY + self.gapHeight
            love.graphics.setColor(255, 255, 255, 255)
        end
    end
    love.graphics.setColor(255, 255, 255, 255)
end