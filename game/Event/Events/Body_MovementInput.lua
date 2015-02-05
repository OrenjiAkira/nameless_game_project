-- Movement Input --



function Body_MovementInput( self, body )
	Event(self)

	local function constructor()
		self:setName('Body_MovementInput')
	end

	-- calculate movement polar coordinate
	function self:getAngle()
		local angle
		local vector = { x = 0, y = 0 }
		local move = input:isMoving()

		if move then
			if move.l then
				vector.x = -1
			end
			if move.r then
				vector.x = 1
			end
			if move.u then
				vector.y = -1
			end
			if move.d then
				vector.y = 1
			end
			angle = math.atan2(vector.y, vector.x)
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