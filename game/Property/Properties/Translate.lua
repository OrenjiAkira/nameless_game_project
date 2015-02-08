-- Translate Property --



function Translate(self, element)
	Property(self, element)

	self:setName('Translate')

	-- local variables
	local x, y = 0, 0 --not world position, but render position
	local player = elements:getElement('player')
	local playerpos = player:getAttribute('Body', 'Pos')
	local playerheight_offset = player:getAttribute('Sprite', 'Offset').y

	-- local methods
	local function constructor()
		local pos = player:getAttribute('Body', 'Pos')
		element:setAttribute('Body', 'Pos', pos.x, pos.y)
	end

	local function setTranslate(ax,ay)
		element:setAttribute('Body', 'Pos', ax, ay)
		x = ax*unit
		y = ay*unit
	end
	
	local function getCameraPosition()
		local pos = element:getAttribute('Body', 'Pos')
		if pos ~= playerpos then
			pos = playerpos
		end
		return pos
	end
	-- public methods
	function self:getTranslate()
		return { x, y }
	end

	-- update methods
	function self:update()
		local pos = getCameraPosition()
		setTranslate( pos.x, pos.y )
	end

	function self:render()
		--love.graphics.push()
		love.graphics.translate( -x +window:getWidth()/2, -y + window:getHeight()/2 + playerheight_offset)
		--love.graphics.pop()
	end

	constructor()
	return self
end