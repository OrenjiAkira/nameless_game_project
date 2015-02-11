-- ElementList



function ElementList( self )
	
	local elist = {}
	local latest = 0

	local function increaseList()
		latest = latest + 1
	end

	local function newPlayer(x, y, xq, yq)

		local element = Element({}, 'player')

		-- create body property
		local body = Body( {}, element, Vector2D( x, y ), xq, yq, false, true )
		body:addEvent( Body_MovementInput({}, body) )
		body:addEvent( Body_Collision({}, body, self ) )
		element:addProperty( body )

		-- create sprite property
		local sprite = Sprite( {}, element, 'avatar', 4, 4 )
		sprite:addEvent( Sprite_MovementInput({}, sprite) )
		element:addProperty( sprite )

		return element
	end

	local function newCamera()

		local element = Camera({}, 'camera')

		local body = Body({}, element, nil, 80, 45, true, true )
		body:addEvent( Body_MovementInput({}, body ) )
		body:addEvent( Body_Collision({}, body, self ) )
		element:addProperty( body )

		element:addProperty( Translate({}, element ) )

		return element
	end

	local function newNPC(name, x, y, xq, yq)

		local element, interaction = Element({}, name), Element({}, name..'_interaction')

		-- create body property
		local body = Body( {}, element, Vector2D( x, y ), xq, yq, false, true )
		local ibody = Body( {}, element, Vector2D( x, y ), xq*1.5, yq*1.5, false, false )
		body:addEvent( Body_Collision({}, body, self ) )
		ibody:addEvent( Body_Collision({}, ibody, self ) )
		element:addProperty( body )
		interaction:addProperty( ibody )

		-- create sprite property
		local sprite = Sprite ( {}, element, name or 'NPC', 1, 1 )
		element:addProperty( sprite )

		return element, interaction
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

	function self:newElement( type, name, x, y, xq, yq )
		local element
		if type == 'player' then
			element = newPlayer(x, y, xq, yq)
			self:addElement(element)
		end
		if type == 'camera' then
			element = newCamera()
			self:addElement(element)
		end
		if type == 'npc' then
			local interaction
			element, interaction = newNPC(name, x, y, xq, yq)
			self:addElement(element)
			self:addElement(interaction)
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