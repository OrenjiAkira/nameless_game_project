-- ActiveInput --



function Movement( self, element )
	Property(self, element)

	self:setName('Movement')

	local speed = 0
	local acc = 0.1
	local speedlimit = 0.4
	local direction

	-- gets speed
	function self:getSpeed()
		return speed
	end
	
	-- sets speed
	function self:setSpeed(newspeed)
		speed = newspeed
	end

	-- gets acceleration
	function self:getAcceleration()
		return acc
	end
	
	-- sets acceleration
	function self:setAcceleration(newacc)
		acc = newacc
	end

	-- gets speedlimit
	function self:getSpeedLimit()
		return speedlimit
	end
	
	-- sets speedlimit
	function self:setSpeedLimit(newlimit)
		speedlimit = newlimit
	end

	-- private action methods
	function self:move(dir)
		direction = dir
		speed = speed + acc
		if speed > speedlimit then speed = speedlimit end
	end
	function self:stop()
		speed = speed - acc
		if speed < 0 then speed = 0 end
	end

	-- update method
	function self:update()
		if direction and speed > 0 then
			local pos = element:getProperty('Position'):getPos()
			local dx = speed*math.cos(direction)
			local dy = speed*math.sin(direction)
			local x = dx + pos.x
	    local y = dy + pos.y
	    element:getProperty('Position'):setPos( x, y )
	    if element:getProperty('Camera') then 
	    	element:getProperty('Camera'):setTranslate( dx, dy )
	    end
	  end
	end

	return self
end