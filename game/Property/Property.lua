-- Property Class --



function Property( self, element )

	local name
	function self:getName()
		return name
	end
	function self:setName(n) 
		name = n
	end

	function self:update()
		return
	end
	function self:render()
		return
	end


	return self
end



