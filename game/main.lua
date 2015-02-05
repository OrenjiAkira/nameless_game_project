-- Main --

require 'input'

require 'Element/Element'
require 'Element/ElementList'
require 'Element/Elements/Camera'

require 'Property/Property'
require 'Property/Properties/Sprite'
require 'Property/Properties/Body'
require 'Property/Properties/Translate'

require 'Event/Event'
require 'Event/Events/Sprite_MovementInput'
require 'Event/Events/Body_MovementInput'
require 'Event/Events/Body_Collision'

-- main only variables and tables
local dtotal = 0
local fps = 1/30
local camera = {}

-- global tables
input = input( {} )
elements = ElementList( {} )

-- global values
unit = 16
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)
	
	local player = elements:newElement('player')
	player:setAttribute('Body', 'Pos', 16, 0)
	player:setAttribute('Sprite', 'Offset', 32, 113)

	local jeff = elements:newElement('npc', 'jeff')
	jeff:setAttribute('Body', 'Pos', 8, 0)
	jeff:setAttribute('Sprite', 'Offset', 64, 124)

	camera = elements:newElement('camera')

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here

		input:update()
		camera:update()

		for _,element in pairs( elements:getElementList() ) do
			if element:getProperty('Body') then
				element:getProperty('Body'):update()
			end
			if element:getProperty('Sprite') then
				element:getProperty('Sprite'):update()
			end
		end
	end
end

function love.draw()
	
	-- render things

	camera:render()
	
	for _,element in pairs( elements:getElementList() ) do
		if element:getProperty('Sprite') then
			element:getProperty('Sprite'):render()
		end
	end
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end
