-- Main --


require 'libs/Vector'

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
hudthings = ElementList( {} )

-- global values
unit = 16
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)
	
	local player = elements:newElement('player', 'player', 16, 8, 3, 1)
	player:setAttribute('Sprite', 'Offset', 32, 113)

	local jeff = elements:newElement('npc', 'jeff', 8, 0, 3, 1)
	jeff:setAttribute('Sprite', 'Offset', 64, 124)

	camera = hudthings:newElement('camera')

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here

		input:update()

		hudthings:update()
		elements:update()
		
	end
end

function love.draw()
	love.graphics.scale(zoom)
	hudthings:render()
	
	-- draw hitbox
	local elementlist = elements:getElementList()	
	for _,element in ipairs(elementlist) do
		--if element:getProperty('Sprite') then

			local bodypos = element:getAttribute('Body', 'Pos')
			local bodysize = { width = element:getAttribute('Body', 'Width'), height = element:getAttribute('Body', 'Height') }
			love.graphics.setColor(255,255,255,100)
			love.graphics.rectangle(
				'fill',
				bodypos.x*unit-bodysize.width*unit/2,
				bodypos.y*unit-bodysize.height*unit/2,
				bodysize.width*unit,
				bodysize.height*unit
			)
		--end
	end
	
	-- render things
	elements:render()

end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end
