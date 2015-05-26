

-- the Sprites --


local self = {}
theDomain(self)
self:setname("sprites")
print("Created domain: "..self:getname())

-- Registring Sprites from assets --
for _,sprite in pairs(database.sprites) do
	local elementsprite = theElement()

	elementsprite:id(sprite.id)
	elementsprite:name(sprite.name)
	local quadwidth = elementsprite:attr("quadwidth", sprite.quadwidth)
	local quadheight =  elementsprite:attr("quadheight", sprite.quadheight)
	local imgwidth =  elementsprite:attr("imgwidth", sprite.imgwidth)
	local imgheight =  elementsprite:attr("imgheight", sprite.imgheight)
	local offsetx =  elementsprite:attr("offsetx", sprite.offsetx)
	local offsety =  elementsprite:attr("offsety", sprite.offsety)
	local quads = elementsprite:attr("quads", {})

	for i=1,imgheight/quadheight do
		quads[i] = {}
		for j=1,imgwidth/quadwidth do
			quads[i][j] = love.graphics.newQuad( (j-1)*quadwidth, (i-1)*quadheight, quadwidth, quadheight, imgwidth, imgheight )
		end
	end
	elementsprite:attr( "image", love.graphics.newImage('_assets/sprites/' .. sprite.filename) ):setFilter( 'nearest', 'nearest' )

	self:add(elementsprite)
end

function self:update()
	
end
function self:rendersprite(id, matrix, pos)
	local sprite = self:get(id)
	print("drawing sprite #" .. id .. " at position ( " .. pos.x ..", " .. pos.y .. " )")
	love.graphics.draw(
		sprite:attr("image"),
		sprite:attr("quads")[matrix.i][matrix.j],
		unit*pos.x, unit*pos.y,
		0, --rotation: nope, don't do it
		1, 1, --scaling: unnecessary since I use the built in love.graphics.scale()
		sprite:attr("offsetx"), sprite:attr("offsety"), --offset: where the reference point is relative to the top-left corner of the quad
		0, 0 --shear: don't touch it ever
	)
end

return self