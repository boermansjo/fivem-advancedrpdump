function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

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

local weapons = {}

RegisterNetEvent('es_roleplay:giveWeapon')
AddEventHandler('es_roleplay:giveWeapon', function(v)
	GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey(v), 0, false)

	table.insert(weapons, v)
end)

RegisterNetEvent('es_roleplay:removeAllWeapons')
AddEventHandler('es_roleplay:removeAllWeapons', function()
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
end)

local markers = {}

local weapon_shops = {}

local curWepShops = 0

RegisterNetEvent('es_miscstores:addWeaponShop')
AddEventHandler('es_miscstores:addWeaponShop', function(id, x, y, z, r, g, b, stock)
	Citizen.Trace("Weapon shop created: " .. id .. "\n")
	markers[id] = {pos = {['x'] = x, ['y'] = y, ['z'] = z}, color = {['r'] = r, ['g'] = g, ['b'] = b}}
	weapon_shops[id] = stock

	curWepShops = curWepShops + 1
end)

local blips = {
	{['x'] = -1117.81, ['y'] = 2698.16, ['z'] = 18.55},
	{['x'] = 1693.93, ['y'] = 3759.73, ['z'] = 34.7},
	{['x'] = 251.85, ['y'] = -49.87, ['z'] = 69.94},
	{['x'] = -1306.17, ['y'] = -394.16, ['z'] = 36.69},
	{['x'] = -662.22, ['y'] = -935.71, ['z'] = 21.82},
	{['x'] = -330.00, ['y'] = 6083.41, ['z'] = 31.45},
	{['x'] = 2567.91, ['y'] = 294.74, ['z'] = 108.73},
	{['x'] = -3171.67, ['y'] = 1087.66, ['z'] = 20.83},
	{['x'] = 842.40, ['y'] = -1033.12, ['z'] = 28.19},
	{['x'] = 21.70, ['y'] = -1107.41, ['z'] = 29.79},
	{['x'] = 810.15, ['y'] = -2156.88, ['z'] = 29.61},
}


local shop_keepers = {
	{ ['x'] = 1692.8857421875, ['y'] = 3762.1149902344, ['z'] = 33.705307006836, ['heading'] = 210.0 },
	{ ['x'] = -330.76327514648, ['y'] = 6086.203125, ['z'] = 30.45475769043, ['heading'] = 210.0 },
	{ ['x'] = 253.68670654297, ['y'] = -51.988189697266, ['z'] = 68.941040039063, ['heading'] = 80.0 },
	{ ['x'] = -1304.3062744141, ['y'] = -396.08514404297, ['z'] = 35.695755004883, ['heading'] = 80.0 },
	{ ['x'] = -661.00720214844, ['y'] = -933.48706054688, ['z'] = 20.829212188721, ['heading'] = 210.0 },
	{ ['x'] = 808.77386474609, ['y'] = -2159.1823730469, ['z'] = 28.619020462036, ['heading'] = 355.0 },
	{ ['x'] = 23.830430984497, ['y'] = -1105.7766113281, ['z'] = 28.797031402588, ['heading'] = 160.0 },
	{ ['x'] = -1118.1455078125, ['y'] = 2700.6569824219, ['z'] = 17.554151535034, ['heading'] = 210.0 },
	{ ['x'] = 841.23712158203, ['y'] = -1035.4903564453, ['z'] = 27.19486618042, ['heading'] = 0.0 },
	{ ['x'] = 2566.7258300781, ['y'] = 292.41482543945, ['z'] = 107.73485565186, ['heading'] = 0.0 },
	{ ['x'] = -3173.2248535156, ['y'] = 1089.5948486328, ['z'] = 19.838748931885, ['heading'] = 240.0 },
}


for k,v in ipairs(blips)do
	local blip = AddBlipForCoord(v.x, v.y, v.z)
	SetBlipSprite(blip, 110)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Gun store")
	EndTextCommandSetBlipName(blip)
end

local customCam1
local customCam2

local oldPos

local mainShopKeeper

Citizen.CreateThread(function()

	RequestModel(0x9E08633D)
	while not HasModelLoaded(0x9E08633D) do
		Wait(0)
	end

	RequestAnimDict("amb@prop_human_bum_shopping_cart@male@idle_a")
	while not HasAnimDictLoaded("amb@prop_human_bum_shopping_cart@male@idle_a") do
		Wait(0)
	end

	while(curWepShops ~= 11)do
		Wait(0)
	end

	for k,v in ipairs(shop_keepers)do
		local ped = CreatePed(4, 0x9E08633D, v.x, v.y, v.z, v.heading, false, false)
		local pos = GetEntityCoords(ped, false)
		SetBlockingOfNonTemporaryEvents(ped, true)
		SetPedFleeAttributes(ped, 0, 0)
		FreezeEntityPosition(ped, true)
		for e,c in pairs(markers)do
			if(Vdist(pos.x, pos.y, pos.z, c.pos.x, c.pos.y, c.pos.z) < 10.0)then
				markers[e].ped = ped

				if(e == "sandyshores1")then
					mainShopKeeper = ped
				end
			end
		end
		SetEntityInvincible(ped, true)
		TaskPlayAnim(ped,"amb@prop_human_bum_shopping_cart@male@idle_a","idle_a", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	end
end)

local weaponNames = { WEAPON_FIREWORK = "Firework Launcher", WEAPON_PISTOL = "Pistol", WEAPON_SMG = "SMG", WEAPON_MARKSMANPISTOL = "Marksman Rifle", WEAPON_SNSPISTOL = "SNS Pistol", WEAPON_VINTAGEPISTOL = "Vintage Pistol", WEAPON_COMBATPISTOL = "Combat Pistol", WEAPON_HEAVYPISTOL = "Heavy Pistol", WEAPON_HEAVYREVOLVER = "Heavy Revolver", WEAPON_APPISTOL = "AP Pistol", WEAPON_BOTTLE = "Bottle", WEAPON_BAT = "Baseball bat", WEAPON_BAT = "Baseball bat", WEAPON_KNUCKLE = "Knuckle Duster", WEAPON_KNIFE = "Knife", WEAPON_DAGGER = "Dagger", WEAPON_HAMMER = "Hammer", WEAPON_HATCHET = "Hatchet", WEAPON_NIGHTSTICK = "Nightstick", WEAPON_CROWBAR = "Crowbar", WEAPON_GOLFCLUB = "Golfclub", WEAPON_SWITCHBLADE = "Switchblade", WEAPON_MACHETE = "Machete", WEAPON_MICROSMG = "Micro SMG", WEAPON_ASSAULTSMG = "Assault SMG", WEAPON_COMBATPDW = "Combat PDW", WEAPON_MACHINEPISTOL = "Machine Pistol", WEAPON_COMPACTRIFLE = "Compact Rifle", WEAPON_ASSAULTRIFLE = "Assault Rifle", WEAPON_CARBINERIFLE = "Carbine Rifle", WEAPON_BULLPUPRIFLE = "Bullpup Rifle", WEAPON_ADVANCEDRIFLE = "Advanced Rifle", WEAPON_SPECIALCARBINE = "Special Carbine", WEAPON_GUSENBERG = "Gusenberg", WEAPON_MG = "MG", WEAPON_COMBATMG = "Combat MG", WEAPON_SNIPERRIFLE = "Sniper Rifle", WEAPON_MARKSMANRIFLE = "Marksman Rifle", WEAPON_HEAVYSNIPER = "Heavy Sniper", WEAPON_MOLOTOV = "Molotov", WEAPON_FLARE = "Flare", WEAPON_GRENADE = "Grenade", WEAPON_SAWNOFFSHOTGUN = "Sawnoff", WEAPON_PUMPSHOTGUN = "Pump Shotgun", WEAPON_BULLPUPSHOTGUN = "Bullpup Shotgun", WEAPON_HEAVYSHOTGUN = "Heavy Shotgun", WEAPON_ASSAULTSHOTGUN = "Assault Shotgun", WEAPON_SMOKEGRENADE = "Smoke Grenade", WEAPON_PETROLCAN = "Petrol Can", WEAPON_GRENADELAUNCHER_SMOKE = "Smoke Launcher", WEAPON_FIREEXTINGUISHER = "Fire Extinguisher", WEAPON_SNOWBALL = "Snowballs", WEAPON_FLASHLIGHT = "Flashlight", WEAPON_STUNGUN = "Tazer", WEAPON_MUSKET = "Musket", WEAPON_FLAREGUN = "Flaregun" }

function returnIndexesInTable(t)
	local i = 0;
	for _,v in pairs(t)do
 		i = i + 1
	end
	return i;
end


local selectedWeaponBuy = 1
local oldShop
local justLeft = false
local enteredAgain = false

local weapon_locations = {
	WEAPON_SHOTGUN = { ['x'] = 1690.0076904297, ['y'] = 3759.5059570313, ['z'] = 35.8053565979, ['heading'] = 46.0 },
	WEAPON_PISTOL = { ['x'] = 1692.8952636719, ['y'] = 3760.4404785156, ['z'] = 34.905345153809, ['heading'] = 47.5, ['angle'] = -90.0 },
	WEAPON_SMG = { ['x'] = 1689.3076904297, ['y'] = 3758.8059570313, ['z'] = 35.3053565979, ['heading'] = 46.0 },

	WEAPON_UNKNOWN = { ['x'] = 1693.9376220703, ['y'] = 3758.2463378906, ['z'] = 35.705337524414, ['heading'] = 44.0 },
}

local camSelected = ""
local curCam = ""
local curShop = ""

Citizen.CreateThread(function()
	customCam1 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	customCam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)	

	while true do
		Citizen.Wait(0)

		local pos = GetEntityCoords(GetPlayerPed(-1), false)

		local int = GetInteriorAtCoords(pos.x, pos.y, pos.z)

		if(oldShop ~= nil)then
			if(Vdist(markers[oldShop].pos.x, markers[oldShop].pos.y, markers[oldShop].pos.z, pos.x, pos.y, pos.z) > 2.0 and justLeft == true)then
				SetAmbientVoiceName(markers[oldShop].ped, "AMMUCITY")
				PlayAmbientSpeech1(markers[oldShop].ped, "SHOP_GOODBYE", "SPEECH_PARAMS_INTERRUPT")
				justLeft = false
				enteredAgain = true
			end
		end

				if (isBuyingWeapons) then
					SetEntityLocallyInvisible(GetPlayerPed(i), true)
					for i = 0,32 do
						if(NetworkIsPlayerActive(i))then
							if(GetPlayerPed(i) ~= GetPlayerPed(-1))then
								SetEntityVisible(GetPlayerPed(i), true)
							end
						end
					end

						DrawRect(0.402, 0.048, 0.225, 0.08, 0, 0, 0, 235)
						drawTxt(0.79, 0.5, 1.0,1.0,0.81, "Weapons Available", 255, 255, 255, 255)
						drawTxt(0.79, 0.55, 1.0,1.0,0.41, "ID", 200, 200, 200, 255)
						drawTxt(0.955, 0.55, 1.0,1.0,0.41, "Price", 200, 200, 200, 255)
						local t = 0
						for k,v in pairs(weapon_shops[curShop])do
							t = t + 1
							if(t ~= selectedWeaponBuy)then
								DrawRect(0.402, 0.06939 + (t * 0.037),  0.225,  0.037,  100,  100, 100,  200)
							end
							DrawRect(0.402, 0.06939 + (selectedWeaponBuy * 0.037),  0.225,  0.037,  200,  200, 200,  200)
							if(weaponNames[k] == nil)then
								weaponNames[k] = 'undefined'
							end
							drawTxt(0.79, 0.55 + (t * 0.037), 1.0,1.0,0.37, "" .. weaponNames[k], 255, 255, 255, 255, true)
							drawTxt(0.955, 0.55 + (t * 0.037), 1.0,1.0,0.37, "" .. v, 0, 200, 0, 255, false)
						end

						t = t + 1
						if(t ~= selectedWeaponBuy)then
							DrawRect(0.402, 0.06939 + (t * 0.037),  0.225,  0.037,  100,  100, 100,  200)
						end
						DrawRect(0.402, 0.06939 + (selectedWeaponBuy * 0.037),  0.225,  0.037,  200,  200, 200,  200)
						drawTxt(0.79, 0.55 + (t * 0.037), 1.0,1.0,0.37, "Exit", 255, 255, 255, 255, true)

						DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~INPUT_CELLPHONE_RIGHT~ to ~r~buy~w~.")

						DisableControlAction(1, 27, true)
						if(IsControlJustPressed(1, 172)) then -- Up
							PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							if(selectedWeaponBuy ~= 1)then
								selectedWeaponBuy = selectedWeaponBuy - 1
							end
							local sel = 0
							for k,v in pairs(weapon_shops[curShop]) do
								sel = sel + 1
								if(sel == selectedWeaponBuy)then
									if(camSelected ~= k)then
										Citizen.Trace(k .. "_UP\n")
										camSelected = k

										if(weapon_locations[k] == nil)then
											weapon_locations[k] = weapon_locations.WEAPON_UNKNOWN
										end

										if(curCam == "customCam1")then
											SetCamCoord(customCam2,  weapon_locations[k].x, weapon_locations[k].y, weapon_locations[k].z)
										
											SetCamRot(customCam2, 0.0, 0.0, weapon_locations[k].heading,  true)
											if(weapon_locations[k].angle)then
												SetCamRot(customCam2, weapon_locations[k].angle, 0.0, weapon_locations[k].heading,  true)
											end

											SetCamActiveWithInterp(customCam2, customCam1, 500, 1, 1)

											curCam = "customCam2"
										else
											SetCamCoord(customCam1,  weapon_locations[k].x, weapon_locations[k].y, weapon_locations[k].z)
										
											SetCamRot(customCam1, 0.0, 0.0, weapon_locations[k].heading,  true)
											if(weapon_locations[k].angle)then
												SetCamRot(customCam1, weapon_locations[k].angle, 0.0, weapon_locations[k].heading,  true)
											end

											SetCamActiveWithInterp(customCam1, customCam2, 500, 1, 1)	

											curCam = "customCam1"								
										end
									end
								end
							end
						elseif(IsControlJustPressed(1, 173)) then -- Down
							PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							if(selectedWeaponBuy ~= returnIndexesInTable(weapon_shops[curShop]) + 1)then
								selectedWeaponBuy = selectedWeaponBuy + 1
							end
							local sel = 0
							for k,v in pairs(weapon_shops[curShop]) do
								sel = sel + 1
								if(sel == selectedWeaponBuy)then
									if(camSelected ~= k)then
										Citizen.Trace(k .. "_DOWN\n")
										camSelected = k

										if(weapon_locations[k] == nil)then
											weapon_locations[k] = weapon_locations.WEAPON_UNKNOWN
										end

										if(curCam == "customCam1")then
											SetCamCoord(customCam2,  weapon_locations[k].x, weapon_locations[k].y, weapon_locations[k].z)
										
											SetCamRot(customCam2, 0.0, 0.0, weapon_locations[k].heading,  true)
											if(weapon_locations[k].angle)then
												SetCamRot(customCam2, weapon_locations[k].angle, 0.0, weapon_locations[k].heading,  true)
											end

											SetCamActiveWithInterp(customCam2, customCam1, 500, 1, 1)

											curCam = "customCam2"
										else
											SetCamCoord(customCam1,  weapon_locations[k].x, weapon_locations[k].y, weapon_locations[k].z)
										
											SetCamRot(customCam1, 0.0, 0.0, weapon_locations[k].heading,  true)
											if(weapon_locations[k].angle)then
												SetCamRot(customCam1, weapon_locations[k].angle, 0.0, weapon_locations[k].heading,  true)
											end

											SetCamActiveWithInterp(customCam1, customCam2, 500, 1, 1)	

											curCam = "customCam1"									
										end
									end
								end
							end
						elseif(IsControlJustPressed(1, 175)) then -- Right
							local sel = 0
							PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							for k,v in pairs(weapon_shops[curShop]) do
								sel = sel + 1
								if(sel == selectedWeaponBuy)then
									TriggerServerEvent("es_roleplay:buyWeapon", k, mainShopKeeper)
								end
							end

							if(selectedWeaponBuy == returnIndexesInTable(weapon_shops[curShop]) + 1)then
								isBuyingWeapons = false
								RenderScriptCams(0, 0, customCam,  true,  true)
								FreezeEntityPosition(GetPlayerPed(-1), false)

								for i = 0,32 do
									if(NetworkIsPlayerActive(i))then
										if(GetPlayerPed(i) ~= GetPlayerPed(-1))then
											SetEntityVisible(GetPlayerPed(i), true)
										end
									end
								end
								SetEntityLocallyInvisible(GetPlayerPed(i), false)
							end
						end
				end

		for i,e in pairs(markers)do


			if(Vdist(markers[i].pos.x, markers[i].pos.y, markers[i].pos.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, markers[i].pos.x, markers[i].pos.y, markers[i].pos.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, markers[i].color.r, markers[i].color.g, markers[i].color.b,155, 0,0, 0,0)
			end
		
			if(Vdist(markers[i].pos.x, markers[i].pos.y, markers[i].pos.z, pos.x, pos.y, pos.z) < 1.0)then
				if(oldShop ~= i or enteredAgain)then
					SetAmbientVoiceName(markers[i].ped, "AMMUCITY")
					PlayAmbientSpeech1(markers[i].ped, "SHOP_GREET", "SPEECH_PARAMS_INTERRUPT")

					oldShop = i
					selectedWeaponBuy = 1
					justLeft = true
					enteredAgain = false
				end

				if(not isBuyingWeapons)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to buy ~HUD_COLOUR_RED~weapons~HUD_COLOUR_WHITE~.")

					if(IsControlJustReleased(1, 51))then
						curShop = i

						FreezeEntityPosition(GetPlayerPed(-1), true)
						curCam = "customCam1"
						isBuyingWeapons = true

						local int = GetInteriorAtCoords(weapon_locations.WEAPON_UNKNOWN.x, weapon_locations.WEAPON_UNKNOWN.y, weapon_locations.WEAPON_UNKNOWN.z)
						Citizen.InvokeNative(0x2CA429C029CCF247, int)
							local sel = 0
							for k,v in pairs(weapon_shops[i]) do
								sel = sel + 1
								if(sel == selectedWeaponBuy)then
									if(camSelected ~= k)then
										Citizen.Trace(k .. "_UP\n")
										camSelected = k

										if(weapon_locations[k] == nil)then
											weapon_locations[k] = weapon_locations.WEAPON_UNKNOWN
										end

										SetCamCoord(customCam2,  weapon_locations[k].x, weapon_locations[k].y, weapon_locations[k].z)
										
										SetCamRot(customCam2, 0.0, 0.0, weapon_locations[k].heading,  true)
										if(weapon_locations[k].angle)then
											SetCamRot(customCam2, weapon_locations[k].angle, 0.0, weapon_locations[k].heading,  true)
										end
										SetCamActive(customCam2, true)

										curCam = "customCam2"
									end
								end
							end

						RenderScriptCams(1, 0, customCam1,  true,  true)
					end
				end

			end
		end
	end
end)

RegisterNetEvent("es_miscstores:clerkSpeech")
AddEventHandler("es_miscstores:clerkSpeech", function(id, sid)
	SetAmbientVoiceName(id, "AMMUCITY")

	if(sid == 1)then
		PlayAmbientSpeech1(id, "GENERIC_THANKS", "SPEECH_PARAMS_INTERRUPT")
	elseif(sid == 2)then
		PlayAmbientSpeech1(id, "GENERIC_INSULT_HIGH", "SPEECH_PARAMS_INTERRUPT")
	elseif(sid == 3)then
		PlayAmbientSpeech1(id, "SHOP_OUT_OF_STOCK", "SPEECH_PARAMS_INTERRUPT")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		for k,v in ipairs(weapons) do
			local hash = GetHashKey(v)

			SetPedInfiniteAmmo(GetPlayerPed(-1), true, hash)
			GiveDelayedWeaponToPed(GetPlayerPed(-1), hash, 0, false)
		end
	end
end)