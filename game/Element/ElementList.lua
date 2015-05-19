-- ElementList



function ElementList( self )
	
	local elist = {}


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
		local ibody = Body( {}, element, Vector2D( x, y ), xq*1.5, yq*2.5, false, false )
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

	function self:getElement(elementname)
		for _,element in pairs(elist) do
			if element:getId() == elementname then
				return element
			end
		end
		print('Could not find element')
	end

	function self:addElement(element)
		table.insert(elist, element)
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
		end
		table.sort(
			elist,
			function(a,b)
				a_bottom = a:getAttribute('Body', 'Pos').y + a:getAttribute('Body', 'Height')/2
				b_top = b:getAttribute('Body', 'Pos').y - b:getAttribute('Body', 'Height')/2
				return ( a_bottom < b_top )
			end
		)
	end

	function self:render()
		for _,element in ipairs(elist) do
			element:render()
		end
	end

	return self
end