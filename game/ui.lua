--user interface

ui = {}
function ui.new(file)
	self.sprite = love.graphics.newImage( file )
	local width = sprite:getWidth()
	local height = sprite:getHeight()

	return self
end