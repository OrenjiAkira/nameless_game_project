-- main.lua --

require "ui_image_chara"

local dtotal = 0
local fps = 60

tick = 0

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(64,64,64)
	if (quadgrid) then
		print('woops')
	end
	player = ui_image_chara( {}, 'squall', 1, 1 );
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
	player:draw()
end

function love.keypressed( key )
	if key == "escape" then
		love.event.quit()
	end
end