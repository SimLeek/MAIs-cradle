require("libs.LoveFrames")

dialogueWindow = {}

function dialogueWindow.Create()
	dialogueWindow.frame=loveframes.Create("frame")
	dialogueWindow.frame:SetState(loveframes.GetState())
	dialogueWindow.frame:SetName("")
	dialogueWindow.frame:SetResizable(true)
	dialogueWindow.frame:ShowCloseButton(false)
	local ww=love.graphics.getWidth()
	local wh=love.graphics.getHeight()
	dialogueWindow.frame:SetWidth(ww)
	dialogueWindow.frame:SetY(wh-dialogueWindow.frame:GetHeight())
	dialogueWindow.frame:CenterX()
end	

function dialogueWindow.update(dt)
	if dialogueWindow.frame~=nil then
		for _,c in pairs(dialogueWindow.frame:GetChildren()) do
			if c.time~=nil then
				if c.time<0 then
					for _,cc in pairs(c:GetChildren()) do
						cc:Remove()
						cc=nil
						c:Remove()
						c=nil
					end
				else
					c.time=c.time-dt
				end
			end
		end
		if next(dialogueWindow.frame:GetChildren()) == nil then
			dialogueWindow.frame:Remove()
			dialogueWindow.frame=nil
		end
	end
end

function dialogueWindow.resize()
	if dialogueWindow.frame~=nil then
	local ww=love.graphics.getWidth()
	local wh=love.graphics.getHeight()
	dialogueWindow.frame:SetWidth(ww)
	dialogueWindow.frame:SetY(wh-dialogueWindow.frame:GetHeight())

	for _,c in pairs(dialogueWindow.frame:GetChildren()) do
		local reverse=c.reverse
		for _,c2 in pairs(c:GetChildren()) do
			if reverse then
			end
		end
	end
	end
end

function dialogueWindow.addDialogue(image,words,reverse,time)

	

	if dialogueWindow.frame==nil then
		dialogueWindow.Create()
	end

	local panel= loveframes.Create("panel",dialogueWindow.frame)
	--frame:SetDockable(true)

	if time~=nil then
		panel.time=time
	end

	panel.reverse=reverse
	panel:SetPos(5,30)
	panel:SetWidth(dialogueWindow.frame:GetWidth()-10)
	panel:SetHeight(100)
	local emote=loveframes.Create("image")
	emote:SetImage(image)
	local text=loveframes.Create("text")
	text:SetText(words)

	if reverse then	
		emote:SetParent(panel)
		emote:SetX(5)

		text:SetParent(panel)
		text:SetPos(emote:GetWidth()+5,0)
		text:SetMaxWidth(panel:GetWidth()-emote:GetWidth()-5)
		
	else
		text:SetParent(panel)
		text:SetMaxWidth(panel:GetWidth()-emote:GetWidth()-5)

		emote:SetParent(panel)
		emote:SetX(panel:GetWidth()-emote:GetWidth()-5)
	end
	emote:SetY(20)
end

function dialogueWindow.DeleteDialogue()
	if dialogueWindow==nil then
		return false
	end
	local DialoguePanels=dialogueWindow.frame:GetChildren()
	if DialoguePanels[1]==nil then
		dialogueWindow.frame:Remove()
	end
	DialoguePanels[1]:Remove()
	if DialoguePanels[2]==nil then
		dialogueWindow.frame:Remove()
	end
end


		

