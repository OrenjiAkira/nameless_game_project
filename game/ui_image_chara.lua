-- user interface > image > character

require 'ui_image'

function ui_image_chara( self, file, xquads, yquads )

	-- class construction
	ui_image( self, file )
	local sprite = self:getSprite()
	local width = self:getWidth()
	local height = self:getHeight()
	local quadwidth = self:getQuadWidth(xquads)
	local quadheight = self:getQuadHeight(yquads)
	local quadgrid = {}
	local updateframes = 12
	local tick = 0
	local row = 3
	local col = 1
	
	for i = 1, yquads do
		quadgrid[i] = {}
		for j = 1, xquads do
			local quad = love.graphics.newQuad ( (j-1)*quadwidth, (i-1)*quadheight, quadwidth, quadheight, width, height)
			quadgrid[i][j] = quad
		end
	end

	function self:update()
		tick = tick + 1
		if tick >= updateframes then
			tick = 0
			col = (col % xquads) + 1
		end
	end

	function self:draw()
		love.graphics.draw(sprite, quadgrid[row][col], window:getWidth()/2, window:getHeight()/2, 0, 1, 1, quadwidth/2, quadheight-8)
	end

	return self
end