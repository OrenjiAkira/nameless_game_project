-- Movement Collision --



function Body_Collision( self, body )
	Event(self, movement)

	local function constructor()
		self:setName('Body_Collision')
	end

	local function checkCollision( element, nextx, nexty, otherelement )
		local this = {
			nextpos = { x = nextx, y = nexty },
			hitbox = { width = body:getWidth(), height = body:getHeight() }
		}
		local that = {
			pos = otherelement:getPos(),
			hitbox = { width = otherelement:getAttribute( 'Body', 'Width'), height = otherelement:getAttribute( 'Body', 'Height') }
		}
		if element:getId() == 'camera' or otherelement:getId() == 'camera' then
			return false
		end
		
		if this.nextpos.x - this.hitbox.width/2 > that.pos.x + that.hitbox.width/2 or
			this.nextpos.x + this.hitbox.width/2 < that.pos.x - that.hitbox.width/2 or
			this.nextpos.y - this.hitbox.height/2 > that.pos.y + that.hitbox.height/2 or
			this.nextpos.y + this.hitbox.height/2 < that.pos.y - that.hitbox.height/2 then
			return true
		else
			return false
		end
	end

	function self:update( element, nextx, nexty )
		local comparelist = elements:getElementList()
		for _,otherelement in pairs(comparelist) do

			print(element:getId(), otherelement:getId())
			if not element:getId() == otherelement:getId() then
				if checkCollision( element, nextx, nexty, otherelement ) then
					print('collision is true')
					return false
				else
					return true
				end
			end
		end
	end

	constructor()
	return self
end