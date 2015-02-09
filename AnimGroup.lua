require("AnAL")

local animGroup = {}
animGroup.__index = animGroup

function newAnimGroup(w,h,sp,sc)
	local c = {}
	c.anims = {}
	c.switchTables = {}
	c.current_anim = nil
	c.w=w
	c.h=h
	c.sp=sp
	c.sc=sc

	return setmetatable(c, animGroup)
end

function animGroup:setAnims(t)
	for k,v in pairs(t) do
		local img = love.graphics.newImage(v)
		anim = newAnimation(img,self.w,self.h,self.sp,self.sc)
		self.anims[k]=anim
		self.current_anim=k
	end
end

function animGroup:setModes(mode,t)
	for _,v in ipairs(t) do
		self.anims[v]:setMode(mode)
	end
end

function animGroup:setCurrent(k)
	self.current_anim=k
end

function animGroup:setSwitches(t)
	for k,v in pairs(t) do
		self.switchTables[k]=v
	end
end

function animGroup:switchAnim(k)

	local t= self.switchTables[k]

	if t.all~=nil and t.except~=nil then
		excepted=false
		for i,j in pairs(t.except) do
			if self.current_anim==j then
				excepted=true
				break
			end
		end
		if not excepted then
			self.current_anim=t.all
		end
		return
	end
	for k,v in pairs(t) do	
		if((k)==self.current_anim) then
			self.current_anim=v
			break
		end
	end
end

function animGroup:update(dt)	
	if self.current_anim~= nil and self.anims[self.current_anim]~=nil then
		self.anims[self.current_anim]:update(dt)
	end
end

function animGroup:draw(x,y)
	if self.current_anim~= nil and self.anims[self.current_anim]~=nil then
		self.anims[self.current_anim]:draw(x,y)
	end
end

