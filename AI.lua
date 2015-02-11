require("PonyControl")
require("DialogueWindow")
local AI = {}
AI.__index = AI

local function doNothing()
	return true
end

function AI:snore()
	if math.random(10)==1 then
		local dialogue=self.speach.sleepHit[math.random(table.getn(self.speach.sleepHit))]

		dialogueWindow.addDialogue(dialogue.face,dialogue.text,false,dialogue.time)
	end
end

function newAI(name, personality,sprites,world)
	local ai={}
	ai.character = newPony(sprites,
		
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

	ai.character:addToWorld(world)

	ai.speach=dofile (personality .. "/dialogue.lua")
	ret=setmetatable(ai,AI)
	ret.character:setCollisionCallbacks(nil,doNothing,ai,ret.snore,nil,doNothing)

	return setmetatable(ai,AI)
end
