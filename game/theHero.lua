

-- the Hero --


function theHero()
 	local self = {}
 	local name
 	theElement(self)

 	-- naming --
	function self:name(value)
		if value then
			name = value
		end
		return name
	end

 	return self
end