-- Position --



function Position( self, element )
	Property(self, element)

	self:setName('Position')
	
	local pos = { x, y }

	-- gets position
	function self:getPos()
		return pos
	end
	-- sets position
	function self:setPos( x, y )
		pos.x = x
		pos.y = y
	end
	
	return self
end