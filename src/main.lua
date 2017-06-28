--[[
    global variables
]]

require "playableCharacter"

RECTANGLE_MODE_FILL = "fill"
KEYBOARD_DOWN_LEFT = "left"
KEYBOARD_DOWN_RIGHT = "right"
KEYBOARD_DOWN_DOWN = "down"
KEYBOARD_DOWN_UP = "up"

WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 768

PLAYER_MAX_VELOCITY_RIGHT = 400
PLAYER_MAX_VELOCITY_LEFT = -400

--[[
    love callbacks
]]

-- called once at start
function love.load()
    createRect()
    --noinspection GlobalCreationOutsideO
    listOfEnemies = {}
    listOfProjectiles = {}

    -- PHYSICS START
    love.physics.setMeter(64) --the height of a meter our worlds will be 64px
    world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    objects = {} -- table to hold all our physical objects

    --let's create the ground
    ground = {}
    ground.body = love.physics.newBody(world, WINDOW_WIDTH/2, WINDOW_HEIGHT-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    ground.shape = love.physics.newRectangleShape(WINDOW_WIDTH, 50) --make a rectangle with a width of 650 and a height of 50
    ground.fixture = love.physics.newFixture(ground.body, ground.shape) --attach shape to body
    ground.fixture:setUserData("ground")

    platform1 = {}
    platform1.body = love.physics.newBody(world, 200, 200)
    platform1.shape = love.physics.newRectangleShape(60, 20)
    platform1.fixture = love.physics.newFixture(platform1.body, platform1.shape)
    platform1.fixture:setUserData("platform1")

        platform2 = {}
    platform2.body = love.physics.newBody(world, 700, 500)
    platform2.shape = love.physics.newRectangleShape(60, 20)
    platform2.fixture = love.physics.newFixture(platform2.body, platform2.shape)
    platform2.fixture:setUserData("platform2")

        platform3 = {}
    platform3.body = love.physics.newBody(world, 400, 450)
    platform3.shape = love.physics.newRectangleShape(60, 20)
    platform3.fixture = love.physics.newFixture(platform3.body, platform3.shape)
    platform3.fixture:setUserData("platform3")
    
    --[[let's create a ball
    ball = {}
    ball.body = love.physics.newBody(world, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
    ball.shape = love.physics.newCircleShape( 20) --the ball's shape has a radius of 20
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1) -- Attach fixture to body and give it a density of 1.
    ball.fixture:setUserData("ball")
    ]]

    --let's create a couple blocks to play around with
    createPlayer()

    --ball.fixture:setRestitution(0.9) --let the ball bounce

    love.graphics.setBackgroundColor(0, 0, 0) --set the background color to a nice blue
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
    -- PHYSICS END
end

-- called each frame
function love.update(deltaTime)
    handleKeyboard(deltaTime)

    for i,v in ipairs(listOfEnemies) do
        v.x = v.x + v.speed * deltaTime
    end

    for i,aProjectile in ipairs(listOfProjectiles) do
        aProjectile.body:setLinearVelocity(1100, 0)
    end

    world:update(deltaTime) --this puts the world into motion

    --[[here we are going to create some keyboard events
    if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
        ball.body:applyForce(400, 0)
    elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
        ball.body:applyForce(-400, 0)
    elseif love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
        ball.body:setPosition(650/2, 650/2)
        ball.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
    end
    ]]

    player:update()
end

-- called each frame
function love.draw()
    love.graphics.rectangle(RECTANGLE_MODE_FILL, rect.x, rect.y, rect.width, rect.height)
    for i,v in ipairs(listOfEnemies) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end

    love.graphics.setColor(51, 26, 0) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

        love.graphics.setColor(151, 26, 0) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", platform1.body:getWorldPoints(platform1.shape:getPoints()))

        love.graphics.setColor(51, 126, 0) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", platform2.body:getWorldPoints(platform2.shape:getPoints()))

        love.graphics.setColor(51, 26, 100) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", platform3.body:getWorldPoints(platform3.shape:getPoints()))
    
    --love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    --love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
    
    love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
    love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))

    for i,aBullet in ipairs(listOfProjectiles) do
        love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
        love.graphics.polygon("fill", aBullet.body:getWorldPoints(aBullet.shape:getPoints()))
    end

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
    player:handleInputPressed(key)
end

function love.keyreleased(key)
    print("key released")
    player:handleInputReleased(key)
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


function createPlayer()
    WALKING_DIRECTION_NONE = "none"
    WALKING_DIRECTION_LEFT = "left"
    WALKING_DIRECTION_RIGHT = "right"
    player = PlayableCharacter(200, 500, 30, 60, world)
end

function createProjectile()
    projectile = {}
    projectile.body = love.physics.newBody(world, player.body:getX() + 15, player.body:getY(), "dynamic")
    projectile.shape = love.physics.newRectangleShape(0, 0, 20, 2)
    projectile.fixture = love.physics.newFixture(projectile.body, projectile.shape, 5) -- A higher density gives it more mass.
    projectile.fixture:setUserData("projectile")
    projectile.fixture:setRestitution(0.4)

    table.insert(listOfProjectiles, projectile)
end


function love.gamepadpressed(joystick, button)
    print("button: " .. button)
    if button == "a" then
        -- jump
        if(player.contacts > 0) then
            player.body:applyLinearImpulse(0,-1000)
        else
            -- we are in mid air: jetpack time!
            player.jetpackIsOn = true
        end
    elseif button == "x" then
        -- shoot primary
    elseif button == "dpleft" then
        -- walk left
        player.walking = WALKING_DIRECTION_LEFT
    elseif button == "dpright" then
        -- walk right
        player.walking = WALKING_DIRECTION_RIGHT
    end
end

function love.gamepadreleased(joystick, button)
    print("button: " .. button)
    if button == "a" then
        -- jump
        player.jetpackIsOn = false
    elseif button == "x" then
        -- shoot primary
        createProjectile()
    elseif button == "dpleft" then
        -- walk left
        player.walking = WALKING_DIRECTION_NONE
    elseif button == "dpright" then
        -- walk right
        player.walking = WALKING_DIRECTION_NONE
    end
end


--[[
    world callbacks
]]

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    print(a:getUserData() .. " colliding with "..b:getUserData() .. " with a vector normal of" .. x .. "/" .. y)
    if a:getUserData() == "player" or b:getUserData() == "player" then
        if y < 0 then
            player.contacts = 1
        end
        
    end
    print(player.contacts)
end
 
 
function endContact(a, b, coll)
    x,y = coll:getNormal()
    print(a:getUserData() .. " collided with "..b:getUserData() .. " with a vector normal of" .. x .. "/" .. y)
    if a:getUserData() == "player" or b:getUserData() == "player" then
        player.contacts = 0
    end
    print(player.contacts)
end
 
function preSolve(a, b, coll)

end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
-- we won't do anything with this function
end