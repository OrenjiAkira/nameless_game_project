-- Translate Property --



function Translate(self, element)
	Property(self, element)

	self:setName('Translate')

	-- local variables
	local x, y = 0, 0 --not world position, but render position
	local playerheight = elements['player']:getProperty('Sprite'):getQuadHeight()

	-- local methods
	local function constructor( ... )
		local pos = elements['player']:getProperty('Position'):getPos()
		element:getProperty('Position'):setPos(pos.x, pos.y)
	end

	-- public methods
	function self:setTranslate(ax,ay)
		element:getProperty('Position'):setPos(ax,ay)
		-- set min or max to hitbox in the future
		x = ax*unit
		y = ay*unit
	end
	
	function self:getTranslate()
		return { x, y }
	end

	-- update methods
	function self:update()
		local pos = element:getProperty('Position'):getPos()
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