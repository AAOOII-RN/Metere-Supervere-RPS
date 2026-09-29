local UI = {}

function UI:new()
	local o = {
		canvas = love.graphics.newCanvas(800, 450),
	}
	setmetatable(o, { __index = self })
	love.graphics.setCanvas(o.canvas)
	love.graphics.print("Canvas 0,0")
	love.graphics.setCanvas()

	return o
end

function UI:draw()
	love.graphics.print("Testing from ui-handler")
	love.graphics.draw(
		self.canvas,
		Ww / 2,
		Wh / 2,
		Ticker * 1,
		1,
		1,
		self.canvas:getWidth() / 2,
		self.canvas:getHeight() / 2
	)
end

return UI
