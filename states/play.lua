local PLAY = {}

function PLAY:enter()
	self.player = {
		obj = Fy6:newRect("Player", Ww / 2, Wh / 2, 40, 60, "static"),
		speed = 70,
	}
	--self.seed = 1
	self.seed = math.random(99999)
	self.gridRenderSize = 20
	self.gridSize = 256
	self.gridSpawn = { x = 1, y = self.gridSize / 2 }
	self.grid = {}
	for y = 1, self.gridSize do
		self.grid[y] = {}
		for x = 1, self.gridSize do
			self.grid[y][x] = 0
			-- First layer (Layout terrain)
			local first = {
				baseline = 64,
				mainTerrain = 1 / 200,
				mainTerrainStrength = 40,
				hills = 1 / 40,
				hillsStrength = 5,
			}
			if
				love.math.noise(x * first.mainTerrain, self.seed) * first.mainTerrainStrength
					+ love.math.noise(x * first.hills, self.seed) * first.hillsStrength
					+ first.baseline
				<= y
			then
				self.grid[y][x] = 1
			end
			-- Second layer (Rings and holes)
			local second = {
				strength = 1 / 20,
				min = 0.55,
				max = 0.7,
			}
			if
				love.math.noise(x * second.strength, y * second.strength, self.seed) > second.min
				and love.math.noise(x * second.strength, y * second.strength, self.seed) < second.max
			then
				self.grid[y][x] = 0
			end
		end
	end
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
	love.graphics.setColor(Pal.maroon)
	for y = 1, #self.grid do
		for x = 1, #self.grid[1] do
			if self.grid[y][x] == 1 then
				love.graphics.rectangle(
					self.grid[y][x] == 1 and "fill" or "line",
					self.gridRenderSize * (x - self.gridSpawn.x) + Ww / 2 + 0.5,
					self.gridRenderSize * (y - self.gridSpawn.y) + Wh / 2 + 0.5,
					self.gridRenderSize - 1,
					self.gridRenderSize - 1,
					4
				)
			end
		end
	end
end

return PLAY
