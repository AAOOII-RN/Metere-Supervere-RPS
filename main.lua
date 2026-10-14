function love.load()
	math.randomseed(os.time() - 1791982643)
	love.graphics.setDefaultFilter("nearest", "nearest")
	Ww, Wh = love.graphics.getDimensions()
	Ticker = 0

	-- requires
	Pal = require("modules.palette")
	Fy6 = require("modules.fy6"):new(0, 9.81 * 30, 30)
	Btnui = require("modules.btnui"):new()
	Ui = require("modules.ui-handler"):new()
	Sm = require("modules.state").new()

	-- State handler
	OnState = "play"
	Sm:add("main menu", require("states.main menu"))
	Sm:add("play", require("states.play"))
	Sm:switch(OnState)

	-- Images
	Background = {
		checkered = {
			img = love.graphics.newImage("assets/img/checkered.png"),
		},
	}
	Img = {
		grass = {
			img = love.graphics.newImage("assets/img/grass.png"),
		},
	}
	-- sfx
	Sfx = {
		click = {
			audio = love.audio.newSource("assets/audio/typewriter_click.wav", "static"),
		},
	}
end

function Distance(x1, y1, x2, y2)
	return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

function love.update(dt)
	Ticker = Ticker + dt
	Fy6:update(dt)
	Sm:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
	Sm:keypressed(key)
end

function love.resize(w, h)
	Ui:resize(w, h)
end

function love.mousepressed(mx, my, button, istouch, presses)
	Sm:mousepressed(mx, my, button)
end

function love.draw()
	love.graphics.setBackgroundColor(Pal.base)
	Sm:draw()
	Ui:draw()
	Fy6:draw()
	Btnui:draw()
end
