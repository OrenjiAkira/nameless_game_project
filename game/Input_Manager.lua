-- Input Manager --

function Input_Manager(self)

	local Input = Input( {} )
	local player = elements:getElement('player')
	local state = "play"

	local function movementinput()
		local movementinput = Input:getMovement()
		trigger( "movement", { movementinput, player } )
	end
	function self:update()
		Input:update()
		movementinput()
	end

	return self
end