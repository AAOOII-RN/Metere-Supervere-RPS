local MAIN_MENU = {}

function MAIN_MENU:enter() end

function MAIN_MENU:update(dt) end

function MAIN_MENU:draw()
	love.graphics.draw(
		Background["checkered"].img,
		Ww / 2,
		Wh / 2,
		0,
		1,
		1,
		Background["checkered"].img:getWidth() / 2,
		Background["checkered"].img:getHeight() / 2
	)
end

return MAIN_MENU

-- This is so pointless. --
