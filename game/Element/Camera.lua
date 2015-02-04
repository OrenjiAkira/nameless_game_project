-- Camera --



function Camera(self, name)
	Element(self, name)

	local function constructor()
		self:addProperty( Position({}, self ) )
		self:addProperty( Movement({}, self ) )
		self:addProperty( MovementInput({}, self ) )
		self:addProperty( HitBox ( {}, element ) )
		self:addProperty( Translate({}, self ) )
	end
	function self:update()
		self:getProperty('MovementInput'):update()
		self:getProperty('Movement'):update()
		self:getProperty('Translate'):update()
	end
	function self:render()
		self:getProperty('Translate'):render()
	end

	constructor()
	return self
end