local pd <const> = playdate
local gfx <const> = pd.graphics

class('Dice').extends(gfx.sprite)

local isSettled = false

-- x, y are integers
-- initialSpeed is Vector2D
function Dice:init(x, y, initialSpeed)
    self.diceTable = gfx.imagetable.new("images/dice")
	assert(self.diceTable)

    self:setRandomValue()

    self:moveTo(x, y)
    self:add()

    self.x = x
    self.y = y
    self.initialSpeed = initialSpeed
    self.speed = initialSpeed
    self:setCollisionsEnabled(false)
    self.collisionResponse =  "bounce"

    self.state = 4
    self.stateCallback = function()
        self:setCollisionsEnabled(true)
        self:setRandomValue()
        print("state callback: " .. self.state)
        self.speed:scale(0.7)
        local bounceAngleDeviation = pd.geometry.affineTransform.new()
        bounceAngleDeviation:rotate(math.random(-30, 30))
        self.speed = bounceAngleDeviation * self.speed
        self:setRotation(math.random() * 360)
    end

    self.timer = pd.timer.new(
        math.random(1500, 2500),
        math.random() * 0.3 + 1.15, -- [1.15 to 1.5]
        1,
        self:outBounce()
    )

    self.timer.timerEndedCallback = function()
        self.state = 0
    end

end

local rotationStateMultiplier = {
    1.6,
    -4.6,
    2.2,
    3.8
}

function Dice:update()
    self:setScale(self.timer.value)
    self:setCollideRect( 0, 0, self:getSize() )
    if self.state > 0 then
        local rotation = self:getRotation()

        local rotationMultiplier = rotationStateMultiplier[self.state] or 1
        rotation += (rotationMultiplier * self.speed.dx)

        self:setRotation(rotation)
        self:moveWithCollisions(self.x + self.speed.dx, self.y + self.speed.dy)
    elseif self.speed:magnitude() > 1 then
        self.speed:scale(0.95)
    else
        self:stop()
    end



    if self.y <= 0 then
        self.y *= -1
        self.speed.dy *= -1
        self.y += 1
        self.speed.dy += 1
    end
    if self.y >= 240 then
        self.y *= -1
        self.speed.dy *= -1
        self.y -= 1
        self.speed.dy += 1
    end
    if self.x <= 0 then
        self.x *= -1
        self.speed.dx *= -1
        self.x += 1
        self.speed.dx += 1
    end
    if self.x >= 400 then
        self.x *= -1
        self.speed.dx *= -1
        self.x -= 1
        self.speed.dx += 1
    end
end

function Dice:stop()
    self.speed *= 0
    self:setScale(1)
end

function Dice:setRandomValue()
    self.value = math.random(1, 6)
    self:setImage(self.diceTable:getImage(self.value))
end


function Dice:outBounce()
    return function(t, b, c, d)
    t = t / d
    if t < 1 / 2.75 then
        if self.state > 4 then
            self.state = 4
            self:stateCallback()
        end
        return c * (7.5625 * t * t) + b
    elseif t < 2 / 2.75 then
        if self.state > 3 then
            self.state = 3
            self:stateCallback()
        end
        t = t - (1.5 / 2.75)
        return c * (7.5625 * t * t + 0.75) + b
    elseif t < 2.5 / 2.75 then
        if self.state > 2 then
            self.state = 2
            self:stateCallback()
        end
        t = t - (2.25 / 2.75)
        return c * (7.5625 * t * t + 0.9375) + b
    else
        if self.state > 1 then
            self.state = 1
            self:stateCallback()
        end
        t = t - (2.625 / 2.75)
        return c * (7.5625 * t * t + 0.984375) + b
    end
end
end