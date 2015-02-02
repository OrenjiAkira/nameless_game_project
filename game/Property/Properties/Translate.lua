-- Translate Property --



function Translate(self, element)
	Property(self, element)

	self:setName('Translate')

	-- local variables
	local x, y = 0, 0
	local playerheight = elements['player']:getProperty('Sprite'):getQuadHeight()

	function self:setTranslate(ax,ay)
		element:getProperty('Position'):setPos(ax,ay)
		x = ax*unit
		y = ay*unit
	end
	function self:getTranslate()
		return { x, y }
	end

	function self:update()
		local pos = elements['player']:getProperty('Position'):getPos()
		self:setTranslate( pos.x, pos.y )
	end

	-- public methods
	function self:render()
		--love.graphics.push()
		love.graphics.translate( -x +window:getWidth()/2, -y + window:getHeight()/2 + playerheight - 8*zoom)
		--love.graphics.pop()
	end

	return self
end