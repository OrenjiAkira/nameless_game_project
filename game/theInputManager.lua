-- the Input Manager --

function theInputManager(self)

	local input = theInput( {} )

	local function interactioninput()
		local getinput = input:getInteraction()
		trigger( "interaction", getinput )
	end
	local function movementinput()
		local getinput = input:getMovement()
		trigger( "movement", getinput )
	end
	function self:update()
		input:update()
		interactioninput()
		movementinput()
	end

	return self
end