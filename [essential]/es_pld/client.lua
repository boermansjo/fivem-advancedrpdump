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

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 

local ranks = {
	{rank = 1, tag = "~b~Mod"},
	{rank = 3, tag = "~r~Admin"},
	{rank = 5, tag = "~r~Head-Admin"},
	{rank = 7, tag = "~y~Dev"}
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local pos = GetEntityCoords(GetPlayerPed(-1))
		local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())

		for k,v in pairs(directions)do
			direction = GetEntityHeading(GetPlayerPed(-1))
			if(math.abs(direction - k) < 22.5)then
				direction = v
				break;
			end
		end

		local posme = GetEntityCoords(GetPlayerPed(-1), false)

		for i = 0,32 do
			if(NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= GetPlayerPed(-1))then
				if(HasEntityClearLosToEntity(GetPlayerPed(-1), GetPlayerPed(i), 17) and IsEntityVisible(GetPlayerPed(i)))then
					local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(i), 0, 0, 1.4)
					
					if(Vdist(pos.x, pos.y, pos.z, posme.x, posme.y, posme.z) < 10.0)then
						local x,y,z = World3dToScreen2d(pos.x, pos.y, pos.z)

						SetTextFont(11)
						SetTextScale(0.0, 0.40)
						SetTextColour(255, 255, 255, 255);
						SetTextDropShadow(5, 0, 78, 255, 255);
						SetTextEdge(0, 0, 0, 0, 0);
						SetTextEntry("STRING");
						SetTextCentre(1)
						AddTextComponentString(GetPlayerServerId(i) .. " | " .. GetPlayerName(i))
						DrawText(y, z)

						if(DecorExistOn(GetPlayerPed(i), 'rank'))then
							local rank = DecorGetInt(GetPlayerPed(i), 'rank')
							if(rank ~= false)then
								pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(i), 0, 0, 1.6)
								x,y,z = World3dToScreen2d(pos.x, pos.y, pos.z)

								SetTextFont(11)
								SetTextScale(0.0, 0.40)
								SetTextColour(255, 255, 255, 255);
								SetTextDropShadow(5, 0, 78, 255, 255);
								SetTextEdge(0, 0, 0, 0, 0);
								SetTextEntry("STRING");
								SetTextCentre(1)
								
								local tag = ""
								for e,c in ipairs(ranks)do
									if(rank >= c.rank)then
										tag = c.tag
									end
								end
								AddTextComponentString("" .. tag)
								DrawText(y, z)
								SetTextOutline()	
							end						
						end
					end
				end
			end
		end

		if(var2 ~= 0)then
			drawTxt(0.555, 1.25, 1.0,1.0,0.4, "Crossing ~y~" .. tostring(GetStreetNameFromHashKey(var2)) .. "~w~", 255, 255, 255, 255)
		end

		if(GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z))then
			if(zones[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1)))then
				drawTxt(0.555, 1.22, 1.0,1.0,0.4, "~b~" .. tostring(GetStreetNameFromHashKey(var1)) .. " ~w~in ~y~" .. zones[GetNameOfZone(pos.x, pos.y, pos.z)], 255, 255, 255, 255)
			end
		end

		if(direction)then
			if(#direction == 1)then
				drawTxt(0.515, 1.2195, 1.0, 1.0, 0.9, direction, 255, 255, 255, 255)
			else
				drawTxt(0.515, 1.2195, 1.0, 1.0, 0.9, string.sub(direction, 1,1), 255, 255, 255, 255)
				drawTxt(0.535, 1.2395, 1.0, 1.0, 0.5, string.sub(direction, 2), 255, 255, 255, 255)
			end
		end

		local t = 0
			for i = 0,32 do
				if(GetPlayerName(i))then
					if(NetworkIsPlayerTalking(i))then
						t = t + 1

						if(t == 1)then
								drawTxt(0.515, 0.95, 1.0,1.0,0.4, "~y~Talking", 255, 255, 255, 255)
						end

						drawTxt(0.520, 0.95 + (t * 0.023), 1.0,1.0,0.4, GetPlayerServerId(i) .. " | " .. GetPlayerName(i), 255, 255, 255, 255)
					end
				end
			end

		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) then
				if not HasStreamedTextureDictLoaded("speedo") then
					RequestStreamedTextureDict("speedo", true) -- unload it
					while not HasStreamedTextureDictLoaded("speedo") do
						Wait(0)
					end
				else
					-- everything is ok
					local degree = 0
					local step = 2.05833
					if GetEntitySpeed(vehicle) > 0 then degree=(GetEntitySpeed(vehicle)*2.236936)*step end
					DrawSprite("speedo", "speedom_003", 0.898,0.752,0.16,0.245, 0.0, 255, 255, 255, 255)
					if degree > 247 then degree=247 end
					DrawSprite("speedo", "needle_003", 0.898,0.755,0.116,0.15,43.00001+degree, 255, 255, 255, 200)
					if IsControlPressed(1, 216) then DrawSprite("speedo", "brakeson_001", 0.83,0.815,0.02,0.025, 0.0, 255, 255, 255, 255)
					else DrawSprite("speedo", "brakeson_002", 0.83,0.815,0.02,0.025, 0.0, 255, 255, 255, 255) end
				end
			end
		end
	end
end)