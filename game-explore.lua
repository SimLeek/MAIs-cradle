require("PonyControl")
require("libs.FinerControl")
require("libs.Collision")
require("LevelLoad")
local sti = require "libs.sti"

local transx=0
local transy=0

local ExploreGame = {}
ExploreGame.__index = ExploreGame

function newExploreGame(level, character, x, y)
	local eg={}
	eg.ww=love.graphics.getWidth()
	eg.wh=love.graphics.getHeight()

	eg.level=newLevel(level)

	--[[--]]

	eg.mainCharacter=character

	eg.mainCharacter:addToWorld(eg.level.worlds[1])

	eg.level:addPlayer(eg.mainCharacter,x,y)

	return setmetatable(eg,ExploreGame)
end

function ExploreGame:keypressed(key)
	FC_update_key_press(key,0.2)
end

function ExploreGame:update(dt)
	FC_update_time(dt)
	self.mainCharacter:updateControl(dt)
	
	self.level:update(dt)
	
	self.mainCharacter:updateAnim(dt)
end

function ExploreGame:draw()

	self.level:draw_beneath()

	local x,y=self.mainCharacter:getPosition()

	self.mainCharacter:draw(self.ww/2-48,self.wh/2-48)
	
	self.level:draw_above()
end

function ExploreGame:resize(w,h)
	self.level.map:resize(w,h)
	self.ww=w
	self.wh=h
end
