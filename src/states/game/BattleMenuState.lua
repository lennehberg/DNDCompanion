BattleMenuState = Class{__includes = BaseState}

function BattleMenuState:init(playState, character)
    self.playState = playState

    self.battleMenu = Menu {
        x = VIRTUAL_WIDTH - 64,
        y = VIRTUAL_HEIGHT - 64,
        width = 64, 
        height = 64,
        character = character,
        items = {
            {
                text = 'Move',
                onSelect = function()
                    playState.takeTurn = 'move'
                    gStateStack:pop()
                end
            },
            {
                text = 'Action',
                onSelect = function()
                    if not character.takenAction then
                        playState.takeTurn = 'action'
                        character.takenAction = not character.takenAction
                    end
                    gStateStack:pop()
                end
            },
            {
                text = 'End',
                onSelect = function ()
                -- character.finished = true
                playState.takeTurn = 'end'
                gStateStack:pop()
                end
            }
        }
    }
end

function BattleMenuState:update(dt)
    self.battleMenu:update(dt)
end

function BattleMenuState:render()
    self.battleMenu:render()
end