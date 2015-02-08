-- Movement Collision --



function Body_Collision( self, body )
	Event(self)

	local function constructor()
		self:setName('Body_Collision')
	end

	local function checkCollision( nextx, nexty, otherelement )
		local this = {
			nextpos = { x = nextx, y = nexty },
			hitbox = { width = body:getWidth(), height = body:getHeight() }
		}
		local that = {
			pos = otherelement:getAttribute('Body', 'Pos'),
			hitbox = { width = otherelement:getAttribute( 'Body', 'Width'), height = otherelement:getAttribute( 'Body', 'Height') }
		}
		if otherelement:getId() == 'camera' then
			print('camera false collision')
			return false
		end
		
		if this.nextpos.x - this.hitbox.width/2 > that.pos.x + that.hitbox.width/2 or
			this.nextpos.x + this.hitbox.width/2 < that.pos.x - that.hitbox.width/2 or
			this.nextpos.y - this.hitbox.height/2 > that.pos.y + that.hitbox.height/2 or
			this.nextpos.y + this.hitbox.height/2 < that.pos.y - that.hitbox.height/2 then
			return false
		else
			return true
		end
	end

	function self:update( element, nextx, nexty )
		local comparelist = elements:getElementList()
		for _,otherelement in pairs(comparelist) do

			if element:getId() ~= otherelement:getId() and otherelement:getProperty('Body') then
				print(element:getId(), otherelement:getId())
				if checkCollision( nextx, nexty, otherelement ) then
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