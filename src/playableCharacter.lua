
require "mobileObject"
PlayableCharacter = MobileObject:extend()

KEY_SPACE = "space"
KEY_LEFT = "a"
KEY_RIGHT = "d"
KEY_UP = "w"
KEY_DOWN = "s"

INITIAL_JUMP_FORCE = -500
JUMP_FORCE = -3000
MAX_JUMP_FRAMES = 10
FALL_FORCE = 500

function PlayableCharacter:new(x, y, width, height, world)
    PlayableCharacter.super:new(x, y, width, height, world)

end



function PlayableCharacter:update(deltaTime)
    PlayableCharacter.super:update(deltaTime)
    print("go " .. self.shouldGoLeft)
    if self.shouldGoLeft == true then
        print("go left " .. self.shouldGoLeft)
        self.x = self.x + (5*deltaTime)
        print("go left " .. self.shouldGoRight)
    elseif self.shouldGoRight == true then
        self.x = self.x - (5*deltaTime)
    end
end


function PlayableCharacter:draw()
    PlayableCharacter.super:draw()
end


function PlayableCharacter:jump()

end


function PlayableCharacter:handleInputPressed(button)
    print("button pressed: " .. button)
    if button == KEY_LEFT then
        print("go left")
        self.shouldGoLeft = true
        self.shouldGoRight = false
    elseif button == KEY_RIGHT then
        print("go right")
        self.shouldGoRight = true
        self.shouldGoLeft = false
    end

end


function PlayableCharacter:handleInputReleased(button)
    self.shouldGoRight = false
    self.shouldGoLeft = false
end


