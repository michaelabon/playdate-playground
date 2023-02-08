import "ball"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function startBallSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createBallTimer()
    spawnBall()
end

function createBallTimer()
    -- generates a random period between spawning the next ball
    local spawnTime = math.random(3000, 6000)

    -- waits for the random amount of time,
    -- then calls the callback function
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function()
        createBallTimer()
        spawnBall()
    end)
end

-- Spawns a ball at a random location
function spawnBall()
    local spawnPosition = math.random(0, 240)
    local spawnDirection = math.random(-3, 3)
    local spawnSpeed = math.random(2, 5)

    -- Spawns the ball at a random position and changes speed as the player progresses
    Ball(spawnPosition, -20, spawnSpeed, spawnDirection)
 end

 -- Stops the ball spawner
function stopBallSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
 end

 -- Clears all the Balls from the display
 function clearBalls()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Ball) then
            sprite:remove()
        end
    end
 end
