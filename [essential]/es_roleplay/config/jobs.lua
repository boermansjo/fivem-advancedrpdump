jobs = {
	["police"] = {
		["displayName"] = "Police officer",
		["skin"] = "s_m_y_cop_01",
		["onJoin"] = function(source, user)
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Get your police vehicle at the ^4garage^0 for ^2£2 000")
		end,
		["onLeave"] = function(source, user)
			-- Do code here for when someone leaves this job
		end,
		["onSpawn"] = function(source, user)
			-- Do code here for when someone spawns with this job.
		end,
		["weapons"] = {
			"WEAPON_STUNGUN",
			"WEAPON_PISTOL",
			"WEAPON_CARBINERIFLE"
		},
		["salary"] = 1050
	},
	["ems"] = {
		["displayName"] = "Medic",
		["customJoinMessage"] = "Welcome, you can save people now! To heal them stand next to them and type: ^2^*/heal ID",
		["weapons"] = {},
		["salary"] = 1050
	},
	["fireman"] = {
		["displayName"] = "Fireman",
		["weapons"] = {},
		["salary"] = 1050
	},
	["trucker"] = {
		["displayName"] = "Trucker",
		["weapons"] = {},
		["salary"] = 900
	},
}

-- Groups
groups = {}
groups.police = {["police"] = true, --[[Add more if wanted]]}
groups.ems = {["ems"] = true, --[[Add more if wanted]]}
groups.fire = {["fireman"] = true, --[[Add more if wanted]]}

-- Police data
police = {}
police.arrest_points = {
	{['x'] = 1690.28, ['y'] = 2593.77, ['z'] = 45.45},
	{['x'] = 639.6, ['y'] = 1.3, ['z'] = 82.7},
	{['x'] = -1113.9, ['y'] = -852.5, ['z'] = 13.5},
	{['x'] = -886.0, ['y'] = -2365.6, ['z'] = 13.9},
	{['x'] = 371.1, ['y'] = -1609.0, ['z'] = 29.2},
	{['x'] = 872.2, ['y'] = -1288.8, ['z'] = 28.2},
	{['x'] = 462.1, ['y'] = -989.5, ['z'] = 24.91},
	{['x'] = -446.5, ['y'] = 6013.8, ['z'] = 31.7},
	{['x'] = 1852.9, ['y'] = 3688.1, ['z'] = 34.2}
}