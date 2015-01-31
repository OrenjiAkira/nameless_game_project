-- Input --



function Input( self, element )
	Property(self, element)

	self:setName('Input')

	local direction

	local function calcAngle()
		local angle
		if love.keyboard.isDown( 'left' ) and not love.keyboard.isDown( 'up', 'down' ) then
	    angle = math.pi
	  elseif love.keyboard.isDown( 'right' ) and not love.keyboard.isDown( 'up', 'down' ) then
	    angle = 0
	  elseif love.keyboard.isDown( 'up' ) and not love.keyboard.isDown( 'left', 'right' ) then
	    angle = 3*math.pi/2
	  elseif love.keyboard.isDown( 'down' ) and not love.keyboard.isDown( 'left', 'right' ) then
	    angle = math.pi/2
	  elseif love.keyboard.isDown( 'up' ) and love.keyboard.isDown( 'right' ) then
	    angle = 7*math.pi/4
	  elseif love.keyboard.isDown( 'up' ) and love.keyboard.isDown( 'left' ) then
	    angle = 5*math.pi/4
	  elseif love.keyboard.isDown( 'down' ) and love.keyboard.isDown( 'right' ) then
	    angle = math.pi/4
	  elseif love.keyboard.isDown( 'down' ) and love.keyboard.isDown( 'left' ) then
	    angle = 3*math.pi/4
	  end
	  direction = angle
	end

	-- gets movement
	function self:isMovement()
		if love.keyboard.isDown('up', 'down', 'right', 'left') then
			calcAngle()
			return true
		else
			return false
		end
	end

	-- gets movement direction
	function self:getDirection()
		return direction
	end
	
	-- update method
	function self:update()
		self:isMovement()
	end

	return self
end