require("PonyControl")
require("FinerControl")
require("Collision")
require("LevelLoad")
local sti = require "sti"

local transx=0
local transy=0

function love.load()

	local fsmodes=love.window.getFullscreenModes()

	local maxw=800
	local h=600
	for _,m in ipairs(fsmodes) do
		if m.width>maxw then
			maxw=m.width
			h=m.height
		end
	end

	love.window.setMode(maxw,h,{fullscreen=true})

	windowWidth = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	level=newLevel("town")

	mainCharacter= newPony("sprites", level.world, 
		"w", love.keyboard.isDown,
		"s", love.keyboard.isDown,
		"a", love.keyboard.isDown,
		"d", love.keyboard.isDown,
		"lshift", love.keyboard.isDown,
		" ", love.keyboard.isDown,
		{"w","a","s","d"}, FC_double_key_only_one,
		"lshift",FC_double_key
	)

	level:addPlayer(mainCharacter,100,100)

end


function love.keypressed(key)
	FC_update_key_press(key,0.2)
end

local on_ground=true

function love.update(dt)
	FC_update_time(dt)
	mainCharacter:updateControl(dt)
	
	level:update(dt)
	
	mainCharacter:updateAnim(dt)

end

function love.draw()

	level:draw_beneath()

	local x,y=mainCharacter:getPosition()

	mainCharacter:draw(windowWidth/2-48,windowHeight/2-48)
	
	level:draw_above()
	

end

function love.resize(w,h)
	map:resize(w,h)
	windowWidth=w
	windowHeight=h
end
