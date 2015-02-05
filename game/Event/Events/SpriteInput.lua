-- Sprite Input --



function SpriteInput( self, sprite )
	Event(self, sprite)

	local function constructor()
		self:setName('SpriteInput')
	end

	-- set the state of movement animation
	local function InputState()
		local move = input:isMoving()

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
	
	function self:update()
		InputState()
	end
	
	constructor()
	return self
end