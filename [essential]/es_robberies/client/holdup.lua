local holdingup = false
local store = ""
local secondsRemaining = 0

local stores = {
	["sandyshores_twentyfoursever"] = {
		position = { ['x'] = 1960.4197998047, ['y'] = 3742.9755859375, ['z'] = 32.343738555908 },
		reward = 2000,
		prettyName = "Twenty Four Seven.",
		lastRob = 0
	},
	["bar_one"] = {
		position = { ['x'] = 1986.1240234375, ['y'] = 3053.8747558594, ['z'] = 47.215171813965 },
		reward = 2000,
		prettyName = "Yellow Jack.",
		lastRob = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
		reward = 2000,
		prettyName = "Twenty Four Seven.",
		lastRob = 0
	}
}

RegisterNetEvent('es_robberies:robbingStore')
AddEventHandler('es_robberies:robbingStore', function(rob)
	holdingup = true
	store = rob
	secondsRemaining = 120
end)

RegisterNetEvent('es_robberies:robberyStoreCancelled')
AddEventHandler('es_robberies:robberyStoreCancelled', function(rob)
	holdingup = false

	TriggerEvent('chatMessage', 'ROBBERY', {255, 0, 0}, "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
end)


RegisterNetEvent('es_robberies:robbingStoreDone')
AddEventHandler('es_robberies:robbingStoreDone', function(rob)
	holdingup = false

	TriggerEvent('chatMessage', 'ROBBERY', {255, 0, 0}, "Robbery done, you received: ^2" .. stores[store].reward)
	store = ""
	secondsRemaining = 0
end)

Citizen.CreateThread(function()
	while true do
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 80)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robbable Store")
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 0,155, 0,0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.prettyName .. "~w~ beware, the police will be alerted!")

						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('es_robberies:robStore', k)
						end
					end
				end
			end
		end

		if holdingup then
			drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Robbing store: ~r~" .. secondsRemaining, 255, 255, 255, 255)

			local pos2 = stores[store].position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('es_robberies:walkedOff', store)
			end
		end

		Citizen.Wait(0)
	end
end)