import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/crank"

import "globals"
import "sceneController"
import "playGameButton"
import "player"
import "ballSpawner"
import "goal"
import "hand"
import "dice"
import "scoreDisplay"

local gfx <const> = playdate.graphics

setStartingScene()



math.randomseed(playdate.getSecondsSinceEpoch())

function playdate.update()
    gfx.sprite.update()
    playdate.timer.updateTimers()
end

function resetGame()
    -- loadHighscore()
    -- resetScore()
    -- clearBalls()
    -- stopBallSpawner()
    -- startBallSpawner()
end