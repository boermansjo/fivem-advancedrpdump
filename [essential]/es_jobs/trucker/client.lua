local truckers_jobs = {
	['trucker1'] = {
		["name"] = "liqour ace",
		["start"] = {['x'] = 1372.05, ['y'] = 3619.89, ['z'] = 34.88},
		["end"] = {['x'] = -2586.51, ['y'] = 1930.86, ['z'] = 167.52},
		["payment"] = 7050
	},
	['trucker2'] = {
		["name"] = "warehouse",
		["start"] = {['x'] = 744.29, ['y'] =  -966.61, ['z'] = 24.59},
		["end"] = {['x'] = -1556.34, ['y'] = 112.91, ['z'] = 56.77},
		["payment"] = 4500
	},
	['trucker3'] = {
		["name"] = "warehouse2",
		["start"] = {['x'] = 689.15, ['y'] = -967.90, ['z'] = 23.47},
		["end"] = {['x'] = -106.58, ['y'] = 834.20, ['z'] = 235.71},
		["payment"] = 4500
	}
}

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('es_jobs:jobTruckerDone')
AddEventHandler('es_jobs:jobTruckerDone', function()
	TriggerServerEvent('es_jobs:jobTruckerDone', GetVehiclePedIsIn(GetPlayerPed(-1), false))
end)

RegisterNetEvent('es_jobs:startTruckerJob')
AddEventHandler('es_jobs:startTruckerJob', function()
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	TriggerServerEvent('es_jobs:startTruckerJob', vehicle, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
end)

local trucker_blip
local markers = {}
curJob = ""
local trucking_marker

local displayDoneMission = false

local function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline, center)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
	if(center)then
		SetTextCentre(1)
	end
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent("es_jobs:setCurrentJob")
AddEventHandler("es_jobs:setCurrentJob", function(j)
	curJob = j

	if(trucking_marker)then
		TriggerServerEvent("es_jobs:cancelTrucking")
	end
end)

RegisterNetEvent('es_jobs:createMarkerTrucker')
AddEventHandler('es_jobs:createMarkerTrucker', function(id, x, y, z, dr)
	trucking_marker = {['x'] = x, ['y'] = y, ['z'] = z}
	trucker_blip = AddBlipForCoord(x,  y,  z)
	SetBlipRoute(trucker_blip, true)

	Citizen.Trace(dr .. "\n")

	DecorSetInt(GetVehiclePedIsIn(GetPlayerPed(-1), false), "drugs", dr)
end)

local rt
local curMsg = "SHOW_MISSION_PASSED_MESSAGE"

RegisterNetEvent('es_jobs:removeMarkerTrucker')
AddEventHandler('es_jobs:removeMarkerTrucker', function(id, complete)
	trucking_marker = nil
	Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(trucker_blip))

	DecorSetInt(GetVehiclePedIsIn(GetPlayerPed(-1), false), "drugs", 0)

	if(complete) then
		Citizen.CreateThread(function()
			RegisterScriptWithAudio(0)
			SetAudioFlag("AvoidMissionCompleteDelay", true)
			PlayMissionCompleteAudio("FRANKLIN_BIG_01")
			curMsg = "SHOW_MISSION_PASSED_MESSAGE"
			rt = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
			StartScreenEffect("SuccessFranklin",  6000,  false)
			displayDoneMission = true
		end)
	end
end)

local trucker_locations = {
	{['x'] = 1372.05, ['y'] = 3619.89, ['z'] = 34.88},
	{['x'] = 744.29, ['y'] =  -966.61, ['z'] = 24.59},
	{['x'] = 689.15, ['y'] = -967.90, ['z'] = 23.47},
}

local possibleCargo = {
	{
		type = 0,
		name = "Shipment",
		vehicle = "mule"
	},
	{
		type = 1,
		name = "Xin's Package",
		vehicle = "mule"
	}
}

Citizen.CreateThread(function()
	for k,v in ipairs(trucker_locations)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 67)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Trucking mission")
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		if displayDoneMission then
			Citizen.Wait(5000)
			curMsg = "TRANSITION_OUT"
			PushScaleformMovieFunction(rt, "TRANSITION_OUT")
			PopScaleformMovieFunction()
			Citizen.Wait(2000)
			displayDoneMission = false
		end

		Citizen.Wait(0)
	end
end)

local selected = 1

DecorRegister("drugs", 3)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(HasScaleformMovieLoaded(rt) and displayDoneMission)then
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(19)
			HideHudAndRadarThisFrame()

			if(curMsg == "SHOW_MISSION_PASSED_MESSAGE")then
				PushScaleformMovieFunction(rt, curMsg)
	 
				
				BeginTextComponent("STRING")
				AddTextComponentString("Goods delivered")
				EndTextComponent()
				BeginTextComponent("STRING")
				AddTextComponentString("Hmmmm")
				EndTextComponent()

				PushScaleformMovieFunctionParameterInt(145)
				PushScaleformMovieFunctionParameterBool(true)
				PushScaleformMovieFunctionParameterInt(1)
				PushScaleformMovieFunctionParameterBool(false)
				PushScaleformMovieFunctionParameterInt(69)

				PopScaleformMovieFunctionVoid()

				Citizen.InvokeNative(0x61bb1d9b3a95d802, 1)
			end
			
			DrawScaleformMovieFullscreen(rt, 255, 255, 255, 255)
		end

		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		
		if(curJob == "police")then
			if(IsPedInAnyVehicle(GetPlayerPed(-1), false))then
				local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				if DecorGetInt(veh, "drugs") == 1 then
					drawTxt(0.896, 1.420, 1.0,1.0,0.61, "You notice a package of drugs in the back.", 255, 255, 255, 255, false, true)
				end
			end
		end

		for k,v in ipairs(trucker_locations) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 100.0)then
			DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.2001, 0, 0, 0,155, 0,0, 0,0)

			local pos = GetEntityCoords(GetPlayerPed(-1), false)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 5.0)then
					if(curJob == "trucker")then
						if(trucking_marker ~= nil)then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to cancel current trucking mission.")
							if(IsControlJustPressed(1, 51)) then -- Up
								TriggerServerEvent("es_jobs:cancelTrucking")
							end
						else
							DisplayHelpText("Controls ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ ~INPUT_CELLPHONE_RIGHT~")

							DrawRect(0.127, 0.108, 0.225, 0.08, 0, 0, 0, 100)
							drawTxt(0.626, 0.560, 1.0,1.0,0.81, "Choose Cargo", 255, 255, 255, 255, false, true)
							drawTxt(0.515, 0.610, 1.0,1.0,0.41, "Option", 200, 200, 200, 255)
							drawTxt(0.680, 0.610, 1.0,1.0,0.41, "Desc", 200, 200, 200, 255)
							for c,e in ipairs(possibleCargo)do
								if(c ~= selected)then
									DrawRect(0.127, 0.12939 + (c * 0.037),  0.225,  0.037,  100,  100, 100,  200)
								end
								DrawRect(0.127, 0.12939 + (selected * 0.037),  0.225,  0.037,  200,  200, 200,  200)
								drawTxt(0.515, 0.61 + (c * 0.037), 1.0,1.0,0.37, "" .. e.name, 255, 255, 255, 255, true)
								if(e.type == 1)then
									drawTxt(0.682, 0.61 + (c * 0.037), 1.0,1.0,0.37, "Illegal", 200, 0, 0, 255, true)
								else
									drawTxt(0.682, 0.61 + (c * 0.037), 1.0,1.0,0.37, "Legal", 0, 200, 0, 255, true)
								end
							end

							DisableControlAction(1, 27, true)
							if(IsControlJustPressed(1, 172)) then -- Up
								if(selected ~= 1)then
									selected = selected - 1
								end
							elseif(IsControlJustPressed(1, 173)) then -- Down
								if(selected ~= #possibleCargo)then
									selected = selected + 1
								end
							end

							if(IsControlJustReleased(1, 175))then
								TriggerServerEvent('es_jobs:triggerTrucking', possibleCargo[selected].type)
							end
						end
					else
						DisplayHelpText("You need to be a ~HUD_COLOUR_RED~trucker~HUD_COLOUR_WHITE~ to do this job.")
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		if(trucking_marker)then
			if(Vdist(trucking_marker.x, trucking_marker.y, trucking_marker.z, pos.x, pos.y, pos.z) < 100.0)then
				DrawMarker(1, trucking_marker.x, trucking_marker.y, trucking_marker.z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 0.8001, 255, 165, 0,155, 0,0, 0,0)
				if(Vdist(trucking_marker.x, trucking_marker.y, trucking_marker.z, pos.x, pos.y, pos.z) < 7.0)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to finish a ~y~trucking~w~ mission.")
					if(IsControlJustReleased(1, 51))then
						TriggerServerEvent('es_jobs:triggerTrucking', 0)
					end
				end
			end
		end
		Citizen.Wait(0)
	end
end)