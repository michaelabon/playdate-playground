local pd <const> = playdate
local gfx <const> = pd.graphics


class('PlayGameButton').extends(gfx.sprite)

function PlayGameButton:init(x, y)
    local playGameButtonImage = gfx.image.new("images/playGameMessage")
    assert(playGameButtonImage)
    self:setImage(playGameButtonImage)
    self:moveTo(x, y)
    self:add()

    pd.ui.crankIndicator:start()
end

function pd.AButtonUp()
    if gameState == 'start' or gameState == 'game over' then
        setGameScene()
        resetGame()
    end
end

function PlayGameButton:update()
    if pd.isCrankDocked() then
        pd.ui.crankIndicator:update()
    end
end