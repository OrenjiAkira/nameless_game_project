-- main.lua --

require 'ui_image_chara'

local dtotal = 0
local fps = 1/60

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(64,64,64)
	if (quadgrid) then
		print('woops')
	end
	player = ui_image_chara( {}, 'avatar', 4, 4 );
end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps
		-- do things here
		player:update()
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