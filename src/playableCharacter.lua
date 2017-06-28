
require "mobileObject"
PlayableCharacter = MobileObject:extend()

SPACE_KEY = "space"

INITIAL_JUMP_FORCE = -500
JUMP_FORCE = -3000
MAX_JUMP_FRAMES = 10
FALL_FORCE = 500

function PlayableCharacter:new(x, y, width, height, world)
    PlayableCharacter.super:new(x, y, width, height, world)
    self.jetpackIsOn = false
    self.fixture:setUserData("player") 
    self.contacts = 0
    self.isJumping = false
    self.initialJump = true
    self.jumpFramesLeft = MAX_JUMP_FRAMES
end



function PlayableCharacter:update()

    local velocityX, velocityY = self.body:getLinearVelocity()

    if self.isJumping == true then
        if self.jumpFramesLeft > 0 then
            self.body:applyForce(0, JUMP_FORCE)
            print("ascending: " .. velocityY)
            self.jumpFramesLeft = self.jumpFramesLeft - 1
        else
            self.body:applyForce(0, FALL_FORCE)
            print("not ascending" .. velocityY)
        end
        
    else
        self.body:applyForce(0, FALL_FORCE)
    end


    if self.jetpackIsOn == true then
        if velocityY > 0 then
            -- body
            self.body:applyForce(0, -1000)
            print("jetpack is on")
        end
        if velocityY > 100 then
            self.body:applyForce(0, -2000)
            print("jetpack is higher")
        end
        
    end
end


function PlayableCharacter:draw()

end


function PlayableCharacter:jump()
    if self.initialJump == true then
        print("impulse")
        self.body:applyLinearImpulse(0, INITIAL_JUMP_FORCE)
        self.initialJump = false
    end
end


function PlayableCharacter:handleInputPressed(button)
    
    if button == SPACE_KEY then
        print("about to jump")
        self:jump()
        self.isJumping = true
    end

end


function PlayableCharacter:handleInputReleased(button)
    print("input released")
    self.initialJump = true
    self.jumpFramesLeft = MAX_JUMP_FRAMES
    if button == SPACE_KEY then
        self.isJumping = false
    end
end


