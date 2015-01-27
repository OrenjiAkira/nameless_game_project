-- user interface > image

--require 'ui'

function ui_image( self, file )

	local sprite = love.graphics.newImage( '/assets/sprites/' .. file .. '.png' )
	local width = sprite:getWidth()
	local height = sprite:getHeight()
	-- horizontally we change the frame of the image
	-- vertically we change the image (i.e. change character direction)

	function self:getSprite()
		return sprite
	end
	function self:getWidth()
		return width
	end
	function self:getHeight()
		return height
	end
	function self:getQuadWidth(xq)
		return width/xq
	end
	function self:getQuadHeight(yq)
		return height/yq
	end

	return self
end

