require("libs.AnimGroup")

local ponyControl = {}
ponyControl.__index = ponyControl


local diag=0.70710678118
local tileRatio=84/100

function newPony(spriteFolder,
		 upVar ,upCall, 
		 downVar, downCall, 
		 leftVar, leftCall, 
		 rightVar, rightCall, 
		 creepVar, creepCall,
		 jumpVar, jumpCall,
		 runVar, runCall, 
		 sleepVar, sleepCall)

	local p = {}

	p.character_type="pony"

	p.upCall=upCall
	p.upVar=upVar
	p.downCall=downCall
	p.downVar=downVar
	p.leftCall=leftCall
	p.leftVar=leftVar
	p.rightCall=rightCall
	p.rightVar=rightVar
	p.creepCall=creepCall
	p.creepVar=creepVar
	p.jumpCall=jumpCall
	p.jumpVar=jumpVar
	p.runCall=runCall
	p.runVar=runVar
	p.sleepCall=sleepCall
	p.sleepVar=sleepVar	

	p.ponyAnim = newAnimGroup(96,96,0.1,0)

	p.ponyAnim:setAnims{
	s_r = spriteFolder .. "/pinkie-stand-r.png",
	s_l=spriteFolder .. "/pinkie-stand-l.png",
	s_f=spriteFolder .. "/pinkie-stand-f.png",
	s_b=spriteFolder .. "/pinkie-stand-b.png",
	s_fr=spriteFolder .. "/pinkie-stand-fr.png",
	s_fl=spriteFolder .. "/pinkie-stand-fl.png",
	s_br=spriteFolder .. "/pinkie-stand-br.png",
	s_bl=spriteFolder .. "/pinkie-stand-bl.png",
	n_r=spriteFolder .. "/pinkie-walk-normal-r.png",
	n_l=spriteFolder .. "/pinkie-walk-normal-l.png",
	n_f=spriteFolder .. "/pinkie-walk-normal-f.png",
	n_b=spriteFolder .. "/pinkie-walk-normal-b.png",
	n_fr=spriteFolder .. "/pinkie-walk-normal-fr.png",
	n_fl=spriteFolder .. "/pinkie-walk-normal-fl.png",
	n_br=spriteFolder .. "/pinkie-walk-normal-br.png",
	n_bl=spriteFolder .. "/pinkie-walk-normal-bl.png",
	sl_r=spriteFolder .. "/pinkie-walk-slow-r.png",
	sl_l=spriteFolder .. "/pinkie-walk-slow-l.png",
	sl_f=spriteFolder .. "/pinkie-walk-slow-f.png",
	sl_b=spriteFolder .. "/pinkie-walk-slow-b.png",
	sl_fr=spriteFolder .. "/pinkie-walk-slow-fr.png",
	sl_fl=spriteFolder .. "/pinkie-walk-slow-fl.png",
	sl_br=spriteFolder .. "/pinkie-walk-slow-br.png",
	sl_bl=spriteFolder .. "/pinkie-walk-slow-bl.png",
	si_r=spriteFolder .. "/pinkie-sit-r.png",
	si_l=spriteFolder .. "/pinkie-sit-l.png",
	si_f=spriteFolder .. "/pinkie-sit-f.png",
	si_b=spriteFolder .. "/pinkie-sit-b.png",
	si_fr=spriteFolder .. "/pinkie-sit-fr.png",
	si_fl=spriteFolder .. "/pinkie-sit-fl.png",
	si_br=spriteFolder .. "/pinkie-sit-br.png",
	si_bl=spriteFolder .. "/pinkie-sit-bl.png",
	ru_r=spriteFolder .. "/pinkie-run-r.png",
	ru_l=spriteFolder .. "/pinkie-run-l.png",
	ru_f=spriteFolder .. "/pinkie-run-f.png",
	ru_b=spriteFolder .. "/pinkie-run-b.png",
	ru_fr=spriteFolder .. "/pinkie-run-fr.png",
	ru_fl=spriteFolder .. "/pinkie-run-fl.png",
	ru_br=spriteFolder .. "/pinkie-run-br.png",
	ru_bl=spriteFolder .. "/pinkie-run-bl.png",
	sl=spriteFolder .. "/pinkie-sleep.png",

	lp_st_r=spriteFolder .. "/pinkie-leap-start-r.png",
	lp_st_l=spriteFolder .. "/pinkie-leap-start-l.png",
	lp_st_f=spriteFolder .. "/pinkie-leap-start-f.png",
	lp_st_b=spriteFolder .. "/pinkie-leap-start-b.png",
	lp_st_fr=spriteFolder .. "/pinkie-leap-start-fr.png",
	lp_st_fl=spriteFolder .. "/pinkie-leap-start-fl.png",
	lp_st_br=spriteFolder .. "/pinkie-leap-start-br.png",
	lp_st_bl=spriteFolder .. "/pinkie-leap-start-bl.png",

	lp_ris_r=spriteFolder .. "/pinkie-leap-rise-r.png",
	lp_ris_l=spriteFolder .. "/pinkie-leap-rise-l.png",
	lp_ris_f=spriteFolder .. "/pinkie-leap-rise-f.png",
	lp_ris_b=spriteFolder .. "/pinkie-leap-rise-b.png",
	lp_ris_fr=spriteFolder .. "/pinkie-leap-rise-fr.png",
	lp_ris_fl=spriteFolder .. "/pinkie-leap-rise-fl.png",
	lp_ris_br=spriteFolder .. "/pinkie-leap-rise-br.png",
	lp_ris_bl=spriteFolder .. "/pinkie-leap-rise-bl.png",

	lp_fal_r=spriteFolder .. "/pinkie-leap-fall-r.png",
	lp_fal_l=spriteFolder .. "/pinkie-leap-fall-l.png",
	lp_fal_f=spriteFolder .. "/pinkie-leap-fall-f.png",
	lp_fal_b=spriteFolder .. "/pinkie-leap-fall-b.png",
	lp_fal_fr=spriteFolder .. "/pinkie-leap-fall-fr.png",
	lp_fal_fl=spriteFolder .. "/pinkie-leap-fall-fl.png",
	lp_fal_br=spriteFolder .. "/pinkie-leap-fall-br.png",
	lp_fal_bl=spriteFolder .. "/pinkie-leap-fall-bl.png",

	lp_lnd_r=spriteFolder .. "/pinkie-leap-land-r.png",
	lp_lnd_l=spriteFolder .. "/pinkie-leap-land-l.png",
	lp_lnd_f=spriteFolder .. "/pinkie-leap-land-f.png",
	lp_lnd_b=spriteFolder .. "/pinkie-leap-land-b.png",
	lp_lnd_fr=spriteFolder .. "/pinkie-leap-land-fr.png",
	lp_lnd_fl=spriteFolder .. "/pinkie-leap-land-fl.png",
	lp_lnd_br=spriteFolder .. "/pinkie-leap-land-br.png",
	lp_lnd_bl=spriteFolder .. "/pinkie-leap-land-bl.png",

	hop_st_r=spriteFolder .. "/pinkie-hop-start-r.png",
	hop_st_l=spriteFolder .. "/pinkie-hop-start-l.png",
	hop_st_f=spriteFolder .. "/pinkie-hop-start-f.png",
	hop_st_b=spriteFolder .. "/pinkie-hop-start-b.png",
	hop_st_fr=spriteFolder .. "/pinkie-hop-start-fr.png",
	hop_st_fl=spriteFolder .. "/pinkie-hop-start-fl.png",
	hop_st_br=spriteFolder .. "/pinkie-hop-start-br.png",
	hop_st_bl=spriteFolder .. "/pinkie-hop-start-bl.png",

	hop_ris_r=spriteFolder .. "/pinkie-hop-rise-r.png",
	hop_ris_l=spriteFolder .. "/pinkie-hop-rise-l.png",
	hop_ris_f=spriteFolder .. "/pinkie-hop-rise-f.png",
	hop_ris_b=spriteFolder .. "/pinkie-hop-rise-b.png",
	hop_ris_fr=spriteFolder .. "/pinkie-hop-rise-fr.png",
	hop_ris_fl=spriteFolder .. "/pinkie-hop-rise-fl.png",
	hop_ris_br=spriteFolder .. "/pinkie-hop-rise-br.png",
	hop_ris_bl=spriteFolder .. "/pinkie-hop-rise-bl.png",

	hop_fal_r=spriteFolder .. "/pinkie-hop-fall-r.png",
	hop_fal_l=spriteFolder .. "/pinkie-hop-fall-l.png",
	hop_fal_f=spriteFolder .. "/pinkie-hop-fall-f.png",
	hop_fal_b=spriteFolder .. "/pinkie-hop-fall-b.png",
	hop_fal_fr=spriteFolder .. "/pinkie-hop-fall-fr.png",
	hop_fal_fl=spriteFolder .. "/pinkie-hop-fall-fl.png",
	hop_fal_br=spriteFolder .. "/pinkie-hop-fall-br.png",
	hop_fal_bl=spriteFolder .. "/pinkie-hop-fall-bl.png",

	hop_lnd_r=spriteFolder .. "/pinkie-hop-land-r.png",
	hop_lnd_l=spriteFolder .. "/pinkie-hop-land-l.png",
	hop_lnd_f=spriteFolder .. "/pinkie-hop-land-f.png",
	hop_lnd_b=spriteFolder .. "/pinkie-hop-land-b.png",
	hop_lnd_fr=spriteFolder .. "/pinkie-hop-land-fr.png",
	hop_lnd_fl=spriteFolder .. "/pinkie-hop-land-fl.png",
	hop_lnd_br=spriteFolder .. "/pinkie-hop-land-br.png",
	hop_lnd_bl=spriteFolder .. "/pinkie-hop-land-bl.png"
	}

	p.ponyAnim:setSwitches{
	s=   {n_r="s_r",n_l="s_l",n_f="s_f",n_b="s_b",
	      n_fr="s_fr",n_fl="s_fl",n_br="s_br", n_bl="s_bl",
      	      si_r="s_r",si_l="s_l",si_f="s_f",si_b="s_b",
	      si_fr="s_fr",si_fl="s_fl",si_br="s_br", si_bl="s_bl",
     	      sl_r="s_r",sl_l="s_l",sl_f="s_f",sl_b="s_b",
	      sl_fr="s_fr",sl_fl="s_fl",sl_br="s_br", sl_bl="s_bl",
	      ru_r="s_r",ru_l="s_l",ru_f="s_f",ru_b="s_b",
	      ru_fr="s_fr",ru_fl="s_fl",ru_br="s_br", ru_bl="s_bl",
	      hop_lnd_r="s_r",hop_lnd_l="s_l",hop_lnd_f="s_f",hop_lnd_b="s_b",
	      hop_lnd_fr="s_fr",hop_lnd_fl="s_fl",hop_lnd_br="s_br", hop_lnd_bl="s_bl",
      	      lp_lnd_r="s_r",lp_lnd_l="s_l",lp_lnd_f="s_f",lp_lnd_b="s_b",
	      lp_lnd_fr="s_fr",lp_lnd_fl="s_fl",lp_lnd_br="s_br", lp_lnd_bl="s_bl"

      },
	si={n_r="si_r",n_l="si_l",n_f="si_f",n_b="si_b",
	      n_fr="si_fr",n_fl="si_fl",n_br="si_br", n_bl="si_bl",
      	      s_r="si_r",s_l="si_l",s_f="si_f",s_b="si_b",
	      s_fr="si_fr",s_fl="si_fl",s_br="si_br", s_bl="si_bl",
      	      sl_r="si_r",sl_l="si_l",sl_f="si_f",sl_b="si_b",
	      sl_fr="si_fr",sl_fl="si_fl",sl_br="si_br", sl_bl="si_bl",
	      ru_r="si_r",ru_l="si_l",ru_f="si_f",ru_b="si_b",
	      ru_fr="si_fr",ru_fl="si_fl",ru_br="si_br", ru_bl="si_bl"
		},
	sl={all="sl", except={}},
	n_r= {all="n_r",except={}},
	n_l= {all="n_l",except={}},
	n_f= {all="n_f",except={}},
	n_b= {all="n_b",except={}},
	n_fr= {all="n_fr",except={}},
	n_fl= {all="n_fl",except={}},
	n_br= {all="n_br",except={}},
	n_bl= {all="n_bl",except={}},
	ru_r= {all="ru_r",except={}},
	ru_l= {all="ru_l",except={}},
	ru_f= {all="ru_f",except={}},
	ru_b= {all="ru_b",except={}},
	ru_fr= {all="ru_fr",except={}},
	ru_fl= {all="ru_fl",except={}},
	ru_br= {all="ru_br",except={}},
	ru_bl= {all="ru_bl",except={}},
	sl_r= {all="sl_r",except={}},
	sl_l= {all="sl_l",except={}},
	sl_f= {all="sl_f",except={}},
	sl_b= {all="sl_b",except={}},
	sl_fr= {all="sl_fr",except={}},
	sl_fl= {all="sl_fl",except={}},
	sl_br= {all="sl_br",except={}},
	sl_bl= {all="sl_bl",except={}},
	lp_st= {ru_r="lp_st_r",ru_l="lp_st_l",
	        ru_f="lp_st_f",ru_b="lp_st_b",
		ru_fr="lp_st_fr",ru_fl="lp_st_fl",
		ru_br="lp_st_br",ru_bl="lp_st_bl"},
	lp_ris= {lp_st_r="lp_ris_r",lp_st_l="lp_ris_l",
	         lp_st_f="lp_ris_f",lp_st_b="lp_ris_b",
		 lp_st_fr="lp_ris_fr",lp_st_fl="lp_ris_fl",
		 lp_st_br="lp_ris_br",lp_st_bl="lp_ris_bl"},
	lp_fal= {lp_ris_r="lp_fal_r",lp_ris_l="lp_fal_l",
	         lp_ris_f="lp_fal_f",lp_ris_b="lp_fal_b",
		 lp_ris_fr="lp_fal_fr",lp_ris_fl="lp_fal_fl",
		 lp_ris_br="lp_fal_br",lp_ris_bl="lp_fal_bl"},
	lp_lnd= {lp_fal_r="lp_lnd_r",lp_fal_l="lp_lnd_l",
	         lp_fal_f="lp_lnd_f",lp_fal_b="lp_lnd_b",
		 lp_fal_fr="lp_lnd_fr",lp_fal_fl="lp_lnd_fl",
		 lp_fal_br="lp_lnd_br",lp_fal_bl="lp_lnd_bl"},

	hop_st= {n_r="hop_st_r",n_l="hop_st_l",
	         n_f="hop_st_f",n_b="hop_st_b",
		 n_fr="hop_st_fr",n_fl="hop_st_fl",
		 n_br="hop_st_br",n_bl="hop_st_bl",
	 	 si_r="hop_st_r",si_l="hop_st_l",
	         si_f="hop_st_f",si_b="hop_st_b",
		 si_fr="hop_st_fr",si_fl="hop_st_fl",
		 si_br="hop_st_br",si_bl="hop_st_bl",
	 	 s_r="hop_st_r",s_l="hop_st_l",
	         s_f="hop_st_f",s_b="hop_st_b",
		 s_fr="hop_st_fr",s_fl="hop_st_fl",
		 s_br="hop_st_br",s_bl="hop_st_bl",
		 sl_r="hop_st_r",sl_l="hop_st_l",
	         sl_f="hop_st_f",sl_b="hop_st_b",
		 sl_fr="hop_st_fr",sl_fl="hop_st_fl",
		 sl_br="hop_st_br",sl_bl="hop_st_bl",
		 sl="hop_st_r"},

	hop_ris= {hop_st_r="hop_ris_r",hop_st_l="hop_ris_l",
	          hop_st_f="hop_ris_f",hop_st_b="hop_ris_b",
		  hop_st_fr="hop_ris_fr",hop_st_fl="hop_ris_fl",
		  hop_st_br="hop_ris_br",hop_st_bl="hop_ris_bl"},

	hop_fal= {hop_ris_r="hop_fal_r",hop_ris_l="hop_fal_l",
	          hop_ris_f="hop_fal_f",hop_ris_b="hop_fal_b",
		  hop_ris_fr="hop_fal_fr",hop_ris_fl="hop_fal_fl",
		  hop_ris_br="hop_fal_br",hop_ris_bl="hop_fal_bl",
	 	  n_r="hop_fal_r",n_l="hop_fal_l",
	          n_f="hop_fal_f",n_b="hop_fal_b",
		  n_fr="hop_fal_fr",n_fl="hop_fal_fl",
		  n_br="hop_fal_br",n_bl="hop_fal_bl",
	 	  si_r="hop_fal_r",si_l="hop_fal_l",
	          si_f="hop_fal_f",si_b="hop_fal_b",
		  si_fr="hop_fal_fr",si_fl="hop_fal_fl",
		  si_br="hop_fal_br",si_bl="hop_fal_bl",
	 	  s_r="hop_fal_r",s_l="hop_fal_l",
	          s_f="hop_fal_f",s_b="hop_fal_b",
		  s_fr="hop_fal_fr",s_fl="hop_fal_fl",
		  s_br="hop_fal_br",s_bl="hop_fal_bl",
	          sl_r="hop_fal_r",sl_l="hop_fal_l",
	          sl_f="hop_fal_f",sl_b="hop_fal_b",
		  sl_fr="hop_fal_fr",sl_fl="hop_fal_fl",
		  sl_br="hop_fal_br",sl_bl="hop_fal_bl",
		  sl="hop_fal_r"},

	hop_lnd= {hop_fal_r="hop_lnd_r",hop_fal_l="hop_lnd_l",
	          hop_fal_f="hop_lnd_f",hop_fal_b="hop_lnd_b",
		  hop_fal_fr="hop_lnd_fr",hop_fal_fl="hop_lnd_fl",
		  hop_fal_br="hop_lnd_br",hop_fal_bl="hop_lnd_bl"}

	}

	p.ponyAnim:setModes("once",
		{
		"lp_st_r","lp_st_l","lp_st_f","lp_st_b",
		"lp_st_fr","lp_st_fl","lp_st_br","lp_st_bl",
		"lp_ris_r","lp_ris_l","lp_ris_f","lp_ris_b",
		"lp_ris_fr","lp_ris_fl","lp_ris_br","lp_ris_bl",
		"lp_fal_r","lp_fal_l","lp_fal_f","lp_fal_b",
		"lp_fal_fr","lp_fal_fl","lp_fal_br","lp_fal_bl",
		"lp_lnd_r","lp_lnd_l","lp_lnd_f","lp_lnd_b",
		"lp_lnd_fr","lp_lnd_fl","lp_lnd_br","lp_lnd_bl",
		"hop_st_r","hop_st_l","hop_st_f","hop_st_b",
		"hop_st_fr","hop_st_fl","hop_st_br","hop_st_bl",
		"hop_ris_r","hop_ris_l","hop_ris_f","hop_ris_b",
		"hop_ris_fr","hop_ris_fl","hop_ris_br","hop_ris_bl",
		"hop_fal_r","hop_fal_l","hop_fal_f","hop_fal_b",
		"hop_fal_fr","hop_fal_fl","hop_fal_br","hop_fal_bl",
		"hop_lnd_r","hop_lnd_l","hop_lnd_f","hop_lnd_b",
		"hop_lnd_fr","hop_lnd_fl","hop_lnd_br","hop_lnd_bl",
		}
	)

	p.ponyAnim:setCurrent("s_r")

	p.running=false
	p.sleeping=false
	p.falling=false
	p.leaping=false
	p.jumptime=0

	p.zv=0
	p.z=0.25


	p.speed=400

	p.collidingWith={}

	return setmetatable(p,ponyControl)

end

function ponyControl:addToWorld(world)
	self.ponybody = love.physics.newBody(world,0,0,"dynamic")
	self.ponybox = love.physics.newRectangleShape(24,12)
	self.ponyFixture = love.physics.newFixture(self.ponybody,self.ponybox,1)
	--p.ponyFixture:setRestitution(0.1)
	self.ponyFixture:setUserData(self)
	self.ponybody:setBullet(True)
end

function ponyControl:removeFromWorld()
	print(self.ponybody)
	self.ponybody=nil--:destroy()
	self.ponybox=nil--:destroy()
	self.ponyFixture=nil--:destroy()
end

function ponyControl:updateControl(dt)
	if self.falling or self.jumpstatus=="falling" then
		--print(self.jumptime,self.jumpstatus)
		self.jumptime=self.jumptime-dt
		if self.jumptime<0 then
			if self.jumpstatus=="start" then
				if self.leaping==true then
					self.ponyAnim:switchAnim("lp_ris")
					self.jumpstatus="rising"
					self.jumptime=0.1
				else
					self.ponyAnim:switchAnim("hop_ris")
					self.jumpstatus="rising"
					self.jumptime=0.1
				end
			elseif self.jumpstatus=="rising" then
				if self.leaping==true then
					self.ponyAnim:switchAnim("lp_fal")
					self.jumpstatus="falling"
				else
					self.ponyAnim:switchAnim("hop_fal")
					self.jumpstatus="falling"
					self.jumptime=0.1
				end
			elseif self.jumpstatus=="landing" then
				self.ponyAnim:switchAnim("s")
				self.falling=false
				self.leaping=false
				self.jumpstatus=nil
				self.jumptime=0
			end
		end

	end
	if not self.falling and self.jumpstatus~="falling" then
	if self.runCall(self.runVar) then
		self.running=true
	end
	if self.sleeping then
		if self.upCall(self.upVar) or self.downCall(self.downVar) or self.leftCall(self.leftVar) or self.rightCall(self.rightVar) then
			self.sleeping=false
		end
	end
	
	if self.sleepCall(self.sleepVar) then
		self.sleeping=true
		self.ponyAnim:switchAnim("sl")
		self.ponybody:setLinearVelocity(0,0)
	elseif self.upCall(self.upVar) and not self.downCall(self.downVar) then
		if self.rightCall(self.rightVar) and not self.leftCall(self.leftVar) then
			if self.running then
				self.ponyAnim:switchAnim("ru_fr")
				self.ponybody:setLinearVelocity(self.speed*diag*2,-self.speed*diag*2*tileRatio)
			elseif self.creepCall(self.creepVar) then
				self.ponyAnim:switchAnim("sl_fr")
				self.ponybody:setLinearVelocity(self.speed*diag*0.5,-self.speed*diag*0.5*tileRatio)
			else
				self.ponyAnim:switchAnim("n_fr")
				self.ponybody:setLinearVelocity(self.speed*diag,-self.speed*diag*tileRatio)
			end
		elseif self.leftCall(self.leftVar) and not self.rightCall(self.rightVar) then
			if self.running then
				self.ponyAnim:switchAnim("ru_fl")
				self.ponybody:setLinearVelocity(-self.speed*diag*2,-self.speed*diag*2*tileRatio)
			elseif self.creepCall(self.creepVar) then
				self.ponyAnim:switchAnim("sl_fl")
				self.ponybody:setLinearVelocity(-self.speed*diag*0.5,-self.speed*diag*0.5*tileRatio)
			else
				self.ponyAnim:switchAnim("n_fl")
				self.ponybody:setLinearVelocity(-self.speed*diag,-self.speed*diag*tileRatio)
			end
		else
			if self.running then
				self.ponyAnim:switchAnim("ru_f")
				self.ponybody:setLinearVelocity(0,-self.speed*2*tileRatio)
			elseif self.creepCall(self.creepVar) then
				self.ponyAnim:switchAnim("sl_f")
				self.ponybody:setLinearVelocity(0,-self.speed*0.5*tileRatio)
			else
				self.ponyAnim:switchAnim("n_f")
				self.ponybody:setLinearVelocity(0,-self.speed*tileRatio)
			end
		end
	
	elseif self.downCall(self.downVar) and not self.upCall(self.upVar) then
		if self.rightCall(self.rightVar) and not self.leftCall(self.leftVar) then
			if self.running then
				self.ponyAnim:switchAnim("ru_br")
				self.ponybody:setLinearVelocity(self.speed*2*diag,self.speed*2*diag*tileRatio)
			elseif self.creepCall(self.creepVar) then
				self.ponyAnim:switchAnim("sl_br")
				self.ponybody:setLinearVelocity(self.speed*diag*0.5,self.speed*diag*0.5*tileRatio)		
			else
				self.ponyAnim:switchAnim("n_br")
				self.ponybody:setLinearVelocity(self.speed*diag,self.speed*diag*tileRatio)
			end
		elseif self.leftCall(self.leftVar) and not self.rightCall(self.rightVar) then
			if self.running then
				self.ponyAnim:switchAnim("ru_bl")
				self.ponybody:setLinearVelocity(-self.speed*diag*2,self.speed*diag*2*tileRatio)
			elseif self.creepCall(self.creepVar) then
				self.ponyAnim:switchAnim("sl_bl")
				self.ponybody:setLinearVelocity(-self.speed*diag*0.5,self.speed*diag*0.5*tileRatio)		
			else
				self.ponyAnim:switchAnim("n_bl")
				self.ponybody:setLinearVelocity(-self.speed*diag,self.speed*diag*tileRatio)
			end
		else
			if self.running then
				self.ponyAnim:switchAnim("ru_b")
				self.ponybody:setLinearVelocity(0,self.speed*2*tileRatio)
			elseif self.creepCall(self.creepVar) then
				self.ponyAnim:switchAnim("sl_b")
				self.ponybody:setLinearVelocity(0,self.speed*0.5*tileRatio)
			else
				self.ponyAnim:switchAnim("n_b")
				self.ponybody:setLinearVelocity(0,self.speed*tileRatio)
			end
		end
	elseif self.rightCall(self.rightVar) and not self.leftCall(self.leftVar) then
		if self.running then
			self.ponyAnim:switchAnim("ru_r")
			self.ponybody:setLinearVelocity(self.speed*2,0)
		elseif self.creepCall(self.creepVar) then
			self.ponyAnim:switchAnim("sl_r")
			self.ponybody:setLinearVelocity(self.speed*0.5,0)
		else
			self.ponyAnim:switchAnim("n_r")
			self.ponybody:setLinearVelocity(self.speed,0)
		end
	elseif self.leftCall(self.leftVar) and not self.rightCall(self.rightVar) then
		if self.running then
			self.ponyAnim:switchAnim("ru_l")
			self.ponybody:setLinearVelocity(-self.speed*2,0)
		elseif self.creepCall(self.creepVar) then
			self.ponyAnim:switchAnim("sl_l")
			self.ponybody:setLinearVelocity(-self.speed*0.5,0)
		else
			self.ponyAnim:switchAnim("n_l")
			self.ponybody:setLinearVelocity(-self.speed,0)
		end
	else
		self.running=false
		if self.creepCall(self.creepVar) then
			self.ponyAnim:switchAnim("si")
		else
			self.ponyAnim:switchAnim("s")
		end
		local vx,vy=self.ponybody:getLinearVelocity()
		v=math.sqrt(vx^2+vy^2)
		if v<40 then
			vx=0
			vy=0
		else
			vx=vx-(vx)*dt*(20)
			vy=vy-(vy)*dt*(20)
		end
		self.ponybody:setLinearVelocity(vx,vy)

	end
	if self.jumpCall(self.jumpVar) then
		if self.running==true then
			self.leaping=true
			self.falling=true
			self.jumptime=0.1
			self.jumpstatus="start"
			self.ponyAnim:switchAnim("lp_st")
			local x,y = self.ponybody:getLinearVelocity()
			x=x*1.5
			y=y*1.5
			self.zv=self.zv+3
			self.ponybody:setLinearVelocity(x,y)
		else
			self.falling=true
			self.jumptime=0.2
			self.jumpstatus="start"
			self.zv=self.zv+3.5
			self.ponyAnim:switchAnim("hop_st")
		end
	end
	end
end

function ponyControl:hitGround()
	self.falling=false
	self.ponybody:setLinearVelocity(0,0)
	if math.abs(self.zv)>=8 then
		print("damage: ", 4.7^((math.abs(self.zv)/8)-1))
	end
	self.zv=0
		if self.leaping==true then
			self.ponyAnim:switchAnim("lp_lnd")
			self.jumpstatus="landing"
			self.jumptime=0.1
		else
			self.ponyAnim:switchAnim("hop_lnd")
			self.jumpstatus="landing"
			self.jumptime=0.1
		end
end

function ponyControl:fall()
	self.falling=true
	self.jumpstatus="falling"
	self.ponyAnim:switchAnim("hop_fal")
end



function ponyControl:updateAnim(dt)
	self.ponyAnim:update(dt)
end

function ponyControl:getPosition()
	x,y= self.ponybody:getPosition()
	return x,y-24
end

function ponyControl:setPosition(x,y)
	self.ponybody:setPosition(x,y)
end

function ponyControl:getAngle()
	return self.ponybody:getAngle()
end

function ponyControl:draw(x,y)
	self.ponyAnim:draw(x,y)
end

function ponyControl:setCollisionCallbacks(beginCollideVar,beginCollideCall,endCollideVar,endCollideCall,SolveCollideVar,solveCollideCall)
	self.beginCollideCall=beginCollideCall
	self.beginCollideVar=beginCollideVar
	self.endCollideCall=endCollideCall
	self.endCollideVar=endCollideVar
	self.solveCollideCall=solveCollideCall
	self.SolveCollideVar=SolveCollideVar
end

function ponyControl:beginCollide(obj)
	if self.beginCollideCall~=nil then
		self.beginCollideCall(self.beginCollideVar,obj)
	end
end

function ponyControl:collideSolve(obj,ni1,ti1,ni2,ti2)
	if self.solveCollideCall~=nil then
		self.solveCollideCall(self.SolveCollideVar,obj,ni1,ti1,ni2,ti2)
	end
end

function ponyControl:endCollide(obj)
	print("col1")
	if self.endCollideCall~=nil then
		self.endCollideCall(self.endCollideVar,obj)
	end
end


