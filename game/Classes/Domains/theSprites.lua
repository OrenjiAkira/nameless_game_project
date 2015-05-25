

-- the Sprites --


function theSprites()

	local self = {}
	theDomain(self)
	self:setname("sprites")
	print("Created domain: "..self:getname())

	-- Registring Sprites from assets --
	for _,sprite in pairs(database.sprites) do
		local elementsprite = theElement({})

		elementsprite:id(sprite.id)
		elementsprite:name(sprite.name)
		elementsprite:attr("quadwidth", sprite.quadwidth)
		elementsprite:attr("quadheight", sprite.quadheight)
		elementsprite:attr("imgwidth", sprite.imgwidth)
		elementsprite:attr("imgheight", sprite.imgheight)
		elementsprite:attr("offsetx", sprite.offsetx)
		elementsprite:attr("offsety", sprite.offsety)

		elementsprite:attr( "image", love.graphics.newImage('_assets/sprites/' .. sprite.filename) ):setFilter( 'nearest', 'nearest' )

		self:add(elementsprite)
	end

	return self
end