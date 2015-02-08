-- ElementList



function ElementList( self )
	
	local elist = {}
	local latest = 0

	local function increaseList()
		latest = latest + 1
	end

	local function newPlayer(x, y, xq, qy, offsetx, offsety)

		local element = Element({}, 'player')

		-- create body property
		local body = Body( {}, element )
		-- add body events: MovementInput, Collision, ...
		body:addEvent( Body_MovementInput({}, body) )
		body:addEvent( Body_Collision({}, body, self ) )
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
		body:addEvent( Body_Collision({}, body, self ) )
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
		body:addEvent( Body_Collision({}, body, self ) )
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

	-- public methods
	function self:getElementList()
		return elist
	end

	function self:getElementListSize()
		return latest
	end

	function self:getElement(elementname)
		for _,element in pairs(elist) do
			if element:getId() == elementname then
				return element
			end
		end
		print('Could not find element')
	end

	function self:addElement(element)
		increaseList()
		elist[latest] = element
		print('added element '..element:getId())
	end

	function self:newElement( type, name, x, y, xq, qy, offsetx, offsety )
		local element
		if type == 'player' then
			element = newPlayer(x, y, xq, qy, offsetx, offsety)
			self:addElement(element)
		end
		if type == 'camera' then
			element = newCamera()
			self:addElement(element)
		end
		if type == 'npc' then
			element = newNPC(name, x, y, xq, qy, offsetx, offsety)
			self:addElement(element)
		end
		return element
	end

	-- update methods
	function self:update()
		for _,element in ipairs(elist) do
			element:update()
			if element:getProperty('Body') then
				element:getProperty('Body'):update()
			end
			if element:getProperty('Sprite') then
				element:getProperty('Sprite'):update()
			end
		end
		table.sort(
			elist,
			function(a,b)
				return ( 
					a:getAttribute('Body', 'Pos').y +
					a:getAttribute('Body', 'Height')/2 <
					b:getAttribute('Body', 'Pos').y -
					b:getAttribute('Body', 'Height')/2
				)
			end
		)
	end

	function self:render()
		for _,element in ipairs(elist) do
			element:render()
			if element:getProperty('Sprite') then
				love.graphics.setColor(255,255,255,255)
				element:getProperty('Sprite'):render()
			end
		end
	end

	return self
end