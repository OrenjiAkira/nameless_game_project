

-- main --


require '_libs/Vector'

require 'Classes/theElement'
require 'Classes/theDomain'

-- main only variables and tables
local dtotal = 0
local tick = 0
local fps = 1/30

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)
	
	database = require 'db'
	
	domains = {}
	domains.input = require 'Classes/Domains/theInput'
	domains.heroes = require 'Classes/Domains/theHeroes'
	domains.sprites = require 'Classes/Domains/theSprites'
	domains.bodies = require 'Classes/Domains/theBodies'

	unit = 16
	zoom = 2
end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here
		tick = tick + 1
		print("################## " .. tick .. " ##################")

		trigger("update", domains.input)
	end
end

function love.draw()
	love.graphics.scale(zoom)
	trigger("render", domains.bodies)
end

function trigger( action_name, parameters )
	print("trigger: ".. action_name, parameters)
	if action_name == "update" and parameters then
		if parameters.update then parameters:update() end
	end
	if action_name == "render" and parameters then
		if parameters.render then parameters:render() end
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
		print("right:", parameters.r)
		print("down:", parameters.d)
		print("left:", parameters.l)
	end
	if action_name == "idle" and parameters then
		print('Idle for '..parameters..' seconds.')
	end
	if action_name == "rendersprite" and parameters then
		domains.sprites:rendersprite(unpack(parameters))
	end
end