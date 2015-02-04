-- Hit Box --



function HitBox( self, element )
	Property(self, element)

	self:setName('HitBox')

	-- local variables
	local width
	local height

	-- public methods
	function self:getWidth()
		return width
	end
	function self:getHeight()
		return height
	end
	function self:setWidth(newwidth)
		width = newwidth
	end
	function self:setHeight(newheight)
		height = newheight
	end

	return self
end