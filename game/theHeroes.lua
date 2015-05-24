

-- the Heroes --


function theHeroes()

	local self = {}
	theDomain(self)
	self:setname("heroes")
	print("Created domain: "..self:getname())

	-- Registering Heroes from Database --
	for _,hero in pairs(database.heroes) do
		local elementhero = theElement({})

		elementhero:id(hero.id)
		elementhero:name(hero.name)
		elementhero:attr("width", hero.width)
		elementhero:attr("height", hero.height)
		elementhero:attr("sprite", hero.sprite)

		self:add(elementhero)
	end
	

	return self
end
