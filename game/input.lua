-- Input --

function input(self)

	local frametimer = 0
	local timer = 0
	local interaction = false
	local directional_input = {u,r,d,l}
	local interaction_input = {maru, batsu}

	-- Input for directionals
	function self:getMovement()

		local left = love.keyboard.isDown('left')
		local right = love.keyboard.isDown('right')
		local up = love.keyboard.isDown('up')
		local down = love.keyboard.isDown('down')

		directional_input.u = up
		directional_input.d = down
		directional_input.l = left
		directional_input.r = right

		if left and right then
			
			directional_input.l = false
			directional_input.r = false

			if down and not up then
				return directional_input
			elseif up and not down then
				return directional_input
			else
				return false
			end

		elseif up and down then

			directional_input.u = false
			directional_input.d = false

			if left and not right then
				return directional_input
			elseif right and not left then
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

	function self:getInteraction()
		local maru = love.keyboard.isDown(' ', 'return', 'z')
		local batsu = love.keyboard.isDown('escape', 'x')

		interaction_input.maru = maru
		interaction_input.batsu = batsu

		if maru or batsu then
			return interaction_input
		else
			return false
		end
	end

	function self:isIdle()
		if not self:getMovement() and not self:getInteraction() then
			frametimer = frametimer + 1
			if frametimer == 30 then
				frametimer = 0
				timer = timer + 1
				print('Idle for '..timer..' seconds.')
			end
			return true
		else
			frametimer = 0
			timer = 0
			return false
		end
	end

	function self:update()
		self:isIdle()
	end

	return self
end
