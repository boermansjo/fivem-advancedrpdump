AddEventHandler('playerSpawned', function()
	TriggerServerEvent('playerSpawn')
end)

RegisterNetEvent('es_roleplay:createJailBlip')
AddEventHandler('es_roleplay:createJailBlip', function(x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 60)
end)

local savedTime = 0

RegisterNetEvent('es_roleplay:sync')
AddEventHandler('es_roleplay:sync', function(t)
	savedTime = t.time
	NetworkOverrideClockTime(t.time, 0, 0)
	SetOverrideWeather(t.weather)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		ClearPlayerWantedLevel(PlayerId())
		SetMaxWantedLevel(0)
		SetPoliceIgnorePlayer(PlayerId(), true)
	end
end)

local sirenOff = false

Citizen.CreateThread(function()
	while true do
		if(IsControlJustReleased(1, 311) and IsPedInAnyVehicle(GetPlayerPed(-1), false))then
			sirenOff = not sirenOff

			local temp = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			TriggerServerEvent('es_roleplay:vehicleSiren', sirenOff)
		end

		Citizen.Wait(0)
	end
end)

local vehicleSirens = {}

RegisterNetEvent('es_roleplay:vehicleSiren')
AddEventHandler('es_roleplay:vehicleSiren', function(v, b)
	vehicleSirens[tonumber(v)] = b
end)

AddEventHandler("onClientMapStart", function()
	RequestIpl("post_hiest_unload")
	RequestIpl("facelobby")
	RequestIpl("FIBlobby")
	RequestIpl("FIBlobby")

	local interior = GetInteriorAtCoords(-30.8793, -1088.336, 25.4221)

	DisableInterior(interior, false)
	N_0x2ca429c029ccf247(interior)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(25000)
			NetworkOverrideClockTime(savedTime, 0, 0)
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		RestorePlayerStamina(PlayerId(), 1.0)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(vehicleSirens)do
				Citizen.Wait(0)
				DisableVehicleImpactExplosionActivation(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(k)), false), v)
		end

		Citizen.Wait(0)
	end
end)
