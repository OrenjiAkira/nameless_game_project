-- Element Class --



function Element( self, name )

	local id = name
	local properties = {}

	function self:getId()
		return id
	end
	function self:isElement()
		return true
	end

	-- public property methods
	function self:getProperty(propertyname)
		return properties[propertyname]
	end
	function self:getPropertyList()
		return properties
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
	
	-- public property attribute methods
	function self:getAttribute( propertyname, attribute )
		local property = self:getProperty(propertyname)
		return property['get'..attribute]( property )
	end
	function self:setAttribute( propertyname, attribute, ... )
		local property = self:getProperty(propertyname)
		property['set'..attribute]( property, ... )
	end

	return self
end

