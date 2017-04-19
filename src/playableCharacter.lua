
require "mobileObject"
PlayableCharacter = MobileObject:extend()

function PlayableCharacter:new(x, y, width, height, world)
    PlayableCharacter.super:new(x, y, width, height, world)
    self.jetpackIsOn = false
    self.fixture:setUserData("player") 
    self.contacts = 0
end


function PlayableCharacter:update()

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


function PlayableCharacter:handleInputPressed(button)

end


function PlayableCharacter:handleInputReleased(button)

end