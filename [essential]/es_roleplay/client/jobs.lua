local cuffed = {}

local dragging = {}
local invehicle = {}

RegisterNetEvent('es_roleplay:heal')
AddEventHandler('es_roleplay:heal', function()
	SetEntityHealth(GetPlayerPed(-1), 1000)
end)

RegisterNetEvent("es_roleplay:removeVehicle")
AddEventHandler("es_roleplay:removeVehicle", function(v)
	SetEntityAsMissionEntity(GetVehiclePedIsIn(GetPlayerPed(-1), false))
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(GetVehiclePedIsIn(GetPlayerPed(-1))))
end)

local markers = {}

RegisterNetEvent("es_roleplay:createMarker")
AddEventHandler("es_roleplay:createMarker", function(id, x, y, z, r, g, b)
	markers[id] = {pos = {['x'] = x, ['y'] = y, ['z'] = z}, color = {['r'] = r, ['g'] = g, ['b'] = b}}
end)

RegisterNetEvent("es_roleplay:createBlip")
AddEventHandler("es_roleplay:createBlip", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	if(type == 56)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Chop Shop")
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent("es_roleplay:removeMarker")
AddEventHandler("es_roleplay:removeMarker", function(id)
	markers[id] = nil
end)

RegisterNetEvent('es_roleplay:setSkin')
AddEventHandler('es_roleplay:setSkin', function(skin)
	RequestModel(GetHashKey(skin))
	while not HasModelLoaded(GetHashKey(skin)) do
			Citizen.Wait(0)
	end

	SetPlayerModel(PlayerId(), GetHashKey(skin))
end)

local pauseMenu = false

function DrawMissionText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

SetEntityCollision(GetPlayerPed(GetPlayerFromServerId(k)), true, true)

Citizen.CreateThread(function()
	while true do
		for i,e in pairs(markers)do
			if(pos and markers[i].pos)then
				if(Vdist(markers[i].pos.x, markers[i].pos.y, markers[i].pos.z, pos.x, pos.y, pos.z) < 50.0)then
					DrawMarker(1, markers[i].pos.x, markers[i].pos.y, markers[i].pos.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, markers[i].color.r, markers[i].color.g, markers[i].color.b,155, 0,0, 0,0)
				end
			end
		end

		Citizen.Wait(0)
	end
end)

AddEventHandler('playerSpawned', function()
	dead = false
	NetworkSetTalkerProximity(30.001)
end)
NetworkSetTalkerProximity(30.001)

-- Chop shop

local chop_shops = {
	{['x'] = 1175.06, ['y'] = 2639.82, ['z'] = 37.75},
	{['x'] = 1008.35, ['y'] = -2519.67, ['z'] = 28.30},
}

Citizen.CreateThread(function()
	for k,v in ipairs(chop_shops)do
		TriggerEvent('es_roleplay:createBlip', 56, v.x, v.y, v.z)
	end

	while true do
		for i,e in ipairs(chop_shops)do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			if(pos and chop_shops[i] and uSettings.enableChopshops)then
				if(Vdist(chop_shops[i].x, chop_shops[i].y, chop_shops[i].z, pos.x, pos.y, pos.z) < 50.0)then
					DrawMarker(1, chop_shops[i].x, chop_shops[i].y, chop_shops[i].z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 165, 255,155, 0,0, 0,0)
					if(Vdist(chop_shops[i].x, chop_shops[i].y, chop_shops[i].z, pos.x, pos.y, pos.z) < 3.0)then
						if(IsPedInAnyVehicle(GetPlayerPed(-1), false))then
							if(DecorGetInt(GetVehiclePedIsIn(GetPlayerPed(-1)), "owner") ~= false)then
								DisplayHelpText("You cannot sell player vehicles.")
							else
								if(GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)),  -1) == GetPlayerPed(-1))then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to ~y~sell~w~ this ~b~vehicle~w~.")
									if(IsControlJustReleased(1, 38))then
										TriggerServerEvent('es_roleplay:sellVehicle', GetVehiclePedIsIn(GetPlayerPed(), false))
									end
								end
							end
						end
					end
				end
			end
		end

		Citizen.Wait(0)
	end
end)