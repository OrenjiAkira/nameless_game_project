-- Vector Class



function Vector2D( x, y )
	local Vector = {}
	
	Vector.x = x or 0
	Vector.y = y or 0

	function Vector:set( nx, ny )
		Vector.x = nx
		Vector.y = ny
	end

	function Vector:reflect()
		Vector.x = -Vector.x
		Vector.y = -Vector.y
	end

	function Vector:add( nx, ny )
		Vector.x = Vector.x + nx
		Vector.y = Vector.y + ny
	end

	function Vector:addVector( v )
		if v.x and v.y then
			Vector.x = Vector.x + v.x
			Vector.y = Vector.y + v.y
		end
	end

	function Vector:subVector( v )
		if v.x and v.y then
			Vector.x = Vector.x - v.x
			Vector.y = Vector.y - v.y
		end
	end

	function Vector:sub( nx, ny )
		Vector.x = Vector.x - nx
		Vector.y = Vector.y - ny
	end

	function Vector:mult( m )
		Vector.x = Vector.x * m
		Vector.y = Vector.y * m
	end

	function Vector:increase( acceleration )
		-- for modular acceleration, not vectorial
		Vector:norm( acceleration + Vector:mod() )
	end

	function Vector:norm( n )
		local sqrmod = Vector.x * Vector.x + Vector.y * Vector.y
		local sqrn = n*n
		local multiplier

		if sqrmod ~= 0 then
			multiplier =  math.sqrt(sqrn/sqrmod)
			Vector:mult(multiplier)
		else
			error("Error! Cannot normalize vectors with mod = 0.")
		end
	end

	function Vector:mod()
		local sqrmod = Vector.x * Vector.x + Vector.y * Vector.y
		return math.sqrt(sqrmod)
	end

	function Vector:sqrmod()
		local sqrmod = Vector.x * Vector.x + Vector.y * Vector.y
		return sqrmod
	end


	function Vector:angle()
		return math.atan2(Vector.y, Vector.x)
	end

	return Vector
end