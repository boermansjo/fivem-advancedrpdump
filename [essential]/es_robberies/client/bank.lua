local robbing = false
local robbingName = ""
local secondsRemaining = 0

local banks = {
	["fleeca"] = {
		position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
		reward = 9000,
		prettyName = "Fleeca Bank",
		lastRob = 0
	},
	["fleeca2"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
		reward = 9000,
		prettyName = "Fleeca Bank 2",
		lastRob = 0
	},
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		reward = 12000,
		prettyName = "Blaine County Savings",
		lastRob = 0
	}
}

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('es_robberies:robbingBank')
AddEventHandler('es_robberies:robbingBank', function(rob)
	robbing = true
	robbingName = rob

	TriggerEvent('chatMessage', 'ROBBERY', {255, 0, 0}, "You started a robbery on: ^2" .. banks[robbingName].prettyName)
	secondsRemaining = 600
end)

RegisterNetEvent('es_robberies:robbingBankDone')
AddEventHandler('es_robberies:robbingBankDone', function(rob)
	robbing = false

	TriggerEvent('chatMessage', 'ROBBERY', {255, 0, 0}, "Robbery done, you received: ^2" .. banks[robbingName].reward)
	robbingName = ""
	secondsRemaining = 0
end)

RegisterNetEvent('es_robberies:robberyCancelled')
AddEventHandler('es_robberies:robberyCancelled', function(rob)
	robbing = false

	TriggerEvent('chatMessage', 'ROBBERY', {255, 0, 0}, "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
end)

Citizen.CreateThread(function()
	while true do
		if robbing then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 80)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robbable Bank")
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not robbing then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 0,155, 0,0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.prettyName .. "~w~ beware, the police will be alerted!")

						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('es_robberies:robBank', k)
						end
					end
				end
			end
		end

		if robbing then
			drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Robbing bank: ~r~" .. secondsRemaining .. "~w~seconds remaining", 255, 255, 255, 255)

			local pos2 = banks[robbingName].position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('es_robberies:walkedOff', robbingName)
			end
		end

		Citizen.Wait(0)
	end
end)