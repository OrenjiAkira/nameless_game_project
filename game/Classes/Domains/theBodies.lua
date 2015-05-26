

-- the Bodies --


local self = {}
theDomain(self)
self:setname('bodies')
print("Created domain: "..self:getname())

--[[
	
	This domain is different than the others so far. It has a bunch of elements in it, but it will add or
	remove them at will, and not just do so based on the database. In fact, it will read from other domains
	that do that, such as domain_heroes and domain_npcs, and create and/or delete and/or manipulate its elements
	at will...based on the action triggers, of course.

]]

-- list of bodies the game should render
local currentbodies = {}

function self:registerbody(info)
	local element = theElement()
	element:id(info.id)
	element:name(info.name)
	element:attr("type", info.type)
	element:attr("typeid", info.typeid)
	element:attr("pos", info.pos)
	element:attr("spriteid", info.spriteid)
	element:attr("frame", info.frame)
	self:add(element)
end
function self:unregisterbody(id)
	self:rem(id)
end
function self:addbody(id)
	table.insert(currentbodies, self:get(id))
end

function self:render()
	for _,body in ipairs(currentbodies) do
		trigger("rendersprite", {
			body:attr("spriteid"),
			{i=1,j=1},
			body:attr("pos")
		})
	end
end

-- hard coded bodies --
local avatar = {
	id = 1,
	name = "avatar",
	type = "hero",
	typeid = 1,
	pos = Vector2D(22,16),
	spriteid = 1,
	frame = {
		state = "still",
		direction = "left"
	}
}
self:registerbody(avatar)
self:addbody(1)

return self