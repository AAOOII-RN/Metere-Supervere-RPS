function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	Ww, Wh = love.graphics.getDimensions()

	-- requires
	Btnui = require("modules.btnui"):new()
	Sm = require("modules.state").new()

	-- State handler
	OnState = "main menu"
	Sm:add("main menu", require("states.main menu"))
	Sm:switch(OnState)

	-- Images
	Background = {
		checkered = {
			img = love.graphics.newImage("assets/img/checkered.png"),
		},
	}
end

function Distance(x1, y1, x2, y2)
	return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

function love.update(dt)
	Sm:update(dt)
end

function love.mousepressed(mx, my, button, istouch, presses)
	Sm:mousepressed(mx, my, button)
end

function love.draw()
	Sm:draw()
	--Btnui:draw()
end
