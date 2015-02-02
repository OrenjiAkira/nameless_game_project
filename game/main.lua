-- Main --

require 'Element/Element'
require 'Property/Property'
require 'Property/Properties/Input'
require 'Property/Properties/Movement'
require 'Property/Properties/Position'
require 'Property/Properties/Sprite'
require 'Property/Properties/Camera'

local dtotal = 0
local fps = 1/30

elements = {}
unit = 16
camera = {}
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(200, 200, 200)

	camera = addElement(
		'camera',
		true,
		false,
		true,
		true
	)
	camera:addProperty( Camera({}, camera ) )
	local player = addElement(
		'player',
		true,
		{ name = 'avatar', qx = 4, qy = 4 },
		true,
		true
	)
	local jeff = addElement(
		'jeff',
		true,
		{ name='jeff', qx=1, qy=1 }
	)

	camera:getProperty('Position'):setPos( 48, 32 )
	player:getProperty('Position'):setPos( 48, 32 )
	jeff:getProperty('Position'):setPos( 24, 32 )

	elements[jeff:getId()] = jeff
	elements[player:getId()] = player
	elements[camera:getId()] = camera

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps
		-- do things here
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
	for _,element in pairs(elements) do
		if element:getProperty('Camera') then
			element:getProperty('Camera'):render()
		end
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

function addElement( name, pos, sprite, movement, input )
	local element = Element({}, name)
	if pos then element:addProperty( Position ( {}, element ) ) end
	if sprite then element:addProperty( Sprite ( {}, element, sprite.name, sprite.qx, sprite.qy, sprite.row ) ) end
	if movement then element:addProperty( Movement ( {}, element ) ) end
	if input then element:addProperty( Input ( {}, element ) ) end
	return element
end
