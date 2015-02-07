-- ElementList



function ElementList( self )
	
	local elist = {}

	local function newPlayer(x, y, xq, qy, offsetx, offsety)

		local element = Element({}, 'player')

		-- create body property
		local body = Body( {}, element )
		-- add body events: MovementInput, Collision, ...
		body:addEvent( Body_MovementInput({}, body) )
		body:addEvent( Body_Collision({}, body ) )
		body:setWidth(3*zoom)
		body:setHeight(1*zoom)
		-- add body to element
		element:addProperty( body )

		-- create sprite property
		local sprite = Sprite( {}, element, 'avatar', 4, 4 )
		if offsetx and offsety then
			sprite:setOffset(offsetx,offsety)
		end
		-- add sprite events: MovementInput, ...
		sprite:addEvent( Sprite_MovementInput({}, sprite) )
		-- add sprite to element
		element:addProperty( sprite )
		return element
	end

	local function newCamera()

		local element = Camera({}, 'camera')

		local body = Body({}, element )
		body:addEvent( Body_MovementInput({}, body ) )
		body:addEvent( Body_Collision({}, body ) )
		body:setWidth(80)
		body:setHeight(45)
		element:addProperty( body )

		element:addProperty( Translate({}, element ) )

		return element
	end

	local function newNPC(name, x, y, xq, qy, offsetx, offsety)

		local element = Element({}, name)

		-- create body property
		local body = Body( {}, element )
		-- add body events: Collision, ...
		body:addEvent( Body_Collision({}, body ) )
		body:setWidth(3*zoom)
		body:setHeight(1*zoom)
		-- add body to element
		element:addProperty( body )

		-- create sprite property
		local sprite = Sprite ( {}, element, name or 'NPC', 1, 1 )
		if offsetx and offsety then
			sprite:setOffset(offsetx,offsety)
		end
		-- add sprite to element
		element:addProperty( sprite )

		return element
	end

	function self:addElement(element)
		local name = element:getId()
		elist[name] = element
	end
	function self:getElement(elementname)
		return elist[elementname]
	end
	function self:getElementList()
		return elist
	end

	function self:newElement( type, name, x, y, xq, qy, offsetx, offsety )
		local element
		if type == 'player' then
			element = newPlayer(x, y, xq, qy, offsetx, offsety)
			self:addElement(element)
		end
		if type == 'camera' then
			element = newCamera()
		end
		if type == 'npc' then
			element = newNPC(name, x, y, xq, qy, offsetx, offsety)
			self:addElement(element)
		end
		return element
	end

	return self
end