
require "mobileObject"
PlayableCharacter = MobileObject:extend()

SPACE_KEY = "space"

function PlayableCharacter:new(x, y, width, height, world)
    PlayableCharacter.super:new(x, y, width, height, world)
    self.jetpackIsOn = false
    self.fixture:setUserData("player") 
    self.contacts = 0
    self.isJumping = false
    self.initialJump = true
end



function PlayableCharacter:update()

    if self.isJumping == true then
        self.body:applyForce(0, -1000)
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
        self.body:applyLinearImpulse(0,-500)
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
    if button == SPACE_KEY then
        self.isJumping = false
    end
end


