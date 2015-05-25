

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
function self:render()
	
end

return self