
import 'CoreLibs/3d.lua'

gfx = playdate.graphics

p = (math.sqrt(5) - 1 / 2)

--          x2
--           _____________  x3
--  x1  <=__^_______,.-'^/
--     /    :      /x4  /
--    /    :      /    /
--   /    :      /    /
--  /    _y2 _  /_   /
-- /___________/,.-'^   y3
-- y1          y4
--




local x1 = vector3d.new(-1, -1, 1)
local x2 = vector3d.new(-1, 1, 1)
local x3 = vector3d.new(1, 1, 1)
local x4 = vector3d.new(1, -1, 1)

local y1 = vector3d.new(-1, -1, -1)
local y2 = vector3d.new(-1, 1, -1)
local y3 = vector3d.new(1, 1, -1)
local y4 = vector3d.new(1, -1, -1)

s = shape3d.new()

s:addFace(x1, x2, x4)
s:addFace(x2, x3, x4)

s:addFace(x1, y4, y1)
s:addFace(x1, x4, y4)

s:addFace(x4, x3, y3)
s:addFace(x4, y3, y4)

s:addFace(y1, y4, y2)
s:addFace(y2, y4, y3)

s:addFace(x1, y1, y2)
s:addFace(x2, x1, y2)

s:addFace(x3, x2, y2)
s:addFace(y3, x3, y2)

s:scaleBy(0.6)

scene = scene3d.new()
scene:addShape(s)

light = vector3d.new(-2, 3, 5)

scene:setLight(light / light:length())

angle = 0


local wireFrameOn = false
local shadingOn = true

function playdate.update()
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 400, 240)

    if shadingOn then
        scene:draw()
    end

    if wireFrameOn then
        gfx.setColor(gfx.kColorWhite)
        scene:drawWireframe()
    end

    angle = angle + 0.01
    s:rotateAroundX(math.cos(angle) / 20)
    s:rotateAroundY(math.sin(angle) / 20)
end



function playdate.AButtonDown()
	wireframeOn = not wireframeOn
end

function playdate.BButtonDown()
	shadingOn = not shadingOn
end
