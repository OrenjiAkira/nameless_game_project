-- Movement Collision --

-- movement event

function MovementCollision( self, movement )
	Event(self, movement)

	local function constructor()
		self:setName('MovementCollision')
	end

	constructor()
	return self
end