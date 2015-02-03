-- Main --

require 'Element/Element'
require 'Element/Camera'
require 'Property/Property'
require 'Property/Properties/Input'
require 'Property/Properties/Movement'
require 'Property/Properties/Position'
require 'Property/Properties/Sprite'
require 'Property/Properties/Translate'

local dtotal = 0
local fps = 1/30

elements = {}
unit = 16
camera = {}
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)

	
	local player = newElement('player')
	local jeff = newElement('npc', 'jeff')
	player:getProperty('Position'):setPos( 48, 32 )
	jeff:getProperty('Position'):setPos( 24, 32 )

	elements[jeff:getId()] = jeff
	elements[player:getId()] = player

	camera = newElement('camera')

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here

		camera:update()

		for _,element in pairs(elements) do
			if element:getProperty('Input') then
				element:getProperty('Input'):update()
			end
			if element:getProperty('Movement') then
				element:getProperty('Movement'):update()
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
		element:addProperty( Position ( {}, element ) )
		element:addProperty( Sprite ( {}, element, 'avatar', 4, 4 ) )
		element:addProperty( Movement ( {}, element ) )
		element:addProperty( Input ( {}, element ) )
	end
	if type == 'npc' then
		element:addProperty( Position ( {}, element ) )
		element:addProperty( Sprite ( {}, element, name or type, 1, 1 ) )
		element:addProperty( Movement ( {}, element ) )
	end
	if type == 'camera' then
		element = Camera({}, 'camera')
	end

	return element
end
