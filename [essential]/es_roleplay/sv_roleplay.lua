local tags = uSettings.chatTags

-- Settings for EssentialMode
TriggerEvent("es:setDefaultSettings", {
	pvpEnabled = uSettings.pvpEnabled,
	debugInformation = false,
	startingCash = uSettings.startingMoney + 0.0,
	enableRankDecorators = true
})

function startswith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- Default commands
TriggerEvent('es:addCommand', 'help', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "Commands: ^2/job^0, ^2/jc^0, ^2/cuff^0, ^2/jail^0, ^2/911")
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "Commands: ^2/unseat^0, ^2/checkplate^0, ^2/ooc^0, ^2/me")
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "Commands: ^2/ts3^0, ^2/id")
end)

-- Default commands
TriggerEvent('es:addCommand', 'ts3', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "IP: ^3^*ts3.kanersps.pw")
end)

-- Default commands
TriggerEvent('es:addAdminCommand', 'delveh', 3, function(source, args, user)
	TriggerClientEvent("es_roleplay:deleteVehicle", source)
end, function(source, args, user)

end)

-- Default commands
TriggerEvent('es:addCommand', 'pay', function(source, args, user)
	local amount = args[2]

	if(#args < 2 or #args > 3)then
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Usage: ^2/pay ^*(userid) (amount)")
		return
	end

	if(source == tonumber(args[2]))then
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You cannot give money to yourself.")
		return
	end

	if(tonumber(args[3]) > 0 and tonumber(args[3]) <= user.money)then
		TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)

			if(target)then
				if(get3DDistance(user.coords.x, user.coords.y, user.coords.z, target.coords.x, target.coords.y, target.coords.z) < 3.0) then
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Paid ^2^*" .. GetPlayerName(args[2]) .. "^r: ^3^*" .. args[3])
					TriggerClientEvent('chatMessage', tonumber(args[2]), "SYSTEM", {255, 0, 0}, "Received ^3^*" .. args[3] .. "^r^0 from ^2^*" .. GetPlayerName(source))
					
					user:removeMoney(tonumber(args[3]))
					target:addMoney(tonumber(args[3]))
				else
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Please get closer to the player.")
				end
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player does not exist.")
			end
		end)
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You either don't have the money or tried an amount lower then one.")
	end
end)

-- Default commands
TriggerEvent('es:addCommand', 'ts', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "IP: ^1ts3.kanersps.pw")
end)

-- 911
TriggerEvent('es:addCommand', '911', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords
		table.remove(args, 1)
		local message = table.concat(args, " ")
		TriggerClientEvent('chatMessage', source, "911", {255, 255, 0}, "" .. message)
		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(player_jobs[target['identifier']])then
						if(player_jobs[target['identifier']].job == "police" or player_jobs[target['identifier']].job == "ems" or player_jobs[target['identifier']].job == "fireman")then

							TriggerClientEvent('chatMessage', id, "911", {255, 255, 0}, "" .. message)
						end
					end
				end)
			end
		end
	end)
	end)
end)

-- ME
TriggerEvent('es:addCommand', 'me', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6* " .. GetPlayerName(source) .. " (^0"..source.."^6) " .. message)
					end
				end)
			end
		end
	end)
	end)
end)

-- ME
TriggerEvent('es:addCommand', 'id', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					TriggerEvent("es_roleplay:getPlayerJob", user.identifier, function(job)
						local dJob = "None"
						if(job)then
							dJob = job.job .. " ^0^r(^2^*" .. job.id .. "^0^r)"
						end

						if(range < 10.0)then
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^2^*" .. GetPlayerName(source) .. "'s ID")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Name: ^2^*" .. GetPlayerName(source) .. "")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Job: ^2^*" .. dJob)
						end

					end)
				end)
			end
		end
	end)
	end)
end)

-- DO
TriggerEvent('es:addCommand', 'do', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6* " .. message .. " " .. GetPlayerName(source) .. " (^0"..source.."^6) ")
					end
				end)
			end
		end
	end)
	end)
end)

-- OOC
TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
	table.remove(args, 1)
	local message = table.concat(args, " ")

	local tag = ""
	for k,v in ipairs(tags)do
		if(user.permission_level >= v.rank)then
			tag = v.tag
		end
	end

	TriggerClientEvent('chatMessage', -1, "OOC", {100, 100, 100}, tag .. "^4^* " .. GetPlayerName(source) .. " ^4^r(^0"..source.."^4): ^r^0" .. message)
end)

AddEventHandler('chatMessage', function(source, n, message)
	if(not startswith(message, "/"))then
		CancelEvent()
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local pos = user.coords

			TriggerEvent('es:getPlayers', function(players)
			for id,_ in pairs(players) do
				if(GetPlayerName(id))then
					TriggerEvent('es:getPlayerFromId', id, function(target)
						if(target)then
							local pPos = target.coords

							if(user.coords and target.coords)then
								local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

								local tag = ""
								for k,v in ipairs(tags)do
									if(user.permission_level >= v.rank)then
										tag = v.tag
									end
								end

								if(range < 30.0)then
									TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, tag .. "^4^* " .. GetPlayerName(source) .. " ^4^r(^0"..source.."^4): ^r^0" .. message)
								end
							end
						end
					end)

				end
			end
			end)
		end)
	end
end)

AddEventHandler('es:invalidCommandHandler', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1^*Unknown command^r^0, type ^2/help^0 for a list.")
	CancelEvent()
end)