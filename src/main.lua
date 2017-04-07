--[[
    global variables
]]

RECTANGLE_MODE_FILL = "fill"
KEYBOARD_DOWN_LEFT = "left"
KEYBOARD_DOWN_RIGHT = "right"
KEYBOARD_DOWN_DOWN = "down"
KEYBOARD_DOWN_UP = "up"


rectangleVelocity = 80;
rectangleX = 0
rectangleY = 0

--[[
    love callbacks
]]

-- called once at start
function love.load()
    
end

-- called each frame
function love.update(deltaTime)
    handleKeyboard(deltaTime)
end

-- called each frame
function love.draw()
    love.graphics.rectangle(RECTANGLE_MODE_FILL, rectangleX, rectangleY, 30, 50)
end


--[[
    input handler
]]

function handleKeyboard(deltaTime)
    if love.keyboard.isDown(KEYBOARD_DOWN_LEFT) then
        rectangleX = rectangleX - rectangleVelocity * deltaTime
    end
    if love.keyboard.isDown(KEYBOARD_DOWN_RIGHT) then
        rectangleX = rectangleX + rectangleVelocity * deltaTime
    end
    if love.keyboard.isDown(KEYBOARD_DOWN_DOWN) then
        rectangleY = rectangleY + rectangleVelocity * deltaTime
    end
    if love.keyboard.isDown(KEYBOARD_DOWN_UP) then
        rectangleY = rectangleY - rectangleVelocity * deltaTime
    end
end
