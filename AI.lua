require("PonyControl")

local AI = {}
AI.__index = AI

local function doNothing()
	return false
end

function newAI(name, personality,sprites,world)
	local ai={}
	ai.character = newPony(sprites,world,
		
		nil, doNothing,
		nil, doNothing,
		nil, doNothing,
		nil, doNothing,
		nil, doNothing,
		nil, doNothing,
		nil, doNothing,
		nil, doNothing
	)

	ai.name=name
	ai.personality=personality

	ai.speach=dofile (personality .. "/dialogue.lua")

	return setmetatable(ai,AI)
end
