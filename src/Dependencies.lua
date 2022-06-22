Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/const'
require 'src/StateMachine'
require 'src/Util'

require 'src/gui/Menu'
require 'src/gui/Panel'
require 'src/gui/Selection'
require 'src/gui/Textbox'

require 'src/states/StateStack'
require 'src/states/BaseState'

require 'src/states/StartState'
require 'src/states/PlayState'

require 'src/states/world/Tile'
require 'src/states/world/Map'
require 'src/states/world/Level'

require 'src/states/characters/PlayerCharacter'
require 'src/states/characters/PlayerClass'

require 'src/states/characters/defs/classes_defs'

require 'src/states/game/BattleMenuState'
require 'src/states/game/Spell'

gTextures = {
    ['map-tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['background'] = love.graphics.newImage('graphics/background.jpeg'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['firebolt'] = love.graphics.newImage('graphics/spark3.png')
}

gFrames = {
    ['map-tiles'] = GenerateQuads(gTextures['map-tiles'], 16, 16),
    ['entities'] = GenerateEntityQuads(gTextures['entities'], 24, 20),
    ['firebolt'] = GenerateEntityQuads(gTextures['firebolt'], 32, 32)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/font.ttf' , 64)
}

