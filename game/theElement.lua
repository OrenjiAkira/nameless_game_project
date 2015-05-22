

-- the Element --


function theElement(self)

	local id
	local attributes = {}

	-- ID managing --
	function self:getId()
		return id
	end

	-- attributes managing --
	function self:attr( key, value )
		-- Yes, this is just like jquery's .attr() function, except i don't know the exact code from jquery so I just guessed.
		if value then
			print("Setting attribute " .. key .. " to " .. value)
			if attributes[key] then 
				attributes[key] = value
				return attributes[key]
			else
				return false
			end
		else
			print("Getting attribute " .. key)
			return attributes[key] or false
		end
	end
	function self:removeattr( key )
		print("Removing attribute " .. key)
		if attributes[key] then
			attributes[key] = nil
			return true
		else
			print("Attribute not found.")
			return false
		end
	end

	return self
end