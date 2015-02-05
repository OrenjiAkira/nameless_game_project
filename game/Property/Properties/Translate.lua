-- Translate Property --



function Translate(self, element)
	Property(self, element)

	self:setName('Translate')

	-- local variables
	local x, y = 0, 0 --not world position, but render position
	local playerheight = elements['player']:getAttribute('Sprite', 'QuadHeight')

	-- local methods
	local function constructor( ... )
		local pos = elements['player']:getAttribute('Body', 'Pos')
		element:setAttribute('Body', 'Pos', pos.x, pos.y)
	end

	-- public methods
	function self:setTranslate(ax,ay)
		element:setAttribute('Body', 'Pos', ax, ay)
		x = ax*unit
		y = ay*unit
	end
	
	function self:getTranslate()
		return { x, y }
	end

	-- update methods
	function self:update()
		local pos = element:getAttribute('Body', 'Pos')
		self:setTranslate( pos.x, pos.y )
	end

	function self:render()
		--love.graphics.push()
		love.graphics.translate( -x +window:getWidth()/2, -y + window:getHeight()/2 + playerheight - 8*zoom)
		--love.graphics.pop()
	end

	constructor()
	return self
end