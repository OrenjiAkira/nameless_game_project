-- Body --



function Body( self, element, elementlist, _pos, _width, _height, _invertedhitbox, _collidable )
	Property(self)

	self:setName('Body')

	local width = _width
	local height = _height
	local pos = _pos or Vector2D()
	local speed = 0
	local acc = 0.5
	local speedlimit = 0.2
	local direction
	local invertedhitbox = _invertedhitbox
	local collidable = _collidable
	local collisionlist = {}
	print(width, height, pos.x, pos.y)

	-- gets width
	function self:getWidth()
		return width
	end
	-- gets height
	function self:getHeight()
		return height
	end
	-- sets width
	function self:setWidth(newwidth)
		width = newwidth
	end
	-- sets height
	function self:setHeight(newheight)
		height = newheight
	end

	-- gets position
	function self:getPos()
		return pos
	end
	-- sets position
	function self:setPos( x, y )
		pos:set( x, y )
	end

	-- gets speed
	function self:getSpeed()
		return speed
	end
	-- sets speed
	function self:setSpeed( newspeed )
		speed = newspeed
	end

	-- gets acceleration
	function self:getAcceleration()
		return acc
	end
	-- sets acceleration
	function self:setAcceleration(newacc)
		acc = newacc
	end

	-- gets speedlimit
	function self:getSpeedLimit()
		return speedlimit
	end
	-- sets speedlimit
	function self:setSpeedLimit(newlimit)
		speedlimit = newlimit
	end

	-- if hitbox is inverted
	function self:getInvertedHitbox()
		return invertedhitbox
	end
	-- set hitbox's inversion
	function self:setInvertedHitbox( invert )
		invertedhitbox = invert
	end

	-- gets collidable
	function self:getCollidable()
		return collidable
	end
	-- sets collidable
	function self:setCollidable( collide )
		collidable = collide
	end

	function self:getCollision(elementname)
		for i,element in ipairs(collisionlist) do
			if element:getId() == elementname then
				return element
			end
		end
	end
	function self:addCollision(element)
		if not self:getCollision(element:getId()) then
			print( element:getId() .. " element was added to collision list")
			table.insert(collisionlist, element)
		else
			print(element:getId() .. " element already in collision")
		end
	end
	function self:removeCollision(elementname)
		for i,element in ipairs(collisionlist) do
			if element:getId() == elementname then
				print( element:getId() .. " element was removed from collision list")
				table.remove(collisionlist, i)
			end
		end
	end

	-- sets direction, local only
	local function setDirection(newdir)
		direction = newdir
	end

	-- public action methods
	function self:move(dir)
		setDirection(dir)
		speed = speed + acc
		if speed > speedlimit then speed = speedlimit end
	end

	function self:stop()
		speed = speed - acc
		if speed < 0 then speed = 0 end
	end

	local function checkCollision( next_coordinate, axis )
		local collision = false
		local this = element
		local this_pos = Vector2D()
		local this_box = { w = width, h = height }

		if axis == "x" then
			this_pos.x = next_coordinate
			this_pos.y = pos.y
		elseif axis == "y" then
			this_pos.x = pos.x
			this_pos.y = next_coordinate
		else
			this_pos = pos
		end

		for _,that in ipairs(elementlist:getElementList()) do
			local that_pos = that:getAttribute("Body", "Pos")
			local that_box = { w = that:getAttribute("Body", "Width"), h = that:getAttribute("Body", "Height") }
			if that ~= this then
				print( this:getId(), that:getId() )
				if not ( this_pos.x - this_box.w/2 > that_pos.x + that_box.w/2 or
				this_pos.x + this_box.w/2 < that_pos.x - that_box.w/2 or
				this_pos.y - this_box.h/2 > that_pos.y + that_box.h/2 or
				this_pos.y + this_box.h/2 < that_pos.y - that_box.h/2 ) then
				
					--trigger("collision", {this, that}) --whether or not they do sth with it, they are colliding
					self:addCollision(that)
					if that:getAttribute("Body", "Collidable") then
						collision = true
						print("that element is collidable")
					end
				else
					self:removeCollision(that:getId())
				end
			end
		end

		if not collidable then
			collision = false
			print("this element isn't collidable")
		end
		return collision
	end

	-- update method
	function self:update()

		if direction and speed > 0 then
			--print(speed.x, speed.y)

			-- current position and future position
			local oldx = pos.x
			local oldy = pos.y
			local newx, newy

			-- displacement
			local dx = speed*math.cos(direction)
			local dy = speed*math.sin(direction)

			local xcol = checkCollision(oldx + dx, "x")
			local ycol = checkCollision(oldy + dy, "y")

			if xcol then
				newx = oldx
			else
				newx = oldx + dx
			end
			if ycol then
				newy = oldy
			else
				newy = oldy + dy 
			end

			self:setPos( newx, newy )
	  end
	end

	return self
end