-- Movement Animation --

function movement_animation( self, move, element )
	action(self)

	local sprite = element:getProperty('Sprite')
	self:setName("Movement_Animation")

	-- set the state of movement animation
	function self:happen()
		if move then
			if move.l then
				sprite:setState('walk','left')
			elseif move.r then
				sprite:setState('walk','right')
			else
				sprite:setState('walk')
			end
		else
			sprite:setState('still')
		end
	end
	
	return self
end