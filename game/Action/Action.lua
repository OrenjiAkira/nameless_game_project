-- action --

-- An event of a property

function Action( self )

	local name

	-- public methods
	function self:getName()
		return name
	end
	function self:setName(n) 
		name = n
	end

	function self:happen()
		return
	end

	return self
end