player_jobs = {}
plugin_data = {}


AddEventHandler("es_roleplay:getPlayerJob", function(user, cb)
	if(cb ~= nil)then
		cb(player_jobs[user])
	end
end)

-- Markers
AddEventHandler("es:reload", function()
	TriggerEvent('es:getPlayers', function(players)
		for i,_ in pairs(players) do
			if(GetPlayerName(i))then
				for k,v in ipairs(prison.arrest)do
					local pos = {['x'] = prison.arrest[k].x, ['y'] = prison.arrest[k].y, ['z'] = prison.arrest[k].z}
					TriggerClientEvent('es_roleplay:createMarker', k, pos, {['r'] = 0, ['g'] = 0, ['b'] = 255})
				end

				TriggerEvent('es:getPlayerFromId', i, function(target)
					TriggerClientEvent('es_roleplay:playerLoaded', i)
				end)
			end
		end
	end)
end)

-- cleanup
AddEventHandler('playerDropped', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if(user)then
			if(player_jobs[user.identifier])then
				if(jobs[player_jobs[source].job].members)then
					jobs[player_jobs[source].job].members[user.identifier] = nil
				end
				player_jobs[user.identifier] = nil
			end
		end
	end)
end)

-- Spawning
AddEventHandler('es_roleplay:weaponSpawningDone', function(source)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if(user)then
			if(player_jobs[user.identifier])then
				if(player_jobs[user.identifier].skin)then
					TriggerClientEvent('es_roleplay:setSkin', source, player_jobs[user.identifier].skin)
				end

				if(player_jobs[user.identifier].weapons)then
					for k,v in pairs(player_jobs[user.identifier].weapons) do
						TriggerClientEvent('es_roleplay:giveWeapon', source, v)
					end
				end
			end
		end
	end)
end)

-- Markers
AddEventHandler("onResourceStart", function(rs)
	if(rs ~= 'es_roleplay')then
		return
	end

	SetTimeout(2000, function()

			for k,v in pairs(prison.arrest)do
				local pos = {['x'] = v.x, ['y'] = v.y, ['z'] = v.z}
				TriggerClientEvent('es_roleplay:createMarker', -1, k, pos.x, pos.y, pos.z, 0, 0, 255)
			end

		end)
end)

-- Payment
function paycheck()
	if(uSettings.salaryInterval ~= -1)then
		SetTimeout(uSettings.salaryInterval * 1000 * 60, function()
			TriggerEvent('es:getPlayers', function(players)
				for i,_ in pairs(players) do
					if(GetPlayerName(i))then
						local salary = uSettings.baseSalary
						TriggerEvent('es:getPlayerFromId', i, function(target)
							if(target)then
								if(player_jobs[target.identifier])then
									if(player_jobs[target.identifier].salary)then
										salary = jobs[player_jobs[target.identifier].job].salary
									end
								end

								target:addMoney(salary)
							end
						end)
					end
				end
			end)

			paycheck()
		end)
	end
end
paycheck()

TriggerEvent('es:addCommand', 'job', function(source, args, user)
	if(#args == 1)then
		local job = player_jobs[user['identifier']]
		if(job == nil)then
			job = "civilian^0, to change job: ^2/job (JOB) (ID)^0, for a list type ^2^*/job list"
		else
			if(jobs[job.job].displayName)then
				job = jobs[job.job].displayName
			else
				job = job.job
			end
		end

		if(player_jobs[user['identifier']])then
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Your current job is: ^2" .. job .. " ^0(^2" .. player_jobs[user['identifier']].id .. "^0)")
		else
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Your current job is: ^2" .. job)
		end
	elseif(#args == 2)then
		if(args[2] == "list")then
			local jobString = ""

			local c = 0
			for k,v in pairs(jobs) do
				c = c + 1
				if(c == 1)then
					jobString = "^*^2" .. k
				else
					jobString = jobString .. "^0^r, ^*^2" .. k
				end
			end

			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Jobs: " .. jobString)
		elseif(args[2] == "leave")then
			if(player_jobs[user.identifier])then
				TriggerClientEvent("es_jobs:setCurrentJob", source, "")
				local dName = player_jobs[user.identifier].job
				if(jobs[player_jobs[user.identifier].job].displayName)then
					dName = jobs[player_jobs[user.identifier].job].displayName
				end
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You left: ^2" .. dName)

				if(jobs[player_jobs[user.identifier].job].onLeave)then
					jobs[player_jobs[user.identifier].job].onLeave(source, user)
				end

				if(jobs[player_jobs[user.identifier].job].skin)then
					TriggerClientEvent('es_admin:kill', source)
					TriggerEvent("es_customization:setToPlayerSkin", source)
				end

				if(not jobs[player_jobs[user.identifier].job].members)then
					jobs[player_jobs[user.identifier].job].members = {}
				end

				for k = 1,#jobs[player_jobs[user.identifier].job].members do
					if(jobs[player_jobs[user.identifier].job].members[k] == user.identifier)then
						table.remove(jobs[player_jobs[user.identifier].job].members, k)
					end
				end
				player_jobs[user.identifier] = nil

				TriggerEvent("es_weaponshop:getOwnedWeapons", source, function(weps)
					if(weps)then
						for k,v in weps do
							TriggerClientEvent('es_roleplay:giveWeapon', source, v)
						end
					end
				end)
			else
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You currently do not have a job.")
			end
		else
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Usage: ^2/job (JOB) (ID)")
		end
	elseif(#args == 3)then
		if(args[2] == "list")then
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Jobs: ^2police^0, ^2ems^0, ^2fireman^0")
		else
			if(jobs[args[2]])then
				if(false)then
					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Job limit reached.")
				else
					if(player_jobs[user.identifier])then
						if(player_jobs[user.identifier].job == args[2])then
							TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You already are the job ^2" .. args[2])
							return
						end

						if(jobs[args[2]].skin)then
							TriggerClientEvent('es_admin:kill', source)
							TriggerEvent("es_customization:setToPlayerSkin", source)
						end
					end

					if not jobs[args[2]].members then
						jobs[args[2]].members = {}
					end

					player_jobs[user.identifier] = {['job'] = args[2], ['id'] = args[3], ['source'] = source}
					jobs[args[2]].members[#jobs[args[2]].members + 1] = user.identifier 
					TriggerClientEvent("es_jobs:setCurrentJob", source, args[2])

					local jobJoined = args[2]
					if(jobs[args[2]].displayName)then
						jobJoined = jobs[args[2]].displayName
					end

					TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Job changed to ^2" .. jobJoined .. "^0 to leave type ^2/job leave")

					if(jobs[args[2]].skin)then
						TriggerClientEvent('es_roleplay:setSkin', source, jobs[args[2]].skin)
					end

					if(jobs[args[2]].weapons)then
						for k,v in pairs(jobs[args[2]].weapons) do
							TriggerClientEvent('es_roleplay:giveWeapon', source, v)
						end
					end

					if jobs[args[2]].onJoin then
						jobs[args[2]].onJoin(source, user)
					end
				end
			else
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Job does not exist, use ^2/job list^0 for a list.")
			end
		end
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Usage: ^2/job (JOB) (ID)")
	end
end)

local job_channel = {
	["police"] = 1,
	["ems"] = 1,
	["fireman"] = 1,
	["trucker"] = 2
}

TriggerEvent('es:addCommand', 'jc', function(source, args, user)
	if(player_jobs[user.identifier])then
		local channel = job_channel[player_jobs[user.identifier].job]
		table.remove(args, 1)
		for k,v in pairs(job_channel) do
			if(v == channel)then
				if not jobs[k].members then
					jobs[k].members = {}
				end

				for e,c in ipairs(jobs[k].members) do
					TriggerClientEvent('chatMessage', player_jobs[c]['source'], "JOB CHAT", {255, 255, 0}, "^2" .. GetPlayerName(source) .. "^0 (^2" .. player_jobs[user.identifier].id .. "^0): " .. table.concat(args, " "))
				end
			end
		end
	else
		TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You're not in a job that has a job chat.")
	end
end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

TriggerEvent('es:addCommand', 'heal', function(source, args, user)
	if(player_jobs[user.identifier] or (user.permission_level > 2))then
		local job = player_jobs[user.identifier]
		if(job == nil)then
			job = player_jobs[user.identifier].job
		end

		if(groups.ems[job] or user.permission_level > 2)then
			local player = tonumber(args[2])
			if(GetPlayerName(player))then
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Player " .. GetPlayerName(player) .. " healed.")
				TriggerClientEvent('chatMessage', player, "JOB", {255, 0, 0}, "You have been healed by ^2" .. GetPlayerName(source) .. "^0.")

				TriggerEvent("es:getPlayerFromId", tonumber(args[2]), function(target)
					if(target.coords and user.coords)then
						if(get3DDistance(target.coords.x, target.coords.y, target.coords.z, user.coords.x, user.coords.y, user.coords.z) < 10.0)then
							TriggerClientEvent('es_roleplay:heal', player)
						end
					end
				end)
			else
				TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "Incorrect player ID.")
			end
		else
			TriggerClientEvent('chatMessage', source, "JOB", {255, 0, 0}, "You need to be EMS.")
		end
	end
end)

-- Chop shop

local chop_shops = {
	{['x'] = 1175.06, ['y'] = 2639.82, ['z'] = 37.75},
	{['x'] = 1008.35, ['y'] = -2519.67, ['z'] = 28.30},
}

local chopTimer = {}

RegisterServerEvent('es_roleplay:sellVehicle')
AddEventHandler('es_roleplay:sellVehicle', function(l)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		for k,v in ipairs(chop_shops)do
			if(get3DDistance(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 10.0)then
				if(chopTimer[source] == nil)then
					chopTimer[source] = os.time() - 1
				end

				if(chopTimer[source] < os.time())then
					chopTimer[source] = os.time() + 900
					local pay = math.random(2000, 10000)

					user:addMoney(pay)
					TriggerClientEvent('es_roleplay:removeVehicle', source, l)
					TriggerClientEvent('chatMessage', source, 'CHOP-SHOP', {255, 0, 0}, 'Vehicle sold for: £^2' .. pay)
				else
					local time = math.ceil((chopTimer[source] - os.time()) / 60) .. " minutes"
					if((chopTimer[source] - os.time()) < 60)then
						time = (chopTimer[source] - os.time()) .. " seconds"
					end
					TriggerClientEvent("chatMessage", source, 'CHOP-SHOP', {255, 0, 0}, "You have to wait another ^2^*" .. time .. " ^r^0to sell another vehicle.")
				end
			end
		end
	end)
end)