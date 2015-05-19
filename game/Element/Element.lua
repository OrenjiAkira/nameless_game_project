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

	function self:update()
		if self:getProperty('Body') then
			self:getProperty('Body'):update()
		end
		if self:getProperty('Sprite') then
			self:getProperty('Sprite'):update()
		end
		if self:getProperty('Translate') then
			self:getProperty('Translate'):update()
		end
	end
	function self:render()
		if self:getProperty('Sprite') then
			self:getProperty('Sprite'):render()
		end
		if self:getProperty('Translate') then
			self:getProperty('Translate'):render()
		end
	end

	return self
end

