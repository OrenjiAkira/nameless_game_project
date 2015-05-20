-- Movement --

function Movement( self, move, element )
	Event(self)

	local body = element:getProperty('Body')
	local sprite = element:getProperty('Sprite')
	self:setName("Movement")

	-- calculate movement polar coordinate
	local function getAngle()
		local angle
		local v = Vector2D()
		--local move = input:getMovement()

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
	
	function self:happen()
		local angle = getAngle()
		if angle then
			body:move(angle)
		else
			body:stop()
		end
	end

	return self
end