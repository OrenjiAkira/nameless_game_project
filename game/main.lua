

-- main --


require '_libs/Vector'

require 'theInput'

require 'theDomain'
require 'theElement'


-- main only variables and tables
local dtotal = 0
local tick = 0

-- global values
fps = 1/30
unit = 16
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)
	domains = {}
	domains.inputdomain = theInput()

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here
		tick = tick + 1
		print("################## " .. tick .. " ##################")

		trigger("update", domains.inputdomain)
	end
end

function love.draw()
	love.graphics.scale(zoom)
end

function trigger( action_name, parameters )
	print("trigger: ".. action_name, parameters)
	if action_name == "update" and parameters then
		parameters:update()
	end
	if action_name == "interaction" and parameters then
		print(unpack(parameters))
		if parameters.batsu then
			love.event.quit()
		end
	end
	if action_name == "movement" and parameters then
		print(unpack(parameters))
	end
	if action_name == "idle" and parameters then
		print('Idle for '..parameters..' seconds.')
	end
end