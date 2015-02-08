-- Movement Input --



function Body_MovementInput( self, body )
	Event(self)

	local function constructor()
		self:setName('Body_MovementInput')
	end

	-- calculate movement polar coordinate
	function self:getAngle()
		local angle
		local v = Vector2D()
		local move = input:isMoving()

		if move then
			if move.l then
				v.x = -1
			end
			if move.r then
				v.x = 1
			end
			if move.u then
				v.y = -1
			end
			if move.d then
				v.y = 1
			end
			angle = math.atan2(v.y, v.x)
			return angle
		else
			return
		end
	end
	
	-- update method
	function self:update()
		local angle = self:getAngle()
		
		if angle then
			body:move(angle)
		else
			body:stop()
		end
	end

	constructor()
	return self
end