-- Main --


require '_libs/Vector'

require 'Input'
require 'Input_Manager'

require 'Element/Element'
require 'Element/Element_Manager'

require 'Property/Property'
require 'Property/Properties/Sprite'
require 'Property/Properties/Body'
require 'Property/Properties/Translate'

require 'Action/Action'
require 'Action/Action_Manager'
require 'Action/Actions/Movement'
require 'Action/Actions/Movement_Animation'

-- main only variables and tables
local dtotal = 0
local fps = 1/30
local camera = {}
local tick = 0

-- global tables
elements = Element_Manager( {} )
hudthings = Element_Manager( {} )

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
	actionmgr = Action_Manager( {} )
	inputmgr = Input_Manager( {} )

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here
		tick = tick + 1
		print("##################")

		inputmgr:update()
		actionmgr:update()

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

function love.keyreleased(key)
	if key == 'backspace' then
		love.event.quit()
	end
end

function trigger( action_name, parameters )
	print("trigger: ".. action_name)
	actionmgr:addAction( action_name, parameters )
end