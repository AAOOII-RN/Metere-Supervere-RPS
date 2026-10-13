local PLAY = {}

function PLAY:enter()
	self.player = {
		obj = Fy6:newRect("Player", Ww / 2, Wh / 2, 50, 50, "static"),
		speed = 70,
	}
	self.gridSize = 50
	self.grid = {
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 1, 1, 0, 0, 0 },
		{ 0, 0, 1, 0, 1, 1, 0, 0, 0 },
		{ 0, 0, 1, 0, 0, 1, 1, 0, 1 },
		{ 0, 1, 1, 0, 1, 1, 1, 0, 1 },
		{ 1, 1, 1, 0, 1, 1, 1, 1, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	}
	self.gridSpawn = { x = 5, y = 5 }
	Fy6:setScreenBorder()
end

function PLAY:update(dt) end

function PLAY:keypressed(key) end

function PLAY:draw()
	love.graphics.setColor(Pal.maroon)
	for y = 1, #self.grid do
		for x = 1, #self.grid[1] do
			love.graphics.rectangle(
				self.grid[y][x] == 1 and "fill" or "line",
				self.gridSize * (x - self.gridSpawn.x) + Ww / 2,
				self.gridSize * (y - self.gridSpawn.y) + Wh / 2,
				self.gridSize,
				self.gridSize,
				4
			)
		end
	end
end

return PLAY
