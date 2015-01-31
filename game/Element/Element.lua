-- Element Class --



function Element( self, id )

	if not id then
		local id
	end
	local properties = {}

	function self:getId()
		return id
	end
	function self:getProperty(propertyname)
		return properties[propertyname]
	end

	function self:addProperty(property)
		local propertylabel = property:getName()
		if not properties[propertylabel] then
			properties[propertylabel] = property
		else
			print('Element already has "'..propertylabel..'" property')
		end
	end

	function self:removeProperty(propertyname)
		properties[propertyname] = nil
	end

	return self
end

