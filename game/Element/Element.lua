-- Element Class --



function Element( self, name )

	local id = name
	local properties = {}

	function self:getId()
		return id
	end
	function self:getProperty(propertyname)
		return properties[propertyname]
	end
	function self:getPropertyList()
		return properties
	end
	
	function self:getAttribute( propertyname, attribute )
		local property = self:getProperty(propertyname)
		print('getting '.. attribute)
		return property['get'..attribute]( property )
	end
	function self:setAttribute( propertyname, attribute, ... )
		local property = self:getProperty(propertyname)
		print('setting '.. attribute ..' to ' .. ...)
		property['set'..attribute]( property, ... )
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

