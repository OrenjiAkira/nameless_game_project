

-- the Element --


function theElement(self)
	local id
	local attributes = {}

	function self:getId()
		return id
	end
	function self:attr( key, value )
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