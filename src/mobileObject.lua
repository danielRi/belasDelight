
Object = require "classic"
MobileObject = Object:extend()

WALKING_DIRECTION_NONE = "none"
WALKING_DIRECTION_LEFT = "left"
WALKING_DIRECTION_RIGHT = "right"

STANDARD_MASS = 4

function MobileObject:new(x, y, width, height, world)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newRectangleShape(0, 0, width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape, STANDARD_MASS) -- A higher density gives it more mass.
    self.body:setFixedRotation(true)
    self.walking = WALKING_DIRECTION_NONE
end


function MobileObject:update()
    local velocityX, velocityY = self.body:getLinearVelocity()
    if self.walking == WALKING_DIRECTION_LEFT then
        
        if velocityX <= PLAYER_MAX_VELOCITY_LEFT then
            self.body:setLinearVelocity(PLAYER_MAX_VELOCITY_LEFT, velocityY)
        else
            self.body:applyForce(-2000, 0)
        end
        self.body:applyForce(-2000, 0)
    elseif self.walking == WALKING_DIRECTION_RIGHT then
        if velocityX >= PLAYER_MAX_VELOCITY_RIGHT then
            self.body:setLinearVelocity(PLAYER_MAX_VELOCITY_RIGHT, velocityY)
        else
            self.body:applyForce(2000, 0)
        end
    end

end


function MobileObject:draw()

end

