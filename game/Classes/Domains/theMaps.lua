

-- the View --


function theMaps()

	local self
	theDomain(self)
	self:setname("view")
	print("Created domain: "..self:getname())

	-- Registring Sprites from assets --
	for _,map in pairs(database.maps) do
		local elementmap = theElement({})

		elementmap:id(elementmap.id)
		elementmap:name(elementmap.name)
		elementmap:attr("width", elementmap.width)
		elementmap:attr("height", elementmap.height)
		elementmap:attr("spritesheet", elementmap.spritesheet)
		elementmap:attr("layers", elementmap.layers)
		elementmap:attr("bodies", elementmap.bodies)

		self:add(elementmap)
	end


	return self
end