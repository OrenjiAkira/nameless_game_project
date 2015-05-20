-- Input Manager --

function input_manager(self)

	local input = input( {} )
	local player = elements:getElement('player')
	local state = "play"

	local function movementinput()
		local movementinput = input:getMovement()
		local playermovement = movement( {}, movementinput, player )
		trigger( "movement", { movementinput, player } )
	end
	function self:update()
		input:update()
		movementinput()
	end

	return self
end