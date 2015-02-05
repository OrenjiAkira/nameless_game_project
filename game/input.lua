-- Input --



function input(self)

	-- Input for directionals
	function self:isMoving()

		local left = love.keyboard.isDown('left')
		local right = love.keyboard.isDown('right')
		local up = love.keyboard.isDown('up')
		local down = love.keyboard.isDown('down')

		directional_input = {
			u = up,
			r = right,
			d = down,
			l = left
		}

		if left and right then
			
			directional_input.l = false
			directional_input.r = false

			if down and not up then
				return directional_input
			elseif not down and up then
				return directional_input
			else
				return false
			end

		elseif up and down then

			directional_input.u = false
			directional_input.d = false

			if left and not right then
				return directional_input
			elseif not left and right then
				return directional_input
			else
				return false
			end

		elseif left or right or up or down then

			return directional_input

		else
			return false
		end
	end

	return self
end