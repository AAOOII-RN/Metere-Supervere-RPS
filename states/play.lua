local PLAY = {}

function PLAY:enter()
	self.player = {
		x = Ww / 2,
		y = Wh / 2,
		speed = 300,
	}
	self.grass = {}
	for i = 1, 30 do
		self.grass[i] = {}
		self.grass[i].x = math.random() * Ww
		self.grass[i].y = math.random() * Wh
	end
end

function PLAY:update(dt)
	if love.keyboard.isDown("up") then
		self.player.y = self.player.y - self.player.speed * dt
	elseif love.keyboard.isDown("down") then
		self.player.y = self.player.y + self.player.speed * dt
	end
	if love.keyboard.isDown("left") then
		self.player.x = self.player.x - self.player.speed * dt
	elseif love.keyboard.isDown("right") then
		self.player.x = self.player.x + self.player.speed * dt
	end
end

function PLAY:keypressed(key) end

function PLAY:draw()
	love.graphics.setColor(Pal.green)
	for _, obj in pairs(self.grass) do
		love.graphics.draw(Img.grass.img, obj.x, obj.y, 0, 50 / Img.grass.img:getWidth())
	end
	love.graphics.setColor(Pal.maroon)
  love.graphics.circle("fill", self.player.x, self.player.y, 20)
end

return PLAY
