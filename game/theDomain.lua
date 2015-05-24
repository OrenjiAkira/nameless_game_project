

-- the Domain --


function theDomain(self)

	local list = {}
	local name = "domain_"

	function self:setname(n)
		name = "domain_" .. n
	end
	function self:getname()
		local n = name
		return n
	end

	-- list managing --
	function self:get(id)
		print("Looking for element of id#" .. id)
		for i,element in ipairs(list) do
			if element:id() == id then
				print("Element added.")
				return element
			end
		end
		return false
	end
	function self:add(element)
		print("Adding element of id#" .. element:id())
		table.insert(list, element)
	end
	function self:rem(id)
		print("Looking for element of id#" .. id)
		for i,element in ipairs(list) do
			if element:id() == id then
				table.remove(list, i)
				print("Element found and removed.")
				return true
			end
		end
		return false
	end

	return self
end