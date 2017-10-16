
Object = require "classic"
MobileObject = Object:extend()

GRAVITY = 0.5

function MobileObject:new(x, y, width, height, world)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.world = world
end


function MobileObject:update()



end


function MobileObject:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

