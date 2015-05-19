-- Input Manager --

function input_manager(self)

	local input = input( {} )
	local player = elements:getElement('player')

	local function movement()
		local movementinput = input:getMovement()
		local playermovement = Movement( {}, movementinput, player )
		queryEvent(playermovement)
	end
	function self:update()
		input:update()
		movement()
	end

	return self
end