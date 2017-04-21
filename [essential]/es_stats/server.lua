local sessionPlayTime = {}
local shotsFired = {}
local kmDriven = {}

-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("127.0.0.1", "gta5_script_stats", "root", "1202")

function addMinutes()
	SetTimeout(60000, function()
		TriggerEvent("es:getPlayers", function(users)
			for k,v in pairs(users)do
				sessionPlayTime[k] = sessionPlayTime[k] + 1
			end

			TriggerClientEvent("es_stats:sendStats", -1, "time", sessionPlayTime)

			addMinutes()
		end)
	end)
end

addMinutes()

AddEventHandler("es:playerLoaded", function(source, user)
	local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = user.identifier})
	local result = MySQL:getResults(executed_query, {'playtime', 'shotsfired', 'kmdriven'}, "identifier")

	if(result[1])then
		sessionPlayTime[source] = result[1].playtime
		shotsFired[source] = result[1].shotsfired
		kmDriven[source] = result[1].kmdriven
	else
		MySQL:executeQuery("INSERT INTO users (`identifier`, `playtime`, `shotsfired`, `kmdriven`) VALUES ('@username', '0', '0', '0')",
		{['@username'] = user.identifier})
	end
end)

AddEventHandler("onResourceStart", function(rs)
	if(rs == "es_stats")then
		TriggerEvent("es:getPlayers", function(users)
			for k,user in pairs(users)do
				local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = user.identifier})
				local result = MySQL:getResults(executed_query, {'playtime', 'shotsfired', 'kmdriven'}, "identifier")

				if(result[1])then
					sessionPlayTime[k] = result[1].playtime
					shotsFired[k] = result[1].shotsfired
					kmDriven[k] = result[1].kmdriven
				else
					MySQL:executeQuery("INSERT INTO users (`identifier`, `playtime`, `shotsfired`, `kmdriven`) VALUES ('@username', '0', '0', '0')",
					{['@username'] = user.identifier})

					sessionPlayTime[k] = 0
					shotsFired[k] = 0
				end
			end
		end)
	end
end)

AddEventHandler("playerDropped", function(user)
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		local identifier = identifiers[i]

		MySQL:executeQuery("UPDATE users SET `playtime`='@value',`shotsfired`='@veasd',`kmdriven`='@dasdasd' WHERE identifier = '@identifier'",
		{['@value'] = sessionPlayTime[source], ['@veasd'] = shotsFired[source], ['@dasdasd'] = kmDriven[source], ['@identifier'] = identifier})
	end
end)

RegisterServerEvent("es_stats:shotsFired")
AddEventHandler("es_stats:shotsFired", function(shots)
	local shots = shotsFired[source] + shots
	shotsFired[source] = shots
end)

RegisterServerEvent("es_stats:kmDriven")
AddEventHandler("es_stats:kmDriven", function(km)
	local kmD = kmDriven[source] + km
	kmDriven[source] = kmD
end)

-- Saving
function saveUsers()
	SetTimeout(240000, function()
		TriggerEvent("es:getPlayers", function(users)
			for k,user in pairs(users)do
				MySQL:executeQuery("UPDATE users SET `playtime`='@value',`shotsfired`='@veasd',`kmdriven`='@dasdasd' WHERE identifier = '@identifier'",
				{['@value'] = sessionPlayTime[k], ['@veasd'] = shotsFired[k], ['@dasdasd'] = kmDriven[k], ['@identifier'] = user.identifier})
			end
		end)

		saveUsers()
	end)
end
saveUsers()