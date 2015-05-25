

-- main --


require '_libs/Vector'

require 'Classes/theElement'
require 'Classes/theDomain'

require 'Classes/Domains/theInput'
require 'Classes/Domains/theHeroes'
require 'Classes/Domains/theSprites'

unit = 16
zoom = 2

-- main only variables and tables
local dtotal = 0
local tick = 0
local fps = 1/30

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)

	-- read database
	database = require 'db'

	-- set up the engine
	domains = {}
	domains.inputdomain = theInput()
	domains.heroesdomain = theHeroes()
	domains.spritesdomain = theSprites()

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
		if parameters.maru then
			print("Hey!")
		end
		if parameters.batsu then
			print("Boo!")
			love.event.quit()
		end
	end
	if action_name == "movement" and parameters then
		print("up:", parameters.u)
		print("right:",parameters.r)
		print("down:", parameters.d)
		print("left:",parameters.l)
	end
	if action_name == "idle" and parameters then
		print('Idle for '..parameters..' seconds.')
	end
end