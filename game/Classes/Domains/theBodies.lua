

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

-- hard coded bodies --

local currentbodies = {}
local avatar = theElement()
table.insert(currentbodies, avatar)
avatar:id(1)
avatar:name("avatar")
avatar:attr("type", "hero")
avatar:attr("typeid", 1)
avatar:attr("pos", Vector2D(22,16))
avatar:attr("sprite", 1)
avatar:attr("state", "still")
self:add(avatar)

function self:render()
	for _,body in ipairs(currentbodies) do
		trigger("rendersprite", {
			body:attr("sprite"),
			{i=1,j=1},
			body:attr("pos")
		})
	end
end


return self