function love.load()
	Btnui = require("btnui"):new()
	Ww, Wh = love.graphics.getDimensions()
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
		Circles[i].lifetime = math.random() * 15 + 45
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

function love.mousepressed(x, y, button, istouch, presses) end

function love.draw()
	love.graphics.print("Hello World")

	for _, circles in pairs(Circles) do
		love.graphics.setColor(circles.red, circles.green, circles.blue, circles.lifetime / 60)
		love.graphics.circle("fill", circles.x, circles.y, circles.radius)
		love.graphics.setColor(1, 1, 1, 1)
	end

	--Btnui:draw()
end
