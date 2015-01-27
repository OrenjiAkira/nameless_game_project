-- main.lua --

require "ui"


dtotal = 0
fps = 60
tick = 0


function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(64,64,64)
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
	-- render things

end

function love.keypressed( key )
	if key == "escape" then
		love.event.quit()
	end
end