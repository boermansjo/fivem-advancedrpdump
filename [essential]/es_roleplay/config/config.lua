uSettings = {}

-- Change this to the salary you want civilians to have.
uSettings.baseSalary = 800

-- At what interval do you want to give salaries, (minutes and type -1 for no salary.)
uSettings.salaryInterval = 2

-- How much money do you want people to start with
uSettings.startingMoney = 5000

-- Do you want pvp enabled
uSettings.pvpEnabled = true

-- Chat tags, please note this requires changing for your own chat resource.
uSettings.chatTags = {
	{rank = 1, tag = "^0[^4^*Mod^0^r]"},
	{rank = 3, tag = "^0[^3^*Admin^0^r]"},
	{rank = 5, tag = "^0[^1^*Head-Admin^0^r]"},
	{rank = 7, tag = "^0[^3^*Dev^0^r]"}
}

-- Gets ran on new player join
uSettings.firstSpawned = function(source)
	TriggerClientEvent('chatMessage', source, 'AREA', {255, 0, 0}, "Welcome ^2^*" .. GetPlayerName(source) .. "^0!")
	TriggerClientEvent('chatMessage', source, 'AREA', {255, 0, 0}, "For the teamspeak server type ^2^*/ts3")
	TriggerClientEvent('chatMessage', source, 'AREA', {255, 0, 0}, "And if you require help ^2^*/help")
	TriggerClientEvent('chatMessage', source, 'AREA', {255, 0, 0}, "Current spawn area is: ^2^*" .. game.currentArea.name)
end

-- Do you want people to lose their job if they die
uSettings.loseJobOnDeath = false

-- Want the chop shops enabled (selling random vehicles)
uSettings.enableChopshops = true

-- Spawn areas, to change a spawn area do: "/changearea AREAKEY"
uSettings.spawnAreas = {
	["sandyshores"] = {
		["name"] = "Sandy Shores",
		["spawns"] = {
			{["x"] = 1692.53, ["y"] = 3772.44, ["z"] = 34.70},
			{["x"] = 1977.34, ["y"] = 3780.29, ["z"] = 32.18},
			{["x"] = 1818.05, ["y"] = 3660.54, ["z"] = 34.27},
			{["x"] = 1528.31, ["y"] = 3772.75, ["z"] = 34.51},
			{["x"] = 1689.96, ["y"] = 3606.10, ["z"] = 35.38},
			{["x"] = 1428.53, ["y"] = 3674.64, ["z"] = 33.97}
		}
	},
	["grapeseed"] = {
		["name"] = "Grapeseed",
		["spawns"] = {
			{["x"] = 1994.48, ["y"] = 4859.18, ["z"] = 43.90},
			{["x"] = 2348.45, ["y"] = 4929.81, ["z"] = 42.28},
			{["x"] = 2148.75, ["y"] = 4950.93, ["z"] = 41.14},
			{["x"] = 1953.43, ["y"] = 4697.63, ["z"] = 41.63},
			{["x"] = 1792.51, ["y"] = 4590.75, ["z"] = 37.68},
			{["x"] = 1673.93, ["y"] = 4885.17, ["z"] = 42.09},
			{["x"] = 2648.67, ["y"] = 4250.26, ["z"] = 44.76},
		}
	},
	["paletobay"] = {
		["name"] = "Paletobay",
		["spawns"] = {
			{["x"] = -270.79, ["y"] = 6395.74, ["z"] = 30.87},
			{["x"] = -141.96, ["y"] = 6341.87, ["z"] = 31.49},
			{["x"] = -270.91, ["y"] = 6186.30, ["z"] = 31.40},
			{["x"] = 165.45, ["y"] = 6624.06, ["z"] = 31.82},
			{["x"] = 33.17, ["y"] = 6595.58, ["z"] = 32.47},
			{["x"] = -93.72, ["y"] = 6333.02, ["z"] = 31.49},
			{["x"] = -156.61, ["y"] = 6452.75, ["z"] = 31.39},
		}
	},
	["davis"] = {
		["name"] = "Davis",
		["spawns"] = {
			{["x"] = 410.65, ["y"] = -1612.26, ["z"] = 29.29},
			{["x"] = 281.51, ["y"] = -1572.42, ["z"] = 30.38},
			{["x"] = 77.73, ["y"] = -1554.05, ["z"] = 29.59},
			{["x"] = 120.29, ["y"] = -1817.01, ["z"] = 26.89},
			{["x"] = 91.01, ["y"] = -1915.00, ["z"] = 20.79},
			{["x"] = -67.07, ["y"] = -1779.43, ["z"] = 28.42},
			{["x"] = 423.58, ["y"] = -1858.58, ["z"] = 27.27},
		}
	},
	["docks"] = {
		["name"] = "Docks",
		["spawns"] = {
			{['x'] = 614.44, ['y'] = -2896.50, ['z'] = 6.04},
			{['x'] = 447.68, ['y'] = -2983.44, ['z'] = 6.01},
			{['x'] = 494.42, ['y'] = -3372.13, ['z'] = 6.06},
			{['x'] = 854.30, ['y'] = -2923.16, ['z'] = 5.90},
			{['x'] = 1216.41, ['y'] = -2923.49, ['z'] = 5.86},
		}
	},
	["lsairport"] = {
		["name"] = "Los Santos Airport",
		["spawns"] = {
			{["x"] = -997.87, ["y"] = -2436.93,  ["z"] = 20.16},
			{["x"] = -1000.55, ["y"] = -2529.76,  ["z"] = 13.83},
			{["x"] = -1069.35, ["y"] = -2627.85,  ["z"] = 13.76},
			{["x"] = -1066.52, ["y"] = -2711.83,  ["z"] = 13.75},
			{["x"] = -999.55, ["y"] = -2752.60,  ["z"] = 13.75},
			{["x"] = -952.03, ["y"] = -2706.48,  ["z"] = 13.82},
			{["x"] = -912.56, ["y"] = -2731.36,  ["z"] = 20.16},
			{["x"] = -887.23, ["y"] = -2634.16,  ["z"] = 13.75},
			{["x"] = -879.70, ["y"] = -2597.31,  ["z"] = 13.82},
			{["x"] = -886.40, ["y"] = -2537.44,  ["z"] = 14.54},
		}
	},
	["vinewoodhills"] = {
		["name"] = "Vinewood Hills",
		["spawns"] = {
			{["x"] = -1236.09, ["y"] = 477.04,  ["z"] = 92.72},
			{["x"] = -1116.94, ["y"] = 772.51,  ["z"] = 162.82},
			{["x"] = -744.03, ["y"] = 813.38,  ["z"] = 213.36},
			{["x"] = -413.08, ["y"] = 1167.83,  ["z"] = 325.85},
			{["x"] = -135.87, ["y"] = 959.74,  ["z"] = 235.70},
			{["x"] = 237.87, ["y"] = 1147.79,  ["z"] = 225.46},
			{["x"] = 702.09, ["y"] = 620.66,  ["z"] = 129.10},
			{["x"] = -222.04, ["y"] =595.30,  ["z"] = 190.60},
			{["x"] = -556.04, ["y"] = 439.90,  ["z"] = 100.16},
			{["x"] = 807.16, ["y"] = 1283.73,  ["z"] = 360.39},
		}
	},
	["downtownvinewood"] = {
		["name"] = "Downtown Vinewood",
		["spawns"] = {
			{["x"] = -746.35, ["y"] = 204.40,  ["z"] = 75.61},
			{["x"] = -234.76, ["y"] = 246.05,  ["z"] = 91.99},
			{["x"] = -54.39, ["y"] = 54.58,  ["z"] = 72.24},
			{["x"] = 224.39, ["y"] = 210.11,  ["z"] = 105.55},
			{["x"] = 532.57, ["y"] = 96.16,  ["z"] = 96.32},
			{["x"] = 297.58, ["y"] = -111.08,  ["z"] = 69.62},
			{["x"] = -209.31, ["y"] = 110.26,  ["z"] = 69.63},
			{["x"] = -531.31, ["y"] = 113.76,  ["z"] = 63.03},
			{["x"] = 853.29, ["y"] = -110.50,  ["z"] = 79.33},
			{["x"] = 1136.80, ["y"] = 364.43,  ["z"] = 91.41},
		}
	}
}

-- Default spawn area
uSettings.defaultArea = uSettings.spawnAreas.sandyshores