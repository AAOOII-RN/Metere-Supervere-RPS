--[[
## name:     Catppuccin-Mocha
## author:   Pocco81 (https://github.com/Pocco81)
## license:  MIT
## upstream: https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf
## blurb:    Soothing pastel theme for the high-spirited!
]]

local rgb = love.math.colorFromBytes
local FCC = {
	rosewater = { rgb(245, 224, 220) },
	flamingo = { rgb(242, 205, 205) },
	pink = { rgb(245, 194, 231) },
	mauve = { rgb(203, 166, 247) },
	red = { rgb(243, 139, 168) },
	maroon = { rgb(235, 160, 172) },
	peach = { rgb(250, 179, 135) },
	yellow = { rgb(249, 226, 175) },
	green = { rgb(166, 227, 161) },
	teal = { rgb(148, 226, 213) },
	sky = { rgb(137, 220, 235) },
	sapphire = { rgb(116, 199, 236) },
	blue = { rgb(137, 180, 250) },
	lavender = { rgb(180, 190, 254) },
	white = { rgb(205, 214, 244) },
	subwhite = { rgb(186, 194, 222) },
	base = { rgb(30, 30, 46) },
}

function fcv(fcc, a)
	local fcc2 = FCC[fcc]
	fcc2[4] = a or 1
	return fcc2
end

function fcvlerp(fcva, fcvb, t)
	local fcv1 = fcv(fcva)
	local fcv2 = fcv(fcvb)
	return {
		fcv1[1] + t * (fcv2[1] - fcv1[1]),
		fcv1[2] + t * (fcv2[2] - fcv1[2]),
		fcv1[3] + t * (fcv2[3] - fcv1[3]),
		fcv1[4] + t * (fcv2[4] - fcv1[4]),
	}
end

return FCC
