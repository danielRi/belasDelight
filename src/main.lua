--[[
    global variables
]]

require "playableCharacter"

--[[
    love callbacks
]]

-- called once at start
function love.load()

end

-- called each frame
function love.update(deltaTime)

end

-- called each frame
function love.draw()

end


--[[
    input handler
]]

function handleKeyboard(deltaTime)


end


function love.keypressed(key)

end

function love.keyreleased(key)

end

function love.gamepadpressed(joystick, button)

end

function love.gamepadreleased(joystick, button)

end


--[[
    helper functions
]]






--[[
    world callbacks
]]

function beginContact(a, b, coll)

end
 
 
function endContact(a, b, coll)

end
 
function preSolve(a, b, coll)

end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
-- we won't do anything with this function
end