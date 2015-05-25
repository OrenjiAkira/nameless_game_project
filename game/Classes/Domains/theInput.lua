

-- the Input --


local self = {}
local frametimer = 0
local timer = 0
theDomain(self)
self:setname("input")
print("Created domain: "..self:getname())

-- Input for directionals
local function getMovement()
	local left = love.keyboard.isDown('left')
	local right = love.keyboard.isDown('right')
	local up = love.keyboard.isDown('up')
	local down = love.keyboard.isDown('down')
	local directional_input = {
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

local function getInteraction()
	local yes = love.keyboard.isDown(' ', 'return', 'z')
	local no = love.keyboard.isDown('escape', 'x', 'backspace')
	local interaction_input = {
		maru = yes,
		batsu = no
	}

	if yes or no then
		return interaction_input
	else
		return false
	end
end

function self:update()
	local moving = getMovement()
	local interacting = getInteraction()
	if not moving and not interacting then
		frametimer = frametimer + 1
		if frametimer == 30 then
			frametimer = 0
			timer = timer + 1
			trigger("idle", timer)
		end
	else
		frametimer = 0
		timer = 0
		if moving then
			trigger("movement", moving)
		end
		if interacting then
			trigger("interaction", interacting)
		end
	end
end

return self
