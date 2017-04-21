local doingTakeover = false
local enemiesKilled = 0
local enemiesSpawned = {}
local enemiesKilledT = {}
local takingOver = ""

local locations = {
	["SANDY"] = {
		defendPosition = { ['x'] = 1645.3264160156, ['y'] = 3881.4721679688, ['z'] = 33.920635223389 },
		enemies = 2,
		enemyPeds = {
			0x9E08633D
		},
		enemyWeapons = {
			"WEAPON_PISTOL"
		},
		enemySpawnPositions = {
			{ ['x'] = 1660.5905761719, ['y'] = 3834.4013671875, ['z'] = 34.860507965088 },
			{ ['x'] = 1687.0656738281, ['y'] = 3859.099609375, ['z'] = 34.910873413086 },
		},
		taken = false,
		income = 700
	}
}

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("es_turfwars:loaded")
AddEventHandler("es_turfwars:loaded", function(turfs)
	for k,v in pairs(turfs)do
		if(v == '1')then
			locations[k].taken = true
		end
	end
end)

TriggerEvent("es_turfwars:loaded")

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local pos = GetEntityCoords(GetPlayerPed(-1), false)

		--Citizen.Trace("Current zone: " .. GetNameOfZone(pos.x, pos.y, pos.z) .. "\n")

		for k,v in pairs(locations) do
			if not v.taken then
				DrawMarker(1, v.defendPosition.x, v.defendPosition.y, v.defendPosition.z - 1, 0, 0, 0, 0, 0, 0, 2.4001, 2.4001, 0.8001, 0, 75, 255, 165, 0,0, 0,0)
			end

			if(Vdist2(pos.x, pos.y, pos.z, v.defendPosition.x, v.defendPosition.y, v.defendPosition.z) < 2.0 and v.taken == false and doingTakeover == false)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to attempt to takeover this zone.")

				if(IsControlJustReleased(1, 51))then
					takingOver = k
					doingTakeover = true
					enemiesKilled = 0
				end
			end
		end

		if doingTakeover then

			DisplayHelpText("Kill them ~HUD_COLOUR_RED~ALL")
			for k,v in ipairs(enemiesSpawned) do
				if IsPedFatallyInjured(v) and enemiesKilledT[k] == nil then
					enemiesKilledT[k] = true
					enemiesKilled = enemiesKilled + 1
				end
			end

			if (enemiesKilled == locations[takingOver].enemies) then
				Citizen.Wait(2000)
				for k,v in ipairs(enemiesSpawned) do
					Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(v))
				end

				enemiesSpawned = {}
				enemiesKilledT = {}

				locations[takingOver].taken = true
				doingTakeover = false

				TriggerServerEvent("es_turfwars:done", takingOver)
				TriggerEvent("chatMessage", "TURF", {255, 0, 0}, "You've taken this turf by force, it's yours now. ( Income increased by ^2^*" .. locations[takingOver].income .. "^0^r )")
			
				takingOver = ""
			end

			-- DEAD
			if IsPedFatallyInjured(GetPlayerPed(-1)) or Vdist(pos.x, pos.y, pos.z, locations[takingOver].defendPosition.x, locations[takingOver].defendPosition.y, locations[takingOver].defendPosition.z) > 100.0 then
				doingTakeover = false
				takingOver = ""
				enemiesKilled = 0
				enemiesKilledT = {}

				for k,v in ipairs(enemiesSpawned) do
					Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(v))
				end

				enemiesSpawned = {}

				TriggerEvent("chatMessage", "TURF", {255, 0, 0}, "You got too far away, you failed to takeover the turf.")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if doingTakeover then
			if(#enemiesSpawned < locations[takingOver].enemies)then
				local ped = locations[takingOver].enemyPeds[math.random(#locations[takingOver].enemyPeds)]
				local weapon = locations[takingOver].enemyWeapons[math.random(#locations[takingOver].enemyWeapons)]
				local spawnPosition = locations[takingOver].enemySpawnPositions[math.random(#locations[takingOver].enemySpawnPositions)]	
			
				local id = #enemiesSpawned + 1
				enemiesSpawned[id] = CreatePed(4, ped, spawnPosition.x, spawnPosition.y, spawnPosition.z, 10.0, false, true)

				local blip = AddBlipForEntity(enemiesSpawned[id])
				GiveDelayedWeaponToPed(enemiesSpawned[id], GetHashKey(weapon), 0, true)
				SetBlipSprite(blip,  270)
				SetBlipColour(blip, 1)
				TaskCombatPed(enemiesSpawned[id], GetPlayerPed(-1), 0, 16)

				if not DoesGroupExist(44) then
					CreateGroup(44)
				end

				SetPedAsGroupMember(enemiesSpawned[id], 44)

				Citizen.Wait(3000)
			end
		end
	end
end)