RequestIpl("farm")
RequestIpl("farm_props")
RequestIpl("farmint")
RequestIpl("shr_int")
RemoveIpl("farmint_cap")
RemoveIpl("fakeint")
RemoveIpl("shutter_closed")

RegisterNetEvent('es_roleplay:freezePlayer')
AddEventHandler('es_roleplay:freezePlayer', function(freeze)
	local player = PlayerId()
	SetPlayerControl(player, not freeze, false)

	local ped = GetPlayerPed(player)

	if not freeze then
			if not IsEntityVisible(ped) then
					SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
					SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
	else
			if IsEntityVisible(ped) then
					SetEntityVisible(ped, false)
			end

			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)

			if not IsPedFatallyInjured(ped) then
					ClearPedTasksImmediately(ped)
			end
	end
end)

RegisterNetEvent('es_roleplay:teleportPlayer')
AddEventHandler('es_roleplay:teleportPlayer', function(x, y, z)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
end)

RegisterNetEvent('es_roleplay:teleportPlayerAndVehicle')
AddEventHandler('es_roleplay:teleportPlayerAndVehicle', function(x, y, z)
	if(IsPedInAnyVehicle(GetPlayerPed(-1),  false))then
		SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), x, y, z)
	else
		SetEntityCoords(GetPlayerPed(-1), x, y, z)
	end
end)

local pauseMenu = false 

-- Spawn override
AddEventHandler('onClientMapStart', function()
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
    
    exports.spawnmanager:setAutoSpawnCallback(function()
        if(true)then
            TriggerServerEvent('es_roleplay:spawn')
        end
    end)

    -- Pause menu disable money display
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if IsPauseMenuActive() and not pauseMenu then
                pauseMenu = true
                TriggerEvent('es:setMoneyDisplay', 0.0)
            elseif not IsPauseMenuActive() and pauseMenu then
                pauseMenu = false
                TriggerEvent('es:setMoneyDisplay', 1.0)
            end
        end
    end)
end)

AddEventHandler("playerSpawned", function()
    SetPedDefaultComponentVariation(GetPlayerPed(-1))
end)

RegisterNetEvent('es_roleplay:spawnPlayer')
AddEventHandler('es_roleplay:spawnPlayer', function(x, y, z, model)
	exports.spawnmanager:spawnPlayer({x = x, y = y, z = z, model = GetHashKey(model)})
end)