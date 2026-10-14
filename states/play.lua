local PLAY = {}

function PLAY:enter()
	self.player = {
		obj = Fy6:newRect("Player", Ww / 2, Wh / 2, 40, 60, "static"),
		speed = 70,
	}
	require("states.idk.play_terraingen")(self)
	Fy6:setScreenBorder()
end

function PLAY:update(dt)
	self.gridSpawn.y = love.keyboard.isDown("up") and self.gridSpawn.y - 30 * dt or self.gridSpawn.y
	self.gridSpawn.y = love.keyboard.isDown("down") and self.gridSpawn.y + 30 * dt or self.gridSpawn.y
	self.gridSpawn.x = love.keyboard.isDown("left") and self.gridSpawn.x - 30 * dt or self.gridSpawn.x
	self.gridSpawn.x = love.keyboard.isDown("right") and self.gridSpawn.x + 30 * dt or self.gridSpawn.x
end

function PLAY:keypressed(key) end

function PLAY:draw()
	for y = 1, #self.grid do
		for x = 1, #self.grid[1] do
			if self.grid[y][x] == 1 then
				love.graphics.setColor(Pal.maroon)
			elseif self.grid[y][x] == 2 then
				love.graphics.setColor(Pal.yellow)
			elseif self.grid[y][x] == 3 then
				love.graphics.setColor(Pal.blue)
			else
				love.graphics.setColor(0, 0, 0, 0)
			end
			love.graphics.rectangle(
				"fill",
				self.gridRenderSize * (x - self.gridSpawn.x) + Ww / 2 + 0.5,
				self.gridRenderSize * (y - self.gridSpawn.y) + Wh / 2 + 0.5,
				self.gridRenderSize - 1,
				self.gridRenderSize - 1,
				4
			)
		end
	end
end

return PLAY
