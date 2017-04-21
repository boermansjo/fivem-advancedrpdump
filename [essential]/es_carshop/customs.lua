local customs = {
	{ ['x'] = 1776.3288574219, ['y'] = 3335.4333496094, ['z'] = 41.207939147949 },
	{ ['x'] = 1182.5786132813, ['y'] = 2638.0397949219, ['z'] = 37.795112609863 },
	{ ['x'] = 103.9239730835, ['y'] = 6622.125, ['z'] = 31.828550338745 },
	{ ['x'] = -338.36505126953, ['y'] = -136.64733886719, ['z'] = 39.009620666504 },
	{ ['x'] = -1154.4886474609, ['y'] = -2005.1927490234, ['z'] = 13.180252075195 },
}

local menus = {}

local curMenu = "main_menu"

local wheels = 0
local tint = 0
local plate = 0
local exhaust = 0
local grills = 0
local spoiler = 0

Citizen.CreateThread(function()
	for k,v in ipairs(customs)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 72)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vehicle Customization")
		EndTextCommandSetBlipName(blip)
	end
end)

menus.main_menu = {
	["type"] = "main",
	["title"] = "Main menu",
	["options"] = {
		{title = "Colour", open_sub = "colour_menu"},
		{title = "Mods", open_sub = "mods_menu"},
		{title = "Save", func = function()
			if(DecorGetInt(GetVehiclePedIsIn(GetPlayerPed(-1)), "owner") == GetPlayerServerId(PlayerId()))then
				local r,g,b = GetVehicleCustomPrimaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false))
				local r2,g2,b2 = GetVehicleCustomSecondaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false))

				local d = {
					r = r, 
					g = g, 
					b = b, 
					r2 = r2,
					g2 = g2, 
					b2 = b2, 
					wheels = wheels, 
					windows = tint, 
					platetype = plate,
					exhausts = exhaust, 
					grills = grills, 
					spoiler = spoiler
				}

				TriggerServerEvent("es_carshop:vehicleCustom", vehicle_names[GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))], d)
			else
				TriggerEvent("chatMessage", "CUSTOMS", {255, 0, 0}, "You can only save your own vehicles.")
			end
		end,
		desc = function()
			return "1.5k"
		end},
	}
}

local vehicleColours = {r = 22, g = 22, b = 22}
local vehicleColoursS = {r = 22, g = 22, b = 22}

menus.colour_menu = {
	["type"] = "submenu",
	["title"] = "Colour",
	["options"] = {
		{title = "Back", open_sub = "main_menu"},
		{title = "Primary red", func = function(d)
			if(d == 1)then
				if(tonumber(vehicleColours.r) < 255)then
					vehicleColours.r = vehicleColours.r + 5
				end
			else
				if(tonumber(vehicleColours.r) > 0)then
					vehicleColours.r = vehicleColours.r - 5
				end
			end

			SetVehicleCustomPrimaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false),  vehicleColours.r, vehicleColours.g, vehicleColours.b)
		end, desc = function()
			return vehicleColours.r
		end},
		{title = "Primary green", func = function(d)
			if(d == 1)then
				if(tonumber(vehicleColours.g) < 255)then
					vehicleColours.g = vehicleColours.g + 5
				end
			else
				if(tonumber(vehicleColours.g) > 0)then
					vehicleColours.g = vehicleColours.g - 5
				end
			end

			SetVehicleCustomPrimaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false),  vehicleColours.r, vehicleColours.g, vehicleColours.b)
		end, desc = function()
			return vehicleColours.g
		end},
		{title = "Primary blue", func = function(d)
			if(d == 1)then
				if(tonumber(vehicleColours.b) < 255)then
					vehicleColours.b = vehicleColours.b + 5
				end
			else
				if(tonumber(vehicleColours.b) > 0)then
					vehicleColours.b = vehicleColours.b - 5
				end
			end

			SetVehicleCustomPrimaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false),  vehicleColours.r, vehicleColours.g, vehicleColours.b)
		end, desc = function()
			return vehicleColours.b
		end},

		{title = "Secondary red", func = function(d)
			if(d == 1)then
				if(tonumber(vehicleColoursS.r) < 255)then
					vehicleColoursS.r = vehicleColoursS.r + 5
				end
			else
				if(tonumber(vehicleColoursS.r) > 0)then
					vehicleColoursS.r = vehicleColoursS.r - 5
				end
			end

			SetVehicleCustomSecondaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false),  vehicleColoursS.r, vehicleColoursS.g, vehicleColoursS.b)
		end, desc = function()
			return vehicleColoursS.r
		end},
		{title = "Secondary green", func = function(d)
			if(d == 1)then
				if(tonumber(vehicleColoursS.g) < 255)then
					vehicleColoursS.g = vehicleColoursS.g + 5
				end
			else
				if(tonumber(vehicleColoursS.g) > 0)then
					vehicleColoursS.g = vehicleColoursS.g - 5
				end
			end

			SetVehicleCustomSecondaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false),  vehicleColoursS.r, vehicleColoursS.g, vehicleColoursS.b)
		end, desc = function()
			return vehicleColoursS.g
		end},
		{title = "Secondary blue", func = function(d)
			if(d == 1)then
				if(tonumber(vehicleColoursS.b) < 255)then
					vehicleColoursS.b = vehicleColoursS.b + 5
				end
			else
				if(tonumber(vehicleColoursS.b) > 0)then
					vehicleColoursS.b = vehicleColoursS.b - 5
				end
			end

			SetVehicleCustomSecondaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false),  vehicleColoursS.r, vehicleColoursS.g, vehicleColoursS.b)
		end, desc = function()
			return vehicleColoursS.b
		end},
	},

}

menus.mods_menu = {
	["type"] = "submenu",
	["title"] = "Modifications",
	["options"] = {
		{title = "Back", open_sub = "main_menu"},
		{title = "Wheels", func = function(d)
			if(d == 1)then
				if(wheels < GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  23))then
					wheels = wheels + 1
				end
			else
				if(wheels > 0)then
					wheels = wheels - 1
				end
			end

			SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  23,  wheels,  true)
		end, desc = function()
			if(type(wheels) == "boolean")then
				return "0"
			end
			return wheels .. "/" .. tostring(GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  23))
		end},
		{title = "Window tint", func = function(d)
			if(d == 1)then
				if(tint < GetNumVehicleWindowTints(GetVehiclePedIsIn(GetPlayerPed(-1),  false)))then
					tint = tint + 1
				end
			else
				if(tint > 0)then
					tint = tint - 1
				end
			end

			SetVehicleWindowTint(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  tint)
		end, desc = function()
			return tint .. "/" .. tostring(GetNumVehicleWindowTints(GetVehiclePedIsIn(GetPlayerPed(-1),  false)))
		end},
		{title = "Plate type", func = function(d)
			if(d == 1)then
				if(plate ~= false)then
					if(plate < GetNumberOfVehicleNumberPlates())then
						plate = plate + 1
					end
				end
			else
				if(plate ~= false)then
					if(plate > 0)then
						plate = plate - 1
					end
				end
			end

			SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  plate)
		end, desc = function()
			if(plate == false)then
				return "0"
			end
			return tostring(plate) .. "/" .. tostring(GetNumberOfVehicleNumberPlates())
		end},
		{title = "Exhausts", display = function() return GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  4) end, func = function(d)
			if(d == 1)then
				if(exhaust < GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  4))then
					exhaust = exhaust + 1
				end
			else
				if(exhaust > 0)then
					exhaust = exhaust - 1
				end
			end

			SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  4,  exhaust,  true)
		end, desc = function()
			if(type(exhaust) == "boolean")then
				return "0"
			end
			return exhaust .. "/" .. tostring(GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  4))
		end},
		{title = "Grills", display = function() return GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  6) end, func = function(d)
			if(d == 1)then
				if(grills < GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  6))then
					grills = grills + 1
				end
			else
				if(grills > 0)then
					grills = grills - 1
				end
			end

			SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  6,  grills,  true)
		end, desc = function()
			if(type(grills) == "boolean")then
				return "0"
			end
			return grills .. "/" .. tostring(GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  6))
		end},
		{title = "Spoiler", display = function() return GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0) end, func = function(d)
			if(d == 1)then
				if(spoiler < GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0))then
					spoiler = spoiler + 1
				end
			else
				if(spoiler > 0)then
					spoiler = spoiler - 1
				end
			end

			SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0,  spoiler,  true)
		end, desc = function()
			if(type(spoiler) == "boolean")then
				return "0"
			end
			return spoiler .. "/" .. tostring(GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0))
		end},
	}
}

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

local selected = 1

local function openSubMenu(menu)
	curMenu = menu
	selected = 1
end

local firstEnter = true

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(customs)do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 55.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.8001, 255, 155, 0,155, 0,0, 0,0)
			end

			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 3.50)then
				if(not IsPedInAnyVehicle(GetPlayerPed(-1),  false) or GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) ~= GetPlayerPed(-1))then
					DisplayHelpText("You need to be driving a ~b~vehicle~w~ to customize it.")
				else
					if(firstEnter)then
						local r,g,b = GetVehicleCustomPrimaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false))
						local r2,g2,b2 = GetVehicleCustomSecondaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false))
						wheels = GetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1)),  23)
						exhaust = GetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1)),  4)
						tint = GetVehicleWindowTint(GetVehiclePedIsIn(GetPlayerPed(-1)))
						plate = GetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(GetPlayerPed(-1)))
						if(wheels == -1 or wheels == false)then
							wheels = 0
						end
						if(tint == -1 or tint == false)then
							tint = 0
						end
						if(plate == -1 or plate == false)then
							plate = 0
						end
						if(exhaust == -1 or exhaust == false)then
							exhaust = 0
						end
						vehicleColours.r = r
						vehicleColours.g = g
						vehicleColours.b = b

						vehicleColoursS.r = r2
						vehicleColoursS.g = g2
						vehicleColoursS.b = b2
						firstEnter = false
					end
					DrawRect(0.402, 0.048, 0.225, 0.08, 0, 0, 0, 100)
					drawTxt(0.901, 0.5, 1.0,1.0,0.81, "" .. menus[curMenu].title, 255, 255, 255, 255, false, true)
					drawTxt(0.79, 0.55, 1.0,1.0,0.41, "Option", 200, 200, 200, 255)
					drawTxt(0.955, 0.55, 1.0,1.0,0.41, "Desc", 200, 200, 200, 255)
					local t = 0
					for c,e in pairs(menus[curMenu].options)do
						t = t + 1
						if(t ~= selected)then
							DrawRect(0.402, 0.06939 + (t * 0.037),  0.225,  0.037,  100,  100, 100,  200)
						end
						DrawRect(0.402, 0.06939 + (selected * 0.037),  0.225,  0.037,  200,  200, 200,  200)
						DrawRect(0.28, 0.06939 + (selected * 0.037),  0.012,  0.02,  0,  0, 0,  255)
						drawTxt(0.79, 0.55 + (t * 0.037), 1.0,1.0,0.37, "" .. e.title, 255, 255, 255, 255, true)
						if(e.desc)then
							local doDis = true
							if(e.display)then
								doDis = e.display()
							end
							if(doDis)then
								drawTxt(0.955, 0.55 + (t * 0.037), 1.0,1.0,0.37, "" .. e.desc(), 0, 200, 0, 255, true)
							else
								drawTxt(0.955, 0.55 + (t * 0.037), 1.0,1.0,0.37, "none", 0, 200, 0, 255, true)
							end
						end
					end

					DisplayHelpText("Controls ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ ~INPUT_CELLPHONE_RIGHT~ ~INPUT_CELLPHONE_LEFT~")

					DisableControlAction(1, 27, true)
					if(IsControlJustPressed(1, 172)) then -- Up
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if(selected ~= 1)then
							selected = selected - 1
						end
					elseif(IsControlJustPressed(1, 173)) then -- Down
						PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						if(selected ~= returnIndexesInTable(menus[curMenu].options))then
							selected = selected + 1
						end
					elseif(IsControlJustPressed(1, 175)) then -- Right
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						local sel = 0
						for k,v in pairs(menus[curMenu].options) do
							sel = sel + 1

							if(sel == selected)then
									local doDis = true
									if(v.display)then
										doDis = v.display()
									end
									if(doDis)then
									if(v.func)then
										v.func(1)
									end
									if(v.open_sub)then
										openSubMenu(v.open_sub)
									end
								end
							end
						end
					elseif(IsControlJustPressed(1, 174)) then -- Left
						PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
						local sel = 0
						for k,v in pairs(menus[curMenu].options) do
							sel = sel + 1
							if(sel == selected)then
									local doDis = true
									if(v.display)then
										doDis = v.display()
									end
									if(doDis)then
									if(v.func)then
										v.func(0)
									end
									if(v.open_sub)then
										openSubMenu(v.open_sub)
									end
								end
							end
						end
					end
				end
			else
				if(not firstEnter)then
					firstEnter = true
				end
			end
		end
	end
end)

function returnIndexesInTable(t)
	local i = 0;
	for _,v in pairs(t)do
 		i = i + 1
	end
	return i;
end