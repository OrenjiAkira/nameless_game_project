-- Body --



function Body( self, element )
	Property(self)

	self:setName('Body')

	local width
	local height
	local pos = { x, y }
	local speed = 0
	local acc = 0.1
	local speedlimit = 0.4
	local direction

	-- gets width
	function self:getWidth()
		return width
	end
	-- gets height
	function self:getHeight()
		return height
	end
	-- sets width
	function self:setWidth(newwidth)
		width = newwidth
	end
	-- sets height
	function self:setHeight(newheight)
		height = newheight
	end

	-- gets position
	function self:getPos()
		return pos
	end
	-- sets position
	function self:setPos( x, y )
		pos.x = x
		pos.y = y
	end

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
		self:setSpeed(speed + acc)
		if speed > speedlimit then self:setSpeed(speedlimit) end
	end
	function self:stop()
		self:setSpeed(speed - acc)
		if speed < 0 then self:setSpeed(0) end
	end

	-- update method
	function self:update()

		movementInput = self:getEvent('Body_MovementInput')
		if movementInput then
			self:getEvent('Body_MovementInput'):update()
		end

		if direction and speed > 0 then
			-- current position
			local oldx = self:getPos().x
			local oldy = self:getPos().y
			local x, y

			-- displacement
			local dx = speed*math.cos(direction)
			local dy = speed*math.sin(direction)

			local shouldImove = self:getEvent('Body_Collision'):update( element, oldx+dx, oldy+dy )

			-- new position
			print(shouldImove)
			if shouldImove then
				x = dx + oldx
		    y = dy + oldy
		  else
		  	x = oldx
		    y = oldy
		  end
	    self:setPos( x, y )
	  end
	end

	return self
end