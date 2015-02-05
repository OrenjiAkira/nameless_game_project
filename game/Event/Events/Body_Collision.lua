-- Movement Collision --



function Body_Collision( self, movement )
	Event(self, movement)

	local function constructor()
		self:setName('Collision')
	end

	constructor()
	return self
end