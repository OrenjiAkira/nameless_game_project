-- the Input Manager --

function theInputManager(self)

	local input = theInput( {} )

	local function interactioninput()
		local getinput = input:getInteraction()
		if getinput then trigger( "interaction", getinput ) end
	end
	local function movementinput()
		local getinput = input:getMovement()
		if getinput then trigger( "movement", getinput ) end
	end
	function self:update()
		input:update()
		interactioninput()
		movementinput()
	end

	return self
end