-- Main --


require '_libs/Vector'

require 'Input'
require 'Input_Manager'


-- main only variables and tables
local dtotal = 0
local fps = 1/30
local tick = 0

-- global values
unit = 16
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)
	inputmgr = Input_Manager( {} )

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here
		tick = tick + 1
		print("################## " .. tick .. " ##################")

		inputmgr:update()
	end
end

function love.draw()
	love.graphics.scale(zoom)
end

function trigger( action_name, parameters )
	print("trigger: ".. action_name)
	if parameters then
		print(unpack(parameters))
		if action_name == "interaction" and parameters.batsu then
			love.event.quit()
		end
	end
end