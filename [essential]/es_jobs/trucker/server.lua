local truckers_jobs = {
	['trucker1'] = {
		["name"] = "liqour ace",
		["start"] = {['x'] = 1372.05, ['y'] = 3619.89, ['z'] = 34.88},
		["end"] = {['x'] = -2586.51, ['y'] = 1930.86, ['z'] = 167.52},
		["payment"] = {[0] = 7050, [1] = 10000},
	},
	['trucker2'] = {
		["name"] = "warehouse",
		["start"] = {['x'] = 744.29, ['y'] =  -966.61, ['z'] = 24.59},
		["end"] = {['x'] = -1556.34, ['y'] = 112.91, ['z'] = 56.77},
		["payment"] = {[0] = 4500, [1] = 6000},
	},
	['trucker3'] = {
		["name"] = "warehouse2",
		["start"] = {['x'] = 689.15, ['y'] = -967.90, ['z'] = 23.47},
		["end"] = {['x'] = -106.58, ['y'] = 834.20, ['z'] = 235.71},
		["payment"] = {[0] = 4500, [1] = 6000},
	}
}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

local trucking = {}
local truckerData = {}
local truckerTimers = {}

-- Default commands
RegisterServerEvent("es_jobs:triggerTrucking")
AddEventHandler('es_jobs:triggerTrucking', function(t)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		TriggerEvent("es_roleplay:getPlayerJob", user.identifier, function(job)
			if(job)then
				if(job.job == 'trucker')then
					if(not trucking[user.identifier])then
						for k,v in pairs(truckers_jobs)do
							if(get3DDistance(v.start.x, v.start.y, v.start.z, user.coords.x, user.coords.y, user.coords.z) < 15.0)then
								TriggerClientEvent('es_jobs:startTruckerJob', source)
								truckerData[user.identifier] = { ['end'] = v['end'], ['pay'] = v['payment'][t], legal = t }
								return
							end
						end
						TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You're not at a pickup location.")
					else
						local pos = trucking[user.identifier]['end']
						if(get3DDistance(pos.x, pos.y, pos.z, user.coords.x, user.coords.y, user.coords.z) < 8.0)then
							TriggerClientEvent('es_jobs:jobTruckerDone', source)
						else
							TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You're not at the dropoff.")
						end
					end
				else
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You need to be a trucker. Type ^2/job trucker UNIT-ID")
				end
			else
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You need to be a trucker. Type ^2/job trucker UNIT-ID")
			end
		end)
	end)
end)

RegisterServerEvent("es_jobs:cancelTrucking")
AddEventHandler("es_jobs:cancelTrucking", function()
	TriggerEvent("es:getPlayerFromId", source, function(user)
		TriggerClientEvent('es_jobs:removeMarkerTrucker', source, "trucker-end")
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Trucking job cancelled.")
		trucking[user.identifier] = nil
	end)
end)

TriggerEvent('es:addAdminCommand', "ttp", 4, function(source, command, user)
	if(trucking[user.identifier])then
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Teleported.")
		local pos = trucking[user.identifier]['end']
		TriggerClientEvent('es_roleplay:teleportPlayerAndVehicle', source, pos.x, pos.y, pos.z)
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You're not on a trucking job.")
	end
end, function(source, command, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You're not an administrator.")
end)

TriggerEvent('es:addAdminCommand', "tstart", 4, function(source, command, user)
	if(truckers_jobs[command[2]])then
		local v = truckers_jobs[command[2]]
		TriggerClientEvent('es_jobs:startTruckerJob', source)
		truckerData[user.identifier] = { ['end'] = v['end'], ['pay'] = v['payment'][tonumber(command[3])] }
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Incorrect job.")
	end
end, function(source, command, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You're not an administrator.")
end)

RegisterServerEvent('es_jobs:jobTruckerDone')
AddEventHandler('es_jobs:jobTruckerDone', function(v)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if(v ~= trucking[user.identifier].vehicle)then
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You seem to be in the incorrect vehicle, to cancel this job return to the starting position.")
			return
		end
		TriggerClientEvent('es_jobs:removeMarkerTrucker', source, "trucker-end", true)
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Job done, you earned: ^2£" .. trucking[user.identifier].pay)
		user:addMoney(trucking[user.identifier].pay)
		trucking[user.identifier] = nil
	end)
end)

RegisterServerEvent('es_jobs:startTruckerJob')
AddEventHandler('es_jobs:startTruckerJob', function(v, m)
	if(m ~= 'MULE')then
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You're not using a mule.")
		return
	else
		TriggerEvent('es:getPlayerFromId', source, function(user)
			if(truckerData[user.identifier])then
				trucking[user.identifier] = {
					['end'] = truckerData[user.identifier]['end'],
					['pay'] = truckerData[user.identifier].pay,
					['vehicle'] = v
				}
				
				TriggerClientEvent('es_jobs:createMarkerTrucker', source, "trucker-end", trucking[user.identifier]['end'].x, trucking[user.identifier]['end'].y, trucking[user.identifier]['end'].z, truckerData[user.identifier].legal)

				truckerData[user.identifier] = nil
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Job started, drive to coordinates.")
			end
		end)
	end
end)

TriggerEvent("es:addCommand", "search", function(source, args, user)
	TriggerEvent("es_roleplay:getPlayerJob", user.identifier, function(job)
		if(job)then
			if(job.job == "police")then
				TriggerClientEvent()
				return
			end
		end
	end)
end)