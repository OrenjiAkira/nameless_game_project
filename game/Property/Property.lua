-- Property Class --



function Property( self, element )

	local name

	-- public methods
	function self:getName()
		return name
	end
	function self:setName(n) 
		name = n
	end

	-- public update methods
	function self:update()
		return
	end
	function self:render()
		return
	end


	return self
end



