local dead = false
local curVehicle = false
local cuffed = {}

local markers = {}

AddEventHandler("es_roleplay:createArrestMarker", function(id, x, y, z, r, g, b)
	markers[id] = {pos = {['x'] = x, ['y'] = y, ['z'] = z}, color = {['r'] = r, ['g'] = g, ['b'] = b}}
	Citizen.Trace('Police point created: ' .. id .. "\n")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(cuffed[GetPlayerServerId(PlayerId())] == true)then
			DisableControlAction(1, 18, true)
			DisableControlAction(1, 24, true)
			DisableControlAction(1, 69, true)
			DisableControlAction(1, 92, true)
			DisableControlAction(1, 106, true)
			DisableControlAction(1, 122, true)
			DisableControlAction(1, 135, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 144, true)
			DisableControlAction(1, 176, true)
			DisableControlAction(1, 223, true)
			DisableControlAction(1, 229, true)
			DisableControlAction(1, 237, true)
			DisableControlAction(1, 257, true)
			DisableControlAction(1, 329, true)
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 250, true)
			DisableControlAction(1, 263, true)
			DisableControlAction(1, 310, true)

			DisableControlAction(1, 22, true)
			DisableControlAction(1, 55, true)
			DisableControlAction(1, 76, true)
			DisableControlAction(1, 102, true)
			DisableControlAction(1, 114, true)
			DisableControlAction(1, 143, true)
			DisableControlAction(1, 179, true)
			DisableControlAction(1, 193, true)
			DisableControlAction(1, 203, true)
			DisableControlAction(1, 216, true)
			DisableControlAction(1, 255, true)
			DisableControlAction(1, 298, true)
			DisableControlAction(1, 321, true)
			DisableControlAction(1, 328, true)
			DisableControlAction(1, 331, true)
			DisableControlAction(0, 63, false)
			DisableControlAction(0, 64, false)
			DisableControlAction(0, 59, false)
			DisableControlAction(0, 278, false)
			DisableControlAction(0, 279, false)
			DisableControlAction(0, 68, false)
			DisableControlAction(0, 69, false)
			DisableControlAction(0, 75, false)
			DisableControlAction(0, 76, false)
			DisableControlAction(0, 102, false)	
			DisableControlAction(0, 81, false)
			DisableControlAction(0, 82, false)
			DisableControlAction(0, 83, false)
			DisableControlAction(0, 84, false)
			DisableControlAction(0, 85, false)
			DisableControlAction(0, 86, false) 
			DisableControlAction(0, 106, false)
			DisableControlAction(0, 25, false)

			while not HasAnimDictLoaded('mp_arresting') do
				RequestAnimDict('mp_arresting')
				Citizen.Wait(0)
			end

			if not IsEntityPlayingAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 3) then
				TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
			end
		end
	end
end)

Citizen.CreateThread(function()
	for k,v in ipairs(police.arrest_points)do
		TriggerEvent('es_roleplay:createBlip', 237, v.x, v.y, v.z)
		TriggerEvent('es_roleplay:createArrestMarker', "police_arrest_" .. tostring(k), v.x, v.y, v.z, 0, 0, 255)
	end
end)

RegisterNetEvent("es_roleplay:cuff")
AddEventHandler('es_roleplay:cuff', function(bool, pl)
	local ped = GetPlayerPed(GetPlayerFromServerId(pl))

	if(not bool)then
		EnableControlAction(1, 329, true)
	else
		SetPedCanSwitchWeapon(ped, false)
	end

	if(pl == GetPlayerServerId(PlayerId()))then
		StopAnimTask(ped, 'mp_arresting', 'idle', 1.0)
		SetPedCanSwitchWeapon(GetPlayerPed(-1),  not bool)
	end

	if bool then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			TaskPlayAnim(GetPlayerPed(GetPlayerFromServerId(pl)), 'mp_arresting', 'idle', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
		end)
	end

	cuffed[pl] = bool
end)

RegisterNetEvent("es_roleplay:unseat")
AddEventHandler('es_roleplay:unseat', function(bool, pl)
	local ped = GetPlayerPed(GetPlayerFromServerId(pl))

	ClearPedTasksImmediately(ped)
end)

Citizen.CreateThread(function()
	while true do
		for i,e in pairs(markers)do
			local pos = GetEntityCoords(GetPlayerPed(), true)
			if(pos and markers[i].pos)then
				if(Vdist(markers[i].pos.x, markers[i].pos.y, markers[i].pos.z, pos.x, pos.y, pos.z) < 100.0)then
					DrawMarker(1, markers[i].pos.x, markers[i].pos.y, markers[i].pos.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, markers[i].color.r, markers[i].color.g, markers[i].color.b,155, 0,0, 0,0)
				end
			end
		end
		
		Citizen.Wait(0)
	end
end)