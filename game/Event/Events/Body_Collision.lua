-- Movement Collision --



function Body_Collision( self, body, element )
	Event(self, movement)

	local function constructor()
		self:setName('Body_Collision')
	end

	local function checkCollision( present, future, hitbox )
		local halfwidth = body:getWidth()/2
		local halfheight = body:getHeight()/2
		if present.x-halfwidth < future.x+hitbox.halfwidth then
			print('collinding left!')
			return true
		elseif present.x+halfwidth > future.x-hitbox.halfwidth then
			print('collinding right!')
			return true
		elseif math.max(present.y-halfheight, future.y+hitbox.halfheight) == future.y+hitbox.halfheight then
			print('collinding up!')
			return true
		elseif math.min(present.y+halfheight, future.y-hitbox.halfheight) == future.y-hitbox.halfheight then
			print('collinding down!')
			return true
		end
	end

	function self:update( nextx, nexty )
		local comparelist = elements:getElementList()
		for _,otherelements in pairs(comparelist) do
			if not otherelements == element then
				local hitbox = { halfwidth=element:getWidth(), halfheight = element:getWidth() }
				local currentpos = otherelements:getAttribute('Body, Pos')
				nextpos = { nextx, nexty }
				if checkCollision( currentpos, nextpos, hitbox ) then
					return false
				end
			end
		end
		return true
	end

	constructor()
	return self
end