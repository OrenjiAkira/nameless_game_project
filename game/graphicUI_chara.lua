-- user interface > image > character

require 'graphicUI'

function graphicUI_chara( self, file, xquads, yquads )

	-- class construction
	graphicUI( self, file, { x = window:getWidth()/2, y = window:getHeight()/2 } )
	local sprite = self:getSprite()
	local width = self:getWidth()
	local height = self:getHeight()
	local quadwidth = self:getQuadWidth(xquads)
	local quadheight = self:getQuadHeight(yquads)
	local size = self:getSize()
	local pos = self:getPos()

	-- local class values
	local quadgrid = {}
	local row = 4
	local col = 1
	local updateframes = 12
	local tick = 0

	
	for i = 1, yquads do
		quadgrid[i] = {}
		for j = 1, xquads do
			local quad = love.graphics.newQuad ( (j-1)*quadwidth, (i-1)*quadheight, quadwidth, quadheight, width, height)
			quadgrid[i][j] = quad
		end
	end

	function self:animate()
		tick = tick + 1
		if tick >= updateframes then
			tick = 0
			col = (col % xquads) + 1
		end
	end

	function self:draw()
		love.graphics.draw(sprite, quadgrid[row][col], window:getWidth()/2, window:getHeight()/2, 0, size, size, quadwidth/2, quadheight-(8*size))
	end

	return self
end