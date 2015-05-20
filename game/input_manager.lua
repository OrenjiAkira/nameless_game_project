-- Input Manager --

function input_manager(self)

	local input = input( {} )
	local player = elements:getElement('player')
	local state = "play"

	local function movement()
		local movementinput = input:getMovement()
		local playermovement = movement( {}, movementinput, player )
		trigger( "playermovement", { movementinput, player } )
	end
	function self:update()
		input:update()
		movement()
	end

	return self
end