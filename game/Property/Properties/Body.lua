-- Body --



function Body( self, element )
	Property(self)

	self:setName('Body')

	local width
	local height
	local pos = Vector2D()
	local speed = 0
	local acc = 0.1
	local speedlimit = 0.4
	local direction
	local invertedhitbox

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
		pos:set( x, y )
	end

	-- gets speed
	function self:getSpeed()
		return speed
	end
	-- sets speed
	function self:setSpeed( newspeed )
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

	-- gets direction
	function self:getDirection()
		return direction
	end
	-- sets direction
	function self:setDirection(newdir)
		direction = newdir
	end

	-- if hitbox is inverted
	function self:getInvertedHitbox()
		return invertedhitbox
	end
	-- set hitbox's inversion
	function self:setInvertedHitbox(isInverted)
		invertedhitbox = isInverted
	end

	-- public action methods
	function self:move(dir)
		self:setDirection(dir)
		speed = speed + acc
		if speed > speedlimit then speed = speedlimit end
	end

	function self:stop()
		speed = speed - acc
		if speed < 0 then speed = 0 end
	end


	-- update Collision
	local function verifyCollision( old_coordinate, new_coordinate, axis )

		local isColliding = self:getEvent('Body_Collision'):update( element, new_coordinate, axis )
		
		if isColliding then
	  	return old_coordinate
	  else
			return new_coordinate
	  end
	end


	-- update method
	function self:update()

		-- update input
		movementinput = self:getEvent('Body_MovementInput')
		if movementinput then
			movementinput:update()
		end

		if direction and speed > 0 then
			--print(speed.x, speed.y)
			-- current position
			local oldx = pos.x
			local oldy = pos.y
			local x, y

			-- displacement
			local dx = speed*math.cos(direction)
			local dy = speed*math.sin(direction)

		  if self:getEvent('Body_Collision') then
		  	x = verifyCollision(oldx, oldx+dx, 'x')
		  	y = verifyCollision(oldy, oldy+dy, 'y')
		  else
		  	x = oldx + dx
		  	y = oldy + dy
		  end

	    self:setPos( x, y )
	  end
	end

	return self
end
	
