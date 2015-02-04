-- Movement Input --

-- only works on elements with movement

function MovementInput( self, element )
	Property(self, element)

	self:setName('MovementInput')

	local direction

	-- calculate movement polar coordinate
	local function calcAngle()
		local angle
		local vector = { x = 0, y = 0 }
		local l, r, u, d = false, false, false, false

		if love.keyboard.isDown( 'left' ) then
			vector.x = vector.x - 1
			l = true
		end
		if love.keyboard.isDown( 'right' ) then
			vector.x = vector.x + 1
			r = true
		end
		if love.keyboard.isDown( 'up' ) then
			vector.y = vector.y - 1
			u = true
		end
		if love.keyboard.isDown( 'down' ) then
			vector.y = vector.y + 1
			d = true
		end

		if not( l and r ) and not( u and d ) then
			angle = math.atan2(vector.y, vector.x)
		elseif ( l and r ) and not( u and d ) then
			if u then
				angle = 3*math.pi/2
			elseif d then
				angle = math.pi/2
			else
				return false
			end
		elseif not( l and r) and ( u and d ) then
			if l then
				angle = math.pi
			elseif r then
				angle = 2*math.pi
			else
				return false
			end
		else
			return false
		end

	  direction = angle

	  if l or r or d or u then
	  	return true
	  else
	  	return false
	  end
	end
	
	-- set the state of movement animation
	local function setMovementInputState(move)
		if move then
			if love.keyboard.isDown('left') then
				element:getProperty('Sprite'):setState('walk','left')
			elseif love.keyboard.isDown('right') then
				element:getProperty('Sprite'):setState('walk','right')
			else
				element:getProperty('Sprite'):setState('walk')
			end
		else
			-- stop movement animation
			element:getProperty('Sprite'):setState('still')
		end
	end

	-- gets movement direction
	function self:getDirection()
		return direction
	end
	
	-- update method
	function self:update()
		local moving = calcAngle()
		
		if moving then
			element:getProperty('Movement'):move(direction)
		else
			element:getProperty('Movement'):stop()
		end
		
		if element:getProperty('Sprite') then
			setMovementInputState(moving)
		end
	end

	return self
end