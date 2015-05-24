

-- the Input --


function theInput(self)
	theDomain(self)

	local input = theInputReader()
	self:add(input)

	function self:update()
		input:update()
	end

end