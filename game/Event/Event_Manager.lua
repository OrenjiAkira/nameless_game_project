-- Event Manager --

function event_manager( self )

	local eventlist = {}

	function self:addEvent(event)
		table.insert(eventlist, event)
	end

	function self:removeEvent(index)
		table.remove(eventlist, index)
	end

	function self:update()
		for i,event in ipairs(eventlist) do
			event:happen()
			self:removeEvent(i)
		end
	end

	return self
end