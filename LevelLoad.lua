require("AI")

local level = {}
level.__index= level

local sti = require "sti"

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
	if a.controller~=nil then
		a.controller:beginCollide(b)
	end
	if b.controller~=nil then
		b.controller:beginCollide(a)
	end
end

function collideSolveCall(a,b,coll,normimp1,tanimp1,normimp2,tanimp2)
	if a.controller~=nil then
		a.controller:collideSolve(b,normimp1,tanimp1,normimp2,tanimp2)
	end
	if b.controller~=nil then
		b.controller:collideSolve(a,normimp1,tanimp1,normimp2,tanimp2)
	end
end

function collideEndCall(a,b,coll)
	if a.controller~=nil then
		a.controller:endCollide(b)
	end
	if b.controller~=nil then
		b.controller:endCollide(a)
	end
end


function newLevel(map)
	local l={}
	
	love.physics.setMeter(50)
	l.map=sti.new(map)

	l.music=love.audio.newSource("sound/" .. l.map.properties["music"])
	l.music:play()

	l.world=love.physics.newWorld(0,0)

	l.DoorLayer=l.map.layers["door 1"]
	l.InsideLayer=l.map.layers["inside 1"]
	l.walls=object_to_wall_layer(l.map.layers["wall 1"],l.world)
	l.floor=l.map.layers["floor 1"]
	l.spawns=l.map.layers["spawn 1"]

	print(l.spawns)

	l.min_layer=1
	l.on_layer=1
	l.max_layer=16

	l.check_nearest_area=check_nearest_object_in_layer
	l.check_in_areas=check_in_layer
	l.draw_areas= draw_object_layer

	l.map:resize(windowWidth,windowHeight)

	l.constructs={}
	for _,spawn in ipairs(l.spawns.objects) do
		local ai=newAI(spawn.properties["name"],
			spawn.properties["personality"],
			"sprites",
			l.world)
		ai.character:setPosition(spawn.x,spawn.y)
		table.insert(l.constructs,ai.character)
	end

	l.world:setCallbacks(collideBeginCall,collideEndCall,nil,collideSolveCall)

	return setmetatable(l,level)
end


function level:addPlayer(player,x,y)
	self.player=player
	player:setPosition(x,y)
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

	if self.player.falling and self.player.jumptime<=0 and self.check_in_areas(x,y,self.floor) then
		self.player:hitGround()
	elseif not self.player.falling and not self.check_in_areas(x,y,self.floor) then
		--self.world:fall()
	end

	for _, ai in ipairs(self.constructs) do
		ai:updateControl(dt)
		ai:updateAnim(dt)
	end

	self.map:update(dt)
	self.world:update(dt)
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
			self.map:drawTileLayer{"Tile Layer " .. i}
		end
		self.map:setDrawRange(-x+w/2,-y+h/2,w,h/2)
		local l=1
		for i=self.on_layer+1,self.on_layer+2,1 do
			self.map:drawTileLayer{"Tile Layer " .. i, byTile=true}
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
			self.map:setDrawRange(-x+w/2,-y-62+21*(l),w,h/2+86)
			self.map:drawTileLayer{"Tile Layer " .. i, byTile=true}
			l=l+1
		end
		self.map:setDrawRange(-x+w/2,-y+h/2,w,h)
		for i=self.on_layer+3,self.max_layer,1 do
			self.map:drawTileLayer{"Tile Layer " .. i}
		end
	love.graphics.pop()
end
