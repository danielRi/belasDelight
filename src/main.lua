--[[
    global variables
]]

RECTANGLE_MODE_FILL = "fill"
KEYBOARD_DOWN_LEFT = "left"
KEYBOARD_DOWN_RIGHT = "right"
KEYBOARD_DOWN_DOWN = "down"
KEYBOARD_DOWN_UP = "up"


--[[
    love callbacks
]]

-- called once at start
function love.load()
    createRect()
    listOfEnemies = {}
end

-- called each frame
function love.update(deltaTime)
    handleKeyboard(deltaTime)

    for i,v in ipairs(listOfEnemies) do
        v.x = v.x + v.speed * deltaTime
    end
end

-- called each frame
function love.draw()
    love.graphics.rectangle(RECTANGLE_MODE_FILL, rect.x, rect.y, rect.width, rect.height)
    for i,v in ipairs(listOfEnemies) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end
end


--[[
    input handler
]]

function handleKeyboard(deltaTime)
    if love.keyboard.isDown(KEYBOARD_DOWN_LEFT) then
        rect.x = rect.x - rect.speed * deltaTime
    end
    if love.keyboard.isDown(KEYBOARD_DOWN_RIGHT) then
        rect.x = rect.x + rect.speed * deltaTime
    end
    if love.keyboard.isDown(KEYBOARD_DOWN_DOWN) then
        rect.y = rect.y + rect.speed * deltaTime
    end
    if love.keyboard.isDown(KEYBOARD_DOWN_UP) then
        rect.y = rect.y - rect.speed * deltaTime
    end

end

function love.keypressed(key)
    if key == "space" then
        createBullet()
    end
end


--[[
    helper functions
]]

function createRect()
    rect = {}
    rect.x = 100
    rect.y = 100
    rect.width = 70
    rect.height = 90
    rect.speed = 300
end


function createBullet()
    bullet = {}
    bullet.x = rect.x
    bullet.y = rect.y
    bullet.width = 20
    bullet.height = 20
    bullet.speed = 1000

    --Put the new rectangle in the list
    table.insert(listOfEnemies, bullet)
end