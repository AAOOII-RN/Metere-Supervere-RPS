function love.load()
	Btnui = require("btnui"):new()
	Ww, Wh = love.graphics.getDimensions()
	Mother = nil
	Circles = {}
	CirclesCount = 50
	for i = 1, CirclesCount do
		Circles[i] = {}
		local red = math.random()
		local green = math.random()
		local blue = math.random()
		local sum = red + green + blue

		Circles[i].red = red / sum
		Circles[i].green = green / sum
		Circles[i].blue = blue / sum

		Circles[i].radius = math.random() * 40 + 10
		Circles[i].x = math.random() * Ww
		Circles[i].y = math.random() * Wh
		Circles[i].lifetime = 30
		Circles[i].btnId = "Circle-" .. i
		Circles[i].btn = Btnui:newCirc(Circles[i].btnId, Circles[i].x, Circles[i].y, Circles[i].radius, false)
	end
end

function Distance(x1, y1, x2, y2)
	return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

function love.update(dt)
	for i = #Circles, 1, -1 do -- Count backwards for deleting
		local circles = Circles[i]
		if circles then
			circles.lifetime = circles.lifetime - dt
			if circles.lifetime <= 0 then
				if circles.btnId and Btnui.buttons[circles.btnId] then
					Btnui.buttons[circles.btnId] = nil
				end
				circles.btn = nil
				table.remove(Circles, i)
			end
			if circles.lifetime > 0 then
				for j = 1, #Circles do
					local neighbor = Circles[j]
					if
						neighbor
						and i ~= j
						and Distance(circles.x, circles.y, neighbor.x, neighbor.y)
							< circles.radius + neighbor.radius + 5
					then
						-- Seperate from other circles
						circles.x = circles.x + (circles.x - neighbor.x) * dt
						circles.y = circles.y + (circles.y - neighbor.y) * dt

						-- Update btnui
						if circles.btn then
							circles.btn.x = circles.x
							circles.btn.y = circles.y
						end
					end
				end
			end
		end
	end
end

function love.mousepressed(mx, my, button, istouch, presses)
	for i = #Circles, 1, -1 do
		local circles = Circles[i]
		if Btnui:isHovered(circles.btnId, mx, my) and Mother ~= circles then
			if Mother then
				CirclesCount = CirclesCount + 1
				local father = circles
				local child = {}
				local red = (Mother.red + father.red) / 2 * (math.random() * 0.06 + 0.97)
				local green = (Mother.green + father.green) / 2 * (math.random() * 0.06 + 0.97)
				local blue = (Mother.blue + father.blue) / 2 * (math.random() * 0.06 + 0.97)
				local sum = red + green + blue

				child = {}
				child.red = red / sum
				child.green = green / sum
				child.blue = blue / sum

				child.radius = (Mother.radius + father.radius) / 2 * (math.random() * 0.06 + 0.97)
				child.x = (Mother.x + father.x) / 2
				child.y = (Mother.y + father.y) / 2
				child.lifetime = 30
				child.btnId = "Circle-" .. CirclesCount
				child.btn = Btnui:newCirc(child.btnId, child.x, child.y, child.radius, false)
				table.insert(Circles, child)
				Mother = nil
			else
				Mother = circles
			end
		end
	end
end

function love.draw()
	for _, circles in pairs(Circles) do
		love.graphics.setColor(circles.red, circles.green, circles.blue, circles.lifetime / 30)
		love.graphics.circle("fill", circles.x, circles.y, circles.radius)
		if Mother and Mother.btnId == circles.btnId then
			love.graphics.setColor(0, 1, 0, 1)
			love.graphics.circle("line", circles.x, circles.y, circles.radius + 5)
		end
		love.graphics.setColor(1, 1, 1, 1)
	end

	--Btnui:draw()
end
