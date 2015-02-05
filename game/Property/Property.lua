-- Property Class --



function Property( self )

	local name
	local events = {}

	-- public methods
	function self:getName()
		return name
	end
	function self:setName(n) 
		name = n
	end

	-- public event methods
	function self:getEvent(eventname)
		return events[eventname]
	end
	function self:addEvent(event)
		local eventname = event:getName()
		if not events[eventname] then
			events[eventname] = event
		else
			print('Property already has "'..eventname..'" event')
		end
	end
	function self:removeEvent(eventname)
		events[eventname] = nil
	end

	-- public update methods
	function self:update()
		return
	end
	function self:updateEvents()
		for _,event in pairs(events) do
			if event then event:update() end
		end
	end
	function self:render()
		return
	end


	return self
end



