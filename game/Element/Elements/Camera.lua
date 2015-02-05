-- Camera --



function Camera(self, name)
	Element(self, name)

	local function constructor()
		self:addProperty( Position({}, self ) )
		
		local movement = Movement({}, self )
		movement:addEvent( MovementInput({}, movement ) )

		self:addProperty( movement )
		self:addProperty( HitBox ( {}, element ) )
		self:addProperty( Translate({}, self ) )
	end
	function self:update()
		self:getProperty('Movement'):update()
		self:getProperty('Translate'):update()
	end
	function self:render()
		self:getProperty('Translate'):render()
	end

	constructor()
	return self
end