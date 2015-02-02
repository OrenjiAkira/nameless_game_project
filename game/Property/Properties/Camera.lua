-- Camera --



function Camera(self, element)
	Property(self, element)

	self:setName('Camera')

	-- local variables
	local dx, dy = 0, 0

	function self:setTranslate(x,y)
		dx = x*unit*zoom
		dy = y*unit*zoom
	end

	-- public methods
	function self:render()
		love.graphics.push()
		love.graphics.translate( dx, dy )
		--love.graphics.pop()
	end

	return self
end