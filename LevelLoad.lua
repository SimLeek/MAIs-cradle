require("libs.AI")

local level = {}
level.__index= level

local sti = require "libs.sti"

local function object_to_wall_layer(layer, world)
	walls={}
	avgx=0
	countx=0
	avgy=0
	county=0
	for _, object in ipairs(layer.objects) do
		chainTable={}	
		for _, vertex in ipairs(object.polygon) do
			avgx=avgx+vertex.x
			countx=countx+1
			avgy=avgy+vertex.y
			county=county+1
			table.insert(chainTable,vertex.x)
			table.insert(chainTable,vertex.y)
		end
		avgx=avgx/countx
		avgy=avgy/county

		nextObj={}
		nextObj.body=love.physics.newBody(world, 0,0)
		print(object.id)
		nextObj.shape=love.physics.newChainShape(true,unpack(chainTable))

		nextObj.fixture=love.physics.newFixture(nextObj.body, nextObj.shape)

		table.insert(walls,nextObj)

	end

	return walls
end 

local function check_nearest_object_in_layer(x,y,layer)
	min=500
	minObj=nil
	for _,object in ipairs(layer.objects) do
		local d=math.sqrt((object.x-x)^2 +(object.y-y)^2)
		if d<min then
			min=d
			minObj=object
		end
	end
	return min,minObj
end

local function check_in_layer(x,y,layer)
	--for _,vertex in ipairs(object.polygon) do

	for _,object in ipairs(layer.objects) do

		 if PointWithinShape(object.polygon,x,y) then
			 return true
		 end
	end
	return false
end

local function draw_object_layer(layer)
	local oldx,oldy
	for _, object in ipairs(layer.objects) do
		for _,vertex in ipairs(object.polygon) do
		if oldx~=nil and oldy~=nil then
			love.graphics.line(oldx,oldy,vertex.x,vertex.y)
		end
		oldx=vertex.x
		oldy=vertex.y
		end
		oldx=nil
		oldy=nil
	end
end 


function collideBeginCall(a,b,coll)
	if a:getUserData()~=nil then
		a:getUserData():beginCollide(b)
	end
	if b:getUserData()~=nil then
		b:getUserData():beginCollide(a)
	end
end

function collideSolveCall(a,b,coll,normimp1,tanimp1,normimp2,tanimp2)
	if a:getUserData()~=nil then
		a:getUserData():collideSolve(b,normimp1,tanimp1,normimp2,tanimp2)
	end
	if b:getUserData()~=nil then
		b:getUserData():collideSolve(a,normimp1,tanimp1,normimp2,tanimp2)
	end
end

function collideEndCall(a,b,coll)
	if a:getUserData()~=nil then
		a:getUserData():endCollide(b)
	end
	if b:getUserData()~=nil then
		b:getUserData():endCollide(a)
	end
end


function newLevel(map)
	local l={}
	
	love.physics.setMeter(50)
	l.map=sti.new(map)

	--l.music=love.audio.newSource("sound/" .. l.map.properties["music"])
	--l.music:play()

	l.worlds={}

	l.DoorLayer=l.map.layers["door 1"]
	l.InsideLayer=l.map.layers["inside 1"]

	l.walls={}
	for i=1,16,1 do
		if l.map.layers["wall " .. i]~=nil then 
			table.insert(l.worlds,love.physics.newWorld(0,0))
			table.insert(l.walls,object_to_wall_layer(l.map.layers["wall " .. i],l.worlds[i]))
			l.worlds[i]:setCallbacks(collideBeginCall,collideEndCall,nil,collideSolveCall)
		end
	end

	l.floor=l.map.layers["floor 1"]
	l.spawns=l.map.layers["spawn 1"]

	print(l.spawns)

	l.min_layer=1
	l.on_layer=1
	l.last_layer=1
	l.z=l.on_layer/4
	l.zv=0
	l.za=-9.8
	l.max_layer=16

	l.currentWorld=l.worlds[1]

	l.check_nearest_area=check_nearest_object_in_layer
	l.check_in_areas=check_in_layer
	l.draw_areas= draw_object_layer

	l.map:resize(windowWidth,windowHeight)

	l.constructs={}
	for _,spawn in ipairs(l.spawns.objects) do
		local ai=newAI(spawn.properties["name"],
			spawn.properties["personality"],
			"sprites",
			l.worlds[1])
		ai.character:setPosition(spawn.x,spawn.y)
		table.insert(l.constructs,ai.character)
	end

	

	return setmetatable(l,level)
end

function level:addPlayer(player,x,y)
	self.player=player
	player:setPosition(x,y)
end

function level:onFloor(x,y)
	for i=self.last_layer,self.on_layer,-1 do
		if  self.map.layers["floor " .. i]~= nil then
			if self.check_in_areas(x,y,self.map.layers["floor " .. i]) then
				self.on_layer=i
				return true
			end
		end
	end
	return false
end

function level:hitCiel(x,y)
	for i=self.last_layer,self.on_layer,1 do
		if self.map.layers["ciel " .. i]~=nil then
			if self.check_in_areas(x,y,self.map.layers["floor " .. i]) then
				self.on_layer=i
				return true
			end
		end
	end
	return false
end

function level:switchLayer()
	self.on_layer=math.floor(self.player.z*4)
	print(self.last_layer,self.on_layer)
end

function level:switchWorld()	
	print(self.on_layer)
	if self.worlds[self.on_layer]~= nil then
		print(self.on_layer)
		local x,y=self.player.ponybody:getPosition()
		local vx,vy=self.player.ponybody:getLinearVelocity()
		self.player:removeFromWorld()
		self.player:addToWorld(self.worlds[self.on_layer])
		self.player.ponybody:setPosition(x,y)
		self.player.ponybody:setLinearVelocity(vx,vy)
		self.currentWorld=self.worlds[self.on_layer]

	end
end

function level:update(dt)

	local x,y=self.player:getPosition()
	if self.check_in_areas(x,y,self.InsideLayer) then
		self.max_layer=3
	else
		local d,door=self.check_nearest_area(x,y,self.DoorLayer)
		if door ~=nil then
			self.max_layer=3+math.floor(d/12)
			if self.max_layer>16 then
				self.max_layer=16
			end
		else
			self.max_layer=16
		end
	end

	if self.player.falling then
		self.player.zv=self.player.zv-9.8*dt
	else
		self.player.zv=0
	end

	self.player.z=self.player.z+self.player.zv*dt

	print(self.player.z)

	fallbool=((not self:onFloor(x,y) and not self:hitCiel(x,y)) or (self.player.z>self.on_layer/4 and self.player.z<16/4)) 

	if not self.player.falling and fallbool then
		print('f')
		self.player:fall()
	elseif self.player.falling and not fallbool then
		--if self.player.zv~=0 then
			print('h')
			self.player:hitGround()
			self.player.z=self.on_layer/4
			self.player.zv=0
		--end
	end


	if self.player.falling then
		vx,vy=self.player.ponybody:getLinearVelocity()
		self.player.ponybody:setLinearVelocity(vx,vy-self.player.zv*0.5)
		--print(vx,vy+self.player.zv*0.5)
	end

	for _, ai in ipairs(self.constructs) do
		ai:updateControl(dt)
		ai:updateAnim(dt)
	end
	
	if self.player.falling then
		self:switchLayer()

		if self.last_layer~=self.on_layer then
			self.last_layer=self.on_layer
			self:switchWorld()
		end
	end

	self.map:update(dt)
	self.currentWorld:update(dt)


end

function level:draw_beneath()
	local x,y=self.player:getPosition()
	local w=love.graphics.getWidth()
	local h=love.graphics.getHeight()

	--move to character 
	--(might want to move that to it's own function... actually no.)

	love.graphics.push()
		love.graphics.translate(-x+w/2,-y+h/2) 

		self.map:setDrawRange(-x+w/2,-y+h/2,w,h)
		for i=self.min_layer,self.on_layer,1 do
			if self.map.layers["Tile Layer " .. i]~=nil then
				self.map:drawTileLayer{"Tile Layer " .. i}
			end
		end
		self.map:setDrawRange(-x+w/2,-y+h/2,w,h/2)
		local l=1
		for i=self.on_layer+1,self.on_layer+2,1 do
			if self.map.layers["Tile Layer " .. i]~=nil then
				self.map:drawTileLayer{"Tile Layer " .. i, byTile=true}
			end
			l=l+1
		end

		for _,ai in ipairs(self.constructs) do

			local aiX, aiY=ai:getPosition()
			ai:draw(aiX-48,aiY-48)
		end
	love.graphics.pop()


end

function level:draw_above()
	local x,y=self.player:getPosition()
	local w=love.graphics.getWidth()
	local h=love.graphics.getHeight()

	love.graphics.push()
		love.graphics.translate(-x+w/2,-y+h/2) 

		l=0
		for i=self.on_layer+1,self.on_layer+2,1 do
			if self.map.layers["Tile Layer " .. i]~=nil then
				self.map:setDrawRange(-x+w/2,-y-62+21*(l),w,h/2+86)
				self.map:drawTileLayer{"Tile Layer " .. i, byTile=true}
			end
			l=l+1
		end
		self.map:setDrawRange(-x+w/2,-y+h/2,w,h)
		for i=self.on_layer+3,self.max_layer,1 do
			if self.map.layers["Tile Layer " .. i]~=nil then
				self.map:drawTileLayer{"Tile Layer " .. i}
			end
		end
	love.graphics.pop()
end
