-- Input Manager --

function input_manager(self)

	local input = input( {} )
	local player = elements:getElement('player')
	local state = "play"

	local function movement()
		local movementinput = input:getMovement()
		local playermovement = Movement( {}, movementinput, player )
		queryEvent(playermovement)
	end
	local function movementanimation()
		local movementinput = input:getMovement()
		local playermovement_animation = Movement_Animation( {}, movementinput, player )
		queryEvent(playermovement_animation)
	end
	function self:update()
		input:update()
		movementanimation()
		movement()
	end

	return self
end