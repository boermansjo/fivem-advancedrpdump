local myStats = {}
myStats.shotsFired = 0
myStats.kmDriven = 0

RegisterNetEvent("es_stats:sendStats")
AddEventHandler("es_stats:sendStats", function(type, stats)
	myStats[type] = stats[GetPlayerServerId(PlayerId())]

	Citizen.Trace(myStats[type] .. "\n")
end)

local oldPos
local oldVehicle
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsPedShooting(GetPlayerPed(-1)))then
			myStats.shotsFired = myStats.shotsFired + 1
		end
	end
end)

myStats.kmDriven = 0
Citizen.CreateThread(function()
	while true do
		if(IsPedInAnyVehicle(GetPlayerPed(-1), false))then
		local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if(GetPedInVehicleSeat(veh,  -1) == GetPlayerPed(-1))then
				local pos = GetEntityCoords(GetPlayerPed(-1), false)

				if oldPos and oldVehicle == veh then
					if(math.floor(Vdist2(oldPos.x, oldPos.y, oldPos.z,  pos.x,  pos.y,  pos.z)) > 0.0)then
						myStats.kmDriven = myStats.kmDriven + (math.floor(Vdist(oldPos.x, oldPos.y, oldPos.z,  pos.x,  pos.y,  pos.z)) / 1000)
					end

					oldPos = pos
				else
					oldPos = pos
					oldVehicle = veh
				end
			end
		end

		Citizen.Wait(5000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)

		TriggerServerEvent("es_stats:shotsFired", myStats.shotsFired)
		myStats.shotsFired = 0

		TriggerServerEvent("es_stats:kmDriven", myStats.kmDriven)
		myStats.kmDriven = 0
	end
end)