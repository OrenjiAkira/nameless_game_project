-- Main --

require 'input'

require 'Element/Element'
require 'Element/Elements/Camera'

require 'Property/Property'
require 'Property/Properties/Sprite'
require 'Property/Properties/HitBox'
require 'Property/Properties/Body'
require 'Property/Properties/Translate'

require 'Event/Event'
require 'Event/Events/Sprite_MovementInput'
require 'Event/Events/Body_MovementInput'
require 'Event/Events/Body_Collision'

local dtotal = 0
local fps = 1/30

input = input( {} )
elements = {}
camera = {}

unit = 16
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)
	
	local player = newElement('player')
	local jeff = newElement('npc', 'jeff')
	player:getProperty('Body'):setPos( 48, 32 )
	jeff:getProperty('Body'):setPos( 24, 32 )

	elements[jeff:getId()] = jeff
	elements[player:getId()] = player

	camera = newElement('camera')

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here

		input:update()
		camera:update()

		for _,element in pairs(elements) do
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
	
	for _,element in pairs(elements) do
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

function newElement( type, name )
	local element = Element({}, name or type)

	if type == 'player' then
		
		-- adding properties

		-- create body property
		local body = Body( {}, element )
		-- add body events: MovementInput, Collision, ...
		body:addEvent( Body_MovementInput({}, body) )
		body:addEvent( Body_Collision({}, body) )
		-- add body to element
		element:addProperty( body )

		-- create sprite property
		local sprite = Sprite( {}, element, 'avatar', 4, 4 )
		-- add sprite events: MovementInput, ...
		sprite:addEvent( Sprite_MovementInput({}, sprite) )
		-- add sprite to element
		element:addProperty( sprite )

	end
	if type == 'npc' then

		-- adding properties

		-- create body property
		local body = Body( {}, element )
		-- add body events: Collision, ...
		body:addEvent( Body_Collision({}, body) )
		-- add body to element
		element:addProperty( body )

		-- create sprite property
		local sprite = Sprite ( {}, element, name or type, 1, 1 )
		-- add sprite to element
		element:addProperty( sprite )

	end
	if type == 'camera' then
		element = Camera({}, 'camera')
	end

	return element
end
