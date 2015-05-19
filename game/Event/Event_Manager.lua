-- Event Manager --

function event_manager( self )

	local eventlist = {}

	function self:addEvent(event)
		table.insert(eventlist, event)
	end

	function self:removeEvent(eventname)
		for index,event in ipairs(eventlist) do
			if event:getName() == eventname then
				table.remove(eventlist, index)
				break
			end
		end
	end

	function self:update()
		for _,event in ipairs(eventlist) do
			event:happen()
			self:removeEvent( event:getName() )
		end
	end

	return self
end