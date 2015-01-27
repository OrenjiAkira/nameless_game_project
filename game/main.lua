-- main.lua --




dtotal = 0
fps = 60



function love.load()
	-- body
end

function love.update( dt )
	local framerate = 1/fps
	dtotal = dtotal + dt
	while dtotal >= ( framerate ) do
		dtotal = dtotal - framerate
		-- do things here
		
	end
end

function love.draw()
	-- body
end