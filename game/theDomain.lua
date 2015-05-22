

-- the Domain --


function theDomain(self)

	local list = {}
	local messages = {}

	-- list managing --
	function self:get(id)
		print("Looking for element of id#" .. id)
		for i,element in ipairs(list) do
			if element:getId() == id then
				print("Element added.")
				return element
			end
		end
		return false
	end
	function self:add(element)
		print("Adding element of id#" .. element:getId())
		table.insert(list, element)
	end
	function self:rem(id)
		print("Looking for element of id#" .. id)
		for i,element in ipairs(list) do
			if element:getId() == id then
				table.remove(list, i)
				print("Element found and removed.")
				return true
			end
		end
		return false
	end

	-- messages managing --
	function self:addMessage(message)
		print("Domain got a message: " .. message)
		table.insert(messages, message)
	end
	function self:readMessage(message)
		for i,m in ipairs(messages) do
			if m == message then
				-- things happen here, but this is just a placeholder method
				print("Message: '" .. message .. "' read")
				table.remove(messages, i)
			end
		end
	end

	return self
end

function theHeroes(self)
	theDomain(self)
end