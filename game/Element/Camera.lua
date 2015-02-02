-- Camera --



function Camera(self, name)
	Element(self, name)

	function self:update()
		self:getProperty('Input'):update()
		self:getProperty('Movement'):update()
		self:getProperty('Translate'):update()
	end
	function self:render()
		self:getProperty('Translate'):render()
	end

	return self
end