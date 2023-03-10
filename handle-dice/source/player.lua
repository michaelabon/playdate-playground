local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y)
    local playerImage = gfx.image.new("images/playerImage")
    assert(playerImage)
    self:setImage(playerImage)
    self:moveTo(x, y)
    self:setCollideRect(0, 4, 32, 24)
    self:add()

    self.speed = 4
end

-- Runs every time the playdate refreshes
function Player:update()
    if pd.buttonIsPressed(pd.kButtonUp) then
        if (self.y > 8) then
            self:moveBy(0, -self.speed * keeperSpeedMultiplier)
        end
    end
    if playdate.buttonIsPressed( playdate.kButtonRight ) then
        if (self.x < 384) then
            self:moveBy( self.speed * keeperSpeedMultiplier, 0 )
        end
    end
    if playdate.buttonIsPressed( playdate.kButtonDown ) then
        if (self.y < 210) then
            self:moveBy( 0, self.speed * keeperSpeedMultiplier )
        end
    end
    if playdate.buttonIsPressed( playdate.kButtonLeft ) then
        if (self.x > 16) then
            self:moveBy( -self.speed * keeperSpeedMultiplier, 0 )
        end
    end
end

