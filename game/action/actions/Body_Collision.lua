-- Movement Collision --



function Body_Collision( self, body, elementlist )
	Event(self)

	local function constructor()
		self:setName('Body_Collision')
	end

	local function checkCollision( next_coordinate, axis, otherelement )
		local this = {
			nextpos = { x, y },
			hitbox = {
				width = body:getWidth()/2,
				height = body:getHeight()/2
			}
		}
		if axis == 'x' then
			this.nextpos.x = next_coordinate
			this.nextpos.y = body:getPos().y
		elseif axis == 'y' then
			this.nextpos.x = body:getPos().x
			this.nextpos.y = next_coordinate
		elseif axis == 'both' then
			this.nextpos = next_coordinate
		end
		local that = {
			pos = otherelement:getAttribute('Body', 'Pos'),
			hitbox = {
				width = otherelement:getAttribute( 'Body', 'Width')/2,
				height = otherelement:getAttribute( 'Body', 'Height')/2
			}
		}
		if this.nextpos.x - this.hitbox.width > that.pos.x + that.hitbox.width or
			this.nextpos.x + this.hitbox.width < that.pos.x - that.hitbox.width or
			this.nextpos.y - this.hitbox.height > that.pos.y + that.hitbox.height or
			this.nextpos.y + this.hitbox.height < that.pos.y - that.hitbox.height then
			-- not colliding
			if not body:getInvertedHitbox() then
				return false
			else
				return true
			end
		else
			-- yes colliding
			if not body:getInvertedHitbox() then
				return true
			else
				return false
			end
		end
	end

	function self:update( element, next_coordinate, axis )
		local comparelist = elementlist:getElementList()
		local returnmessage = {collision=false, uncollidablelements = {}}
		for _,otherelement in ipairs(comparelist) do

			if element:getId() ~= otherelement:getId() and otherelement:getProperty('Body') then
				print(element:getId(), otherelement:getId())
				if otherelement:getAttribute('Body', 'Collidable') == false then
					table.insert(returnmessage.uncollidablelements, otherelement)
				end
				if checkCollision( next_coordinate, axis, otherelement ) and otherelement:getAttribute('Body', 'Collidable') then
					returnmessage.collision = true
				end
			end
		end
		return returnmessage
	end

	constructor()
	return self
end