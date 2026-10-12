local MAIN_MENU = {}

function MAIN_MENU:enter() end

function MAIN_MENU:update(dt) end

function MAIN_MENU:draw()
	love.graphics.setBackgroundColor(Pal.white)
	love.graphics.setColor(Pal.maroon)
	love.graphics.draw(
		Background["checkered"].img,
		Ww / 2 + math.sin(Ticker / 5) * 100,
		Wh / 2 + math.sin(Ticker / 7) * 100,
		math.sin(Ticker / 3) * 10 / 180 * math.pi,
		10,
		10,
		Background["checkered"].img:getWidth() / 2,
		Background["checkered"].img:getHeight() / 2
	)
end

return MAIN_MENU

-- This is so pointless. --
