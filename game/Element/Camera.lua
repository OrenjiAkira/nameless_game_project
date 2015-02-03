-- Camera --



function Camera(self, name)
	Element(self, name)

	local function constructor()
		self:addProperty( Position({}, self ) )
		self:addProperty( Input({}, self ) )
		self:addProperty( Movement({}, self ) )
		self:addProperty( Translate({}, self ) )
	end
	function self:update()
		self:getProperty('Input'):update()
		self:getProperty('Movement'):update()
		self:getProperty('Translate'):update()
	end
	function self:render()
		self:getProperty('Translate'):render()
	end

	constructor()
	return self
end