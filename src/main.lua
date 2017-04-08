--[[
    global variables
]]

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
    listOfEnemies = {}
    listOfProjectiles = {}

    -- PHYSICS START
    love.physics.setMeter(64) --the height of a meter our worlds will be 64px
    world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

    objects = {} -- table to hold all our physical objects

    --let's create the ground
    ground = {}
    ground.body = love.physics.newBody(world, WINDOW_WIDTH/2, WINDOW_HEIGHT-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    ground.shape = love.physics.newRectangleShape(WINDOW_WIDTH, 50) --make a rectangle with a width of 650 and a height of 50
    ground.fixture = love.physics.newFixture(ground.body, ground.shape) --attach shape to body
    
    --let's create a ball
    ball = {}
    ball.body = love.physics.newBody(world, WINDOW_WIDTH/2, WINDOW_HEIGHT/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
    ball.shape = love.physics.newCircleShape( 20) --the ball's shape has a radius of 20
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1) -- Attach fixture to body and give it a density of 1.

    --let's create a couple blocks to play around with
    createPlayer()

    ball.fixture:setRestitution(0.9) --let the ball bounce

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

    --here we are going to create some keyboard events
    if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
        ball.body:applyForce(400, 0)
    elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
        ball.body:applyForce(-400, 0)
    elseif love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
        ball.body:setPosition(650/2, 650/2)
        ball.body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
    end

    velocityX, velocityY = player.body:getLinearVelocity()
    if player.walking == WALKING_DIRECTION_LEFT then
        
        if velocityX <= PLAYER_MAX_VELOCITY_LEFT then
            player.body:setLinearVelocity(PLAYER_MAX_VELOCITY_LEFT, velocityY)
        else
            player.body:applyForce(-400, 0)
        end
        player.body:applyForce(-400, 0)
    elseif player.walking == WALKING_DIRECTION_RIGHT then
        if velocityX >= PLAYER_MAX_VELOCITY_RIGHT then
            player.body:setLinearVelocity(PLAYER_MAX_VELOCITY_RIGHT, velocityY)
        else
            player.body:applyForce(400, 0)
        end
    end
end

-- called each frame
function love.draw()
    love.graphics.rectangle(RECTANGLE_MODE_FILL, rect.x, rect.y, rect.width, rect.height)
    for i,v in ipairs(listOfEnemies) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
    end

    love.graphics.setColor(51, 26, 0) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
    
    love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
    
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


function createPlayer()
    WALKING_DIRECTION_NONE = "none"
    WALKING_DIRECTION_LEFT = "left"
    WALKING_DIRECTION_RIGHT = "right"
    player = {}
    player.body = love.physics.newBody(world, 200, 550, "dynamic")
    player.shape = love.physics.newRectangleShape(0, 0, 30, 60)
    player.fixture = love.physics.newFixture(player.body, player.shape, 1) -- A higher density gives it more mass.
    player.body:setFixedRotation(true)
    player.walking = WALKING_DIRECTION_NONE
end

function createProjectile()
    projectile = {}
    projectile.body = love.physics.newBody(world, player.body:getX() + 15, player.body:getY(), "dynamic")
    projectile.shape = love.physics.newRectangleShape(0, 0, 20, 2)
    projectile.fixture = love.physics.newFixture(projectile.body, projectile.shape, 5) -- A higher density gives it more mass.
    

    table.insert(listOfProjectiles, projectile)
end


function love.gamepadpressed(joystick, button)
    print("button: " .. button)
    if button == "a" then
        -- jump
        player.body:applyLinearImpulse(0,-200)
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