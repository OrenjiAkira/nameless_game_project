-- user interface > image

--require ''

function graphicUI( self, file, _pos )

	local sprite = love.graphics.newImage( '/assets/sprites/' .. file .. '.png' )
	local width = sprite:getWidth()
	local height = sprite:getHeight()
	local pos = _pos
	local size = 2

	sprite:setFilter( 'nearest', 'nearest' )

	function self:getSprite()
		return sprite
	end
	function self:getWidth()
		return width
	end
	function self:getHeight()
		return height
	end
	function self:getSize()
		return size
	end
	function self:getPos()
		return pos
	end
	function self:getQuadWidth(xq)
		return width/xq
	end
	function self:getQuadHeight(yq)
		return height/yq
	end

	return self
end

