local pd <const> = playdate
local gfx <const> = pd.graphics

class('Hand').extends(gfx.sprite)

function Hand:init(x, y)
    local handImage = gfx.image.new("images/handImage")
    assert(handImage)
    self:setImage(handImage)
    self:moveTo(x, y)
    self:add()

    self.x = x
    self.y = y
    self.state = 0
end

local LOAD_DICE <const> = -1
local MID_THROW <const> = 0
local THROWING <const> = 1
local isDiceLoaded = false

local dice = {}

function determineState(crankDegrees)
    if crankDegrees < 30 or crankDegrees > 330 then
        return THROWING
    elseif crankDegrees > 150 and crankDegrees < 210 then
        return LOAD_DICE
    end

    return MID_THROW
end

function Hand:update()
    if not pd.isCrankDocked() then
        -- Zero is pointing straight up parallel to the device.
        -- Turning the crank clockwise
        --   (when looking at the right edge of an upright device)
        --   increases the angle, up to a maximum value 359.9999.
        -- The value then resets back to zero as the crank continues its rotation.
        local crankDegrees = pd.getCrankPosition()

        self:moveTo(self.x, 220 - (math.cos(math.rad(crankDegrees)) * 20))

        local newState = determineState(crankDegrees)

        if self.state ~= newState then
            print("New state: " .. self.state)
            self.state = newState

            if newState == LOAD_DICE and not isDiceLoaded then
                isDiceLoaded = true
                if dice[1] then
                    dice[1]:remove()
                end
                if dice[2] then
                    dice[2]:remove()
                end
            elseif newState == THROWING and isDiceLoaded then
                isDiceLoaded = false

                dice[1] = Dice(self.x - 20, self.y - 5, pd.geometry.vector2D.new(math.random(-4, -1), math.random(-8,-6)))
                dice[2] = Dice(self.x + 20, self.y + 5, pd.geometry.vector2D.new(math.random(1, 4), math.random(-8,-6)))
            end

        end
    end
end
