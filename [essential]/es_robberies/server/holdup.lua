local stores = {
	["sandyshores_twentyfoursever"] = {
		position = { ['x'] = 1960.4197998047, ['y'] = 3742.9755859375, ['z'] = 32.343738555908 },
		reward = 2000,
		prettyName = "Twenty Four Seven. (Sandy Shores)",
		lastRob = 0
	},
	["bar_one"] = {
		position = { ['x'] = 1986.1240234375, ['y'] = 3053.8747558594, ['z'] = 47.215171813965 },
		reward = 2000,
		prettyName = "Yellow Jack. (Sandy Shores)",
		lastRob = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
		reward = 2000,
		prettyName = "Twenty Four Seven. (Little Seoul)",
		lastRob = 0
	}
}

local curRobbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_robberies:walkedOff')
AddEventHandler('es_robberies:walkedOff', function(rob)
	if(curRobbers[source])then
		TriggerClientEvent('es_robberies:robberyStoreCancelled', source)
		curRobbers[source] = nil

		TriggerEvent('es:getPlayers', function(pl)
			for k,v in pairs(pl) do
				TriggerEvent('es_roleplay:getPlayerJob', k, function(job)
					if(job)then
						if(job.job == "police")then
							TriggerClientEvent('chatMessage', k, 'ROBBERY', {255, 0, 0}, "Robbery was cancelled at: ^2" .. stores[rob].prettyName)
						end
					end
				end)
			end
		end)
	end
end)

AddEventHandler("es_roleplay:playerCuffed", function(player, cuffed)
	if(curRobbers[player])then
		if(cuffed)then
			TriggerClientEvent('es_robberies:robberyStoreCancelled', player)

			TriggerEvent('es:getPlayers', function(pl)
				for k,v in pairs(pl) do
					TriggerEvent('es_roleplay:getPlayerJob', k, function(job)
						if(job)then
							if(job.job == "police")then
								TriggerClientEvent('chatMessage', k, 'ROBBERY', {255, 0, 0}, "Robber was put into custody at: ^2" .. stores[curRobbers[player]].prettyName)
							end
						end
					end)
				end
			end)

			curRobbers[player] = nil
		end
	end
end)

RegisterServerEvent('es_robberies:robStore')
AddEventHandler('es_robberies:robStore', function(rob)
	if stores[rob] then
		local store = stores[rob]

		if (os.time() - store.lastRob) < 600 and store.lastRob ~= 0 then
			TriggerClientEvent('chatMessage', source, 'ROBBERY', {255, 0, 0}, "This has already been robbed recently. Please wait another: ^2" .. (1200 - (os.time() - store.lastRob)) .. "^0 seconds.")
			return
		end

		TriggerEvent('es:getPlayerFromId', source, function(user)
			TriggerEvent('es_roleplay:getPlayerJob', source, function(job)
				if(job) then
					TriggerClientEvent('chatMessage', source, 'ROBBERY', {255, 0, 0}, "You cannot rob as a ^2" .. job.job)
				else
					if get3DDistance(user.coords.x, user.coords.y, user.coords.z, store.position.x, store.position.y, store.position.z) < 4.5 then
						local cops = 0
						TriggerEvent('es:getPlayers', function(pl)
							for k,v in pairs(pl) do
								TriggerEvent('es_roleplay:getPlayerJob', k, function(job)
									if(job)then
										if(job.job == "police")then
											cops = cops + 1
										end
									end
								end)
							end
						end)

						if(cops > 0)then

							TriggerEvent('es:getPlayers', function(pl)
								for k,v in pairs(pl) do
									TriggerEvent('es_roleplay:getPlayerJob', k, function(job)
										if(job)then
											if(job.job == "police")then
												TriggerClientEvent('chatMessage', k, 'ROBBERY', {255, 0, 0}, "Robbery in progress at ^2" .. store.prettyName)
											end
										end
									end)
								end
							end)

							TriggerClientEvent('chatMessage', source, 'ROBBERY', {255, 0, 0}, "You started a robbery at: ^2^*" .. store.prettyName .. "^0^r, do not get too far away from this point!")
							TriggerClientEvent('es_robberies:robbingStore', source, rob)
							stores[rob].lastRob = os.time()
							curRobbers[source] = rob

							local savedSource = source
							SetTimeout(120000, function()
								if(curRobbers[savedSource])then
									TriggerClientEvent('es_robberies:robbingStoreDone', savedSource, job)
									TriggerEvent('es:getPlayerFromId', savedSource, function(target) 
										if(target)then
											target:addMoney(store.reward)
										end
									end)

									TriggerEvent('es:getPlayers', function(pl)
										for k,v in pairs(pl) do
											TriggerEvent('es_roleplay:getPlayerJob', k, function(job)
												if(job)then
													if(job.job == "police")then
														TriggerClientEvent('chatMessage', k, 'ROBBERY', {255, 0, 0}, "Robbery is over at: ^2" .. store.prettyName)
													end
												end
											end)
										end
									end)
								end
							end)
						else
							TriggerClientEvent('chatMessage', source, "ROBBERY", {255, 0, 0}, "There are not enough police online. (Atleast 1 needed)")
						end
					end
				end
			end)
		end)
	end
end)