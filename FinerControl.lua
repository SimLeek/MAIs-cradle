
local last_key
local double_tap={}
local last_keypress=0

function FC_update_key_press(key,t)
	if key==last_key and last_keypress <=t then
		double_tap[key]=true	
	end
	last_key=key
	last_keypress=0
end

function FC_update_time(dt)
	last_keypress=last_keypress+dt
end

function FC_double_key(key)
	--print(key)
	if double_tap[key] then
		double_tap[key]=false
		return true
	else
		return false
	end
end

function FC_double_key_any(keys)
	--print("double_any",keys)
	for _, k in pairs(keys) do
		if FC_double_key(k) then
			return true
		end
	end
	return false
end

function FC_only_one_key(keys)
	local count=0
	for _, k in pairs(keys) do
		if love.keyboard.isDown(k) then
			count=count+1
		end
	end
	--print(count)
	if count==1 then
		return true
	end
	return false
end

function FC_double_key_only_one(keys)	
	if FC_double_key_any(keys) and FC_only_one_key(keys) then
		return true
	end
	return false
end
