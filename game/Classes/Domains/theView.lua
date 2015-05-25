

-- the View --


function theView()

	local self
	local currentmap
	local camera
	theDomain(self)
	self:setname("view")
	print("Created domain: "..self:getname())



	function self:setcurrentmap(mapid)
		currentmap = mapid
	end

	function self:update()
		
	end

	return self
end