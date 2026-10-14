local function terrain_gen(self)
	--self.seed = 1
	self.seed = math.random(99999)
	self.gridRenderSize = 2
	--self.gridRenderSize = 20
	self.gridSize = 256
	self.gridSpawn = { x = 1, y = self.gridSize / 2 }
	self.grid = {}

	-- First + Second (Layout terrain + Rings and holes)
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

			-- Third (Yellow ore chunks)
			local third = {
				baseline = 96,
				mainTerrain = 1 / 15,
				mainTerrainStrength = 150,
				strength = 1 / 15,
			}
			if
				love.math.noise(x * third.mainTerrain, self.seed) * third.mainTerrainStrength + third.baseline <= y
				and love.math.noise(x * third.strength, y * third.strength, self.seed) > 0.6
				and self.grid[y][x] == 1
			then
				self.grid[y][x] = 2
			end

			-- Fourth (Blue ore chunks)
			local fourth = {
				baseline = 128,
				mainTerrain = 1 / 25,
				mainTerrainStrength = 150,
				strength = 1 / 15,
			}
			if
				love.math.noise(x * fourth.mainTerrain, self.seed) * fourth.mainTerrainStrength
						+ fourth.baseline
					<= y
				and love.math.noise(x * fourth.strength, y * fourth.strength, self.seed) > 0.65
				and self.grid[y][x] == 1
			then
				self.grid[y][x] = 3
			end
		end
	end
end

-- TO-DO: WE MAKING ROCK PAPER SCISSOR ORES REMEMBER?

return terrain_gen
