-- Camera --



function Camera(self, name)
	Element(self, name)

	local function constructor()
		local body = Body({}, self )
		body:addEvent( Body_MovementInput({}, body ) )
		body:addEvent( Body_Collision({}, body ) )
		self:addProperty( body )

		self:addProperty( Translate({}, self ) )
	end
	function self:update()
		self:getProperty('Body'):update()
		self:getProperty('Translate'):update()
	end
	function self:render()
		self:getProperty('Translate'):render()
	end

	constructor()
	return self
end