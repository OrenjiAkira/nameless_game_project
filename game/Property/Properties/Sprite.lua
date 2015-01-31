-- Sprite --



function Sprite( self, element, file, xquads, yquads, _row )
	Property(self, element)

	self:setName('Sprite')
	
	local sprite = love.graphics.newImage( '/assets/sprites/' .. file .. '.png' )
	sprite:setFilter( 'nearest', 'nearest' )
	
	local width = sprite:getWidth()
	local height = sprite:getHeight()
	local quadwidth = width/xquads
	local quadheight = height/yquads
	local size = 2
	local quadgrid = {}
	local row = _row or 1
	local col = 1
	local updateframes = 6
	local tick = 0
	local state = { action='stop', direction='left' }
	
	local function generateQuads()
		for i = 1, yquads do
			quadgrid[i] = {}
			for j = 1, xquads do
				local quad = love.graphics.newQuad ( (j-1)*quadwidth, (i-1)*quadheight, quadwidth, quadheight, width, height)
				quadgrid[i][j] = quad
			end
		end
	end

	-- transform world position in render position
	local function getRenderPos()
		local pos = element:getProperty('Position'):getPos()
		local renderpos = {x,y}
		renderpos.x = pos.x*unit
		renderpos.y = pos.y*unit
		return renderpos
	end
	
	-- walk animation
	local function walkanimation()
		tick = tick + 1
		if tick >= updateframes then
			tick = 0
			col = (col % xquads) + 1
		end
	end

	-- gets sprite's width
	function self:getWidth()
		return width
	end
	
	-- gets sprite's height
	function self:getHeight()
		return height
	end
	
	-- gets quads' width
	function self:getQuadWidth()
		return width/xquads
	end
	
	-- gets quads' height
	function self:getQuadHeight()
		return height/yquads
	end
	
	-- gets rendering size
	function self:getSize()
		return size
	end

	-- get state
	function self:getState()
		return state
	end
	-- set state
	function self:setState(action, direction)
		state.action = action
		state.direction = direction or state.direction
	end

	
	-- update method
	function self:update()
		if state.action == 'stop' then
			col = 1
			if state.direction == 'left' then
				row = 1
			end
			if state.direction == 'right' then
				row = 2
			end
		end
		if state.action == 'walk' then
			if state.direction == 'left' then
				row = 3
			end
			if state.direction == 'right' then
				row = 4
			end
			walkanimation()
		end
	end

	-- render method
	function self:render()
		local pos = getRenderPos()
		love.graphics.draw(sprite, quadgrid[row][col], pos.x, pos.y, 0, size, size, quadwidth/2, quadheight-(8*size))
	end

	generateQuads()
	
	return self
end