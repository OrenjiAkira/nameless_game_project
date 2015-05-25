

-- the Element --


function theElement(self)

	local id
	local name
	local attributes = {}

	-- ID managing --
	function self:id(value)
		if value then
			id = value
		end
		return id
	end

	function self:name(value)
		if value then
			name = value
		end
		return name
	end

	-- attributes managing --
	function self:attr( key, value )
		-- Yes, this is just like jquery's .attr() function, except i don't know the exact code from jquery so I just guessed.
		if value then
			print("New attribute " .. key)
			attributes[key] = value
		else
			print("Getting attribute " .. key)
		end
		return attributes[key]
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