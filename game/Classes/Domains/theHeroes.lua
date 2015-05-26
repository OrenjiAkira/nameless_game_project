

-- the Heroes --


local self = {}
theDomain(self)
self:setname("heroes")
print("Created domain: "..self:getname())

-- Registering Heroes from Database --
for _,hero in pairs(database.heroes) do
	local elementhero = theElement()

	elementhero:id(hero.id)
	elementhero:name(hero.name)
	elementhero:attr("width", hero.width)
	elementhero:attr("height", hero.height)

	self:add(elementhero)
end


return self