local UI = {}

function UI:new()
	local o = {
		canvas = love.graphics.newCanvas(800, 450),
	}
	setmetatable(o, { __index = self })
	o.scaling = math.max(Ww / o.canvas:getWidth(), Wh / o.canvas:getHeight())
	love.graphics.setCanvas(o.canvas)
	love.graphics.setCanvas()
	return o
end

function UI:resize(w, h)
	Ww, Wh = w, h
	self.scaling = math.min(Ww / self.canvas:getWidth(), Wh / self.canvas:getHeight())
end

function UI:draw()
	love.graphics.draw(
		self.canvas,
		Ww / 2,
		Wh / 2,
		0,
		self.scaling,
		self.scaling,
		self.canvas:getWidth() / 2,
		self.canvas:getHeight() / 2
	)
end

return UI
