-- Input Manager --

function Input_Manager(self)

	local Input = Input( {} )

	local function interactioninput()
		local input = Input:getInteraction()
		trigger( "interaction", input )
	end
	local function movementinput()
		local input = Input:getMovement()
		trigger( "movement", input )
	end
	function self:update()
		Input:update()
		interactioninput()
		movementinput()
	end

	return self
end