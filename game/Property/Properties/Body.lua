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
		local this_element = element
		local this_element_pos = Vector2D()
		local this_element_box = { w = width, h = height }

		if axis == "x" then
			this_element_pos.x = next_coordinate
			this_element_pos.y = pos.y
		elseif axis == "y" then
			this_element_pos.x = pos.x
			this_element_pos.y = next_coordinate
		else
			this_element_pos = pos
		end

		for _,that_element in ipairs(elementlist) do
			local that_element_pos = that_element:getAttribute("Body", "Pos")
			local that_element_box = { w = that_element:getAttribute("Body", "Width"), h = that_element:getAttribute("Body", "Height") }
			if that_element ~= this_element then
				if that_element_pos.x - that_element_box.w/2 <= this_element_pos.x + this_element_box.w/2 or
				that_element_pos.x + that_element_box.w/2 >= this_element_pos.x - this_element_box.w/2 or
				that_element_pos.y - that_element_box.h/2 <= this_element_pos.y + this_element_box.h/2 or
				that_element_pos.y + that_element_box.h/2 >= this_element_pos.y - this_element_box.h/2 then

					trigger("collision", {this_element, that_element}) --whether or not they do sth with it, they are colliding

					if that_element:getAttribute("Body", "Collidable") then
						collision = true
					end
				end
			end
		end

		if collidable then
			collision = false
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