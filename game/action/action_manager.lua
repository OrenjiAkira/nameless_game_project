-- Event Manager --

function action_manager( self )

	local actionlist = {}

	function self:addAction( trigger, parameters )

		local triggeredactions = {}

		if trigger == "movement" then
			table.insert( triggeredactions, movement( {}, unpack(parameters) ) )
			table.insert( triggeredactions, movement_animation( {}, unpack(parameters) ) )
		end

		if trigger == "collision" then
			print( parameters[1]:getId() .. " and " .. parameters[2]:getId()  .. " are colliding.")
		end

		for _,action in ipairs(triggeredactions) do	
			print("action queried!")
			table.insert(actionlist, action)
		end
	end

	function self:removeAction(index)
		table.remove(actionlist, index)
	end

	function self:update()
		for i,action in ipairs(actionlist) do
			print(action:getName())
			action:happen()
			self:removeAction(i)
		end
	end

	return self
end