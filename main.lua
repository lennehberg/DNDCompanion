-- Welcome to D&D Companion
love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src/Dependencies'

function love.load()
    love.window.setTitle('D&D Companion')

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.KeysPressed = {}
    love.mouse.KeysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.KeysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.KeysPressed[key]
end

function love.mousepressed(key)
    love.mouse.KeysPressed[key] = true
end

function love.mouse.wasPressed(key)
    return love.mouse.KeysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    if love.keyboard.wasPressed('tab') then
        local state = not love.mouse.isGrabbed()
        love.mouse.setGrabbed(state)
    end

    love.keyboard.KeysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    gStateStack:render()
    push:finish()
end

