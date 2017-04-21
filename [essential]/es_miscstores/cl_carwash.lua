local carWashes = {
	{ ['x'] = -700.00408935547, ['y'] = -932.59112548828, ['z'] = 19.013912200928 },
	{ ['x'] = 170.85186767578, ['y'] = -1718.2307128906, ['z'] = 29.301685333252 },
	{ ['x'] = 21.746114730835, ['y'] = -1392.3521728516, ['z'] = 29.327951431274 },
	{ ['x'] = 1363.7286376953, ['y'] = 3592.5119628906, ['z'] = 34.914054870605 },
}

local function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline, center)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
	if(center)then
		Citizen.Trace("CENTER\n")
		SetTextCentre(false)
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


Citizen.CreateThread(function()
	for k,v in ipairs(carWashes)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 100)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Carwash")
		EndTextCommandSetBlipName(blip)
	end
end)


local displayingBoughtMessage = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if(displayingBoughtMessage)then
			Citizen.Wait(3000)
			displayingBoughtMessage = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(displayingBoughtMessage)then
			DisplayHelpText("You ~g~washed~w~ your vehicle!")
		end

		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in pairs(carWashes)do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 55.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 2.4001, 2.4001, 0.8001, 0, 75, 255, 165, 0,0, 0,0)

				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 2.0 and displayingBoughtMessage == false)then
					if(IsPedInAnyVehicle(GetPlayerPed(-1),  false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1))then
						if(GetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false)) < 2)then
							DisplayHelpText("Your ~b~vehicle~w~ is already clean.")
						else
							DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~wash~w~ your ~b~vehicle~w~ for ~g~50~w~ pounds.")

							if(IsControlJustReleased(1, 51))then
								TriggerServerEvent('es_roleplay:washCar', k)
								SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001)

								displayingBoughtMessage = true
							end
						end
					end
				end
			end
		end
	end
end)