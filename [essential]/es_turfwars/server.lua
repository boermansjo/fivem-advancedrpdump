local turfsOwned = {}
local turfs = {
	SANDY = {
		id = 1,
		income = 700,
	}
}

-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"

-- MySQL:open("IP", "databasname", "user", "password")
MySQL:open("127.0.0.1", "gta5_script_turfs", "root", "1202")

AddEventHandler("es:playerLoaded", function(source, user)
	local executed_query = MySQL:executeQuery("SELECT * FROM turfs WHERE identifier = '@name'", {['@name'] = user.identifier})
	local result = MySQL:getResults(executed_query, {'SANDY'}, "identifier")
	
	if(result[1])then
		turfsOwned[source] = result[1]

		TriggerClientEvent("es_turfwars:loaded", k, turfsOwned[source])
	else
		MySQL:executeQuery("INSERT INTO turfs (`identifier`) VALUES ('@username')",
		{['@username'] = user.identifier})

		turfsOwned[source] = {}
	end
end)

AddEventHandler("onResourceStart", function(rs)
	if(rs == "es_turfwars")then
		TriggerEvent("es:getPlayers", function(users)
			SetTimeout(2000, function()
				for k,user in pairs(users)do
					local executed_query = MySQL:executeQuery("SELECT * FROM turfs WHERE identifier = '@name'", {['@name'] = user.identifier})
					local result = MySQL:getResults(executed_query, {'SANDY'}, "identifier")

					if(result[1])then
						turfsOwned[k] = result[1]

						TriggerClientEvent("es_turfwars:loaded", k, result[1])
					else
						MySQL:executeQuery("INSERT INTO turfs (`identifier`) VALUES ('@username')",
						{['@username'] = user.identifier})

						turfsOwned[k] = {}
					end
				end
			end)
		end)
	end
end)

RegisterServerEvent("es_turfwars:done")
AddEventHandler("es_turfwars:done", function(turf)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		if turfsOwned[source] and turfs[turf] then
			if turfsOwned[source][turf] == 0 then
				MySQL:executeQuery("UPDATE turfs SET @turf='1' WHERE `identifier`='@username'",
				{['@username'] = user.identifier, ['@turf'] = turf})
				turfsOwned[source][turf] = 1
			end
		end
	end)
end)

AddEventHandler("playerDropped", function()
	turfsOwned[source] = nil
end)