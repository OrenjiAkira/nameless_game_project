-- ActiveInput --



function Movement( self, element )
	Property(self, element)

	self:setName('Movement')

	local speed = 0
	local acc = 0.05
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
	local function go()
		speed = speed + acc
		if speed > speedlimit then speed = speedlimit end
	end
	local function stop()
		speed = speed - acc
		if speed < 0 then speed = 0 end
	end

	-- update method
	function self:update()
		local moving = element:getProperty('Input'):isMovement()
		if moving then
			direction = element:getProperty('Input'):getDirection()
			go()
		else
			stop()
		end
		if direction or speed > 0 then
			local pos = element:getProperty('Position'):getPos()
			local x = speed*math.cos(direction) + pos.x
	    local y = speed*math.sin(direction) + pos.y
	    element:getProperty('Position'):setPos( x, y )
    	--print(x,y)
	  end
	end

	return self
end