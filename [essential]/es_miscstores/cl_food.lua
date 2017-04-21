function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--[[

	Coords for all shops
x=-46.313, y=-1757.504, z=29.421, a=46.395
x=24.376, y=-1345.558, z=29.421, a=267.940
x=1134.182, y=-982.477, z=46.416, a=275.432
x=373.015, y=328.332, z=103.566, a=257.309
x=2676.389, y=3280.362, z=55.241, a=332.305
x=1958.960, y=3741.979, z=32.344, a=303.196
x=-2966.391, y=391.324, z=15.043, a=88.867
x=-1698.542, y=4922.583, z=42.064, a=324.021
x=1164.565, y=-322.121, z=69.205, a=100.492
x=-1486.530, y=-377.768, z=40.163, a=147.669
x=-1221.568, y=-908.121, z=12.326, a=31.739
x=-706.153, y=-913.464, z=19.216, a=82.056
x=-1820.230, y=794.369, z=138.089, a=130.327
x=2555.474, y=380.909, z=108.623, a=355.737
x=1728.614, y=6416.729, z=35.037, a=247.369


]]

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

local twentyfourseven_shops = {
	{ ['x'] = 1961.1140136719, ['y'] = 3741.4494628906, ['z'] = 32.34375 },
	{ ['x'] = 1392.4129638672, ['y'] = 3604.47265625, ['z'] = 34.980926513672 },
	{ ['x'] = 546.98962402344, ['y'] = 2670.3176269531, ['z'] = 42.156539916992 },
	{ ['x'] = 2556.2534179688, ['y'] = 382.876953125, ['z'] = 108.62294769287 },
	{ ['x'] = -1821.9542236328, ['y'] = 792.40191650391, ['z'] = 138.13920593262 },
	{ ['x'] = 128.1410369873, ['y'] = -1286.1120605469, ['z'] = 29.281036376953 },
	{ ['x'] = -1223.6690673828, ['y'] = -906.67517089844, ['z'] = 12.326356887817 },
	{ ['x'] = -708.19256591797, ['y'] = -914.65264892578, ['z'] = 19.215591430664 },
	{ ['x'] = 26.419162750244, ['y'] = -1347.5804443359, ['z'] = 29.497024536133 },
}

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
			DisplayHelpText("You ~g~bought~w~ and ~g~ate~w~ a snack!")
		end

		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(twentyfourseven_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)

				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
					if(GetEntityHealth(GetPlayerPed(-1)) < 200)then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to buy a ~y~snack~w~ for ~g~£250~w~ and ~y~heal~w~ yourself.")

						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('es_roleplay:buySnack', k)

							displayingBoughtMessage = true
						end
					else
						if(not displayingBoughtMessage)then
							DisplayHelpText("You don't need to buy a snack.")
						end
					end
				end
			end
		end
	end
end)