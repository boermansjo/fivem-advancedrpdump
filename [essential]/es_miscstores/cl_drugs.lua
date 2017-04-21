local DrugDealers = {
	['matthew'] = {
		ped = { ['heading'] = 20.0, ['model'] = 0xE497BBEF --[[s_m_y_dealer_01]] },
		pos = { ['x'] = 1640.7264404297, ['y'] = 3730.9936523438, ['z'] = 34.067134857178 },
		name = "Matthew",
		buys = {
			weed = true,
			acid = true,
			xtc = true
		},
		sells = {
			weed = true,
			acid = true,
			xtc = true
		},
		prefferedBuy = "",
		prefferedSell = "",
		RatesSell = {
			weed = 500,
			acid = 600,
			xtc = 500
		},
		RatesBuy = {
			weed = 400,
			acid = 500,
			xtc = 400
		},
		NormalizationSell = {
			weed = 500,
			acid = 600,
			xtc = 500
		},
		NormalizationBuy = {
			weed = 400,
			acid = 500,
			xtc = 400
		},
	},
	['nick'] = {
		ped = { ['heading'] = 330.0, ['model'] = 0xE497BBEF --[[s_m_y_dealer_01]] },
		pos = { ['x'] = 1177.1647949219, ['y'] = 2723.220703125, ['z'] = 37.004173278809 },
		name = "Nick",
		buys = {
			weed = true,
			cocaine = true
		},
		sells = {
			weed = true,
			cocaine = true
		},
		prefferedBuy = "weed",
		prefferedSell = "cocaine",
		RatesSell = {
			weed = 600,
			cocaine = 1000
		},
		RatesBuy = {
			weed = 500,
			cocaine = 900
		},
		NormalizationSell = {
			weed = 600,
			cocaine = 1000
		},
		NormalizationBuy = {
			weed = 500,
			cocaine = 900
		},
	},
	['alexanderkuhta'] = {
		ped = { ['heading'] = 20.0, ['model'] = 0x46521A32 --[[cs_russiandrunk]] },
		pos = { ['x'] = -1724.7882080078, ['y'] = 234.66094970703, ['z'] = 57.471710205078 },
		name = "A. Kuhta",
		buys = {
			meth = true,
			cocaine = true,
			weed = true
		},
		sells = {
			meth = true,
			cocaine = true,
			weed = true
		},
		prefferedBuy = "cocaine",
		prefferedSell = "meth",
		RatesSell = {
			meth = 400,
			cocaine = 800,
			weed = 500
		},
		RatesBuy = {
			meth = 350,
			cocaine = 500,
			weed = 400,
		},
		NormalizationSell = {
			meth = 400,
			cocaine = 800,
			weed = 500,
		},
		NormalizationBuy = {
			meth = 350,
			cocaine = 500,
			weed = 400,
		},
	},
	['varent'] = {
		ped = { ['heading'] = 0.0, ['model'] = 0x54DBEE1F --[[a_f_m_bevhills_01]] },
		pos = { ['x'] = -761.85791015625, ['y'] = 351.92532348633, ['z'] = 86.998001098633 },
		name = "T. Varent",
		buys = {
			meth = true,
			cocaine = true,
			acid = true
		},
		sells = {
			meth = true,
			cocaine = true,
			acid = true
		},
		prefferedBuy = "cocaine",
		prefferedSell = "acid",
		RatesSell = {
			meth = 600,
			cocaine = 900,
			acid = 1100
		},
		RatesBuy = {
			meth = 500,
			cocaine = 750,
			acid = 800
		},
		NormalizationSell = {
			meth = 600,
			cocaine = 900,
			acid = 1100
		},
		NormalizationBuy = {
			meth = 500,
			cocaine = 750,
			acid = 800
		},
	},
	['0x420'] = {
		ped = { ['heading'] = 280.0, ['model'] = 0x23B88069 --[[g_f_y_ballas_01]] },
		pos = { ['x'] = 77.885513305664, ['y'] = -1948.2086181641, ['z'] = 20.174139022827 },
		name = "Rob",
		buys = {
			weed = true,
			xtc = true
		},
		sells = {
			weed = true,
			xtc = true
		},
		prefferedBuy = "cocaine",
		prefferedSell = "acid",
		RatesSell = {
			weed = 400,
			xtc = 500
		},
		RatesBuy = {
			weed = 200,
			xtc = 300
		},
		NormalizationSell = {
			weed = 400,
			xtc = 500
		},
		NormalizationBuy = {
			weed = 200,
			xtc = 300
		},
	},
	['marythomas'] = {
		ped = { ['heading'] = 200.0, ['model'] = 0x4E0CE5D3 --[[g_f_y_ballas_01]] },
		pos = { ['x'] = -224.3656463623, ['y'] = -1667.0147705078, ['z'] = 36.636913299561 },
		name = "M. Thomas",
		buys = {
			weed = true,
			xtc = true,
			acid = true
		},
		sells = {
			weed = true,
			xtc = true,
			acid = true
		},
		prefferedBuy = "cocaine",
		prefferedSell = "acid",
		RatesSell = {
			weed = 300,
			xtc = 400,
			acid = 500,
		},
		RatesBuy = {
			weed = 100,
			xtc = 200,
			acid = 350
		},
		NormalizationSell = {
			weed = 300,
			xtc = 400,
			acid = 500,
		},
		NormalizationBuy = {
			weed = 100,
			xtc = 200,
			acid = 350
		},
	},
	['alicia'] = {
		ped = { ['heading'] = 280.0, ['model'] = 0x5D71A46F --[[s_f_y_airhostess_01]] },
		pos = { ['x'] = -979.21936035156, ['y'] = -2679.1882324219, ['z'] = 35.604850769043 },
		name = "Alicia",
		buys = {
			xtc = true,
			acid = true
		},
		sells = {
			xtc = true,
			acid = true
		},
		prefferedBuy = "cocaine",
		prefferedSell = "acid",
		RatesSell = {
			xtc = 800,
			acid = 600,
		},
		RatesBuy = {
			xtc = 600,
			acid = 550
		},
		NormalizationSell = {
			xtc = 800,
			acid = 600,
		},
		NormalizationBuy = {
			xtc = 600,
			acid = 550
		},
	},
	['kanersps'] = {
		ped = { ['heading'] = 100.0, ['model'] = 0xF1E823A2 --[[s_f_y_airhostess_01]] },
		pos = { ['x'] = 1222.0125732422, ['y'] = -2920.1618652344, ['z'] = 4.8660640716553 },
		name = "Kane M.",
		buys = {
			xtc = true,
			acid = true,
			weed = true,
			cocaine = true,
			meth = true
		},
		sells = {
			xtc = true,
			acid = true,
			weed = true,
			cocaine = true,
			meth = true
		},
		prefferedBuy = "cocaine",
		prefferedSell = "acid",
		RatesSell = {
			xtc = 1000,
			acid = 700,
			weed = 700,
			cocaine = 1100,
			meth = 1200,
		},
		RatesBuy = {
			xtc = 800,
			acid = 500,
			weed = 500,
			cocaine = 900,
			meth = 1000,
		},
		NormalizationSell = {
			xtc = 1000,
			acid = 700,
			weed = 700,
			cocaine = 1100,
			meth = 1200,
		},
		NormalizationBuy = {
			xtc = 800,
			acid = 500,
			weed = 500,
			cocaine = 900,
			meth = 1000,
		},
	},
	['liam'] = {
		ped = { ['heading'] = 40.0, ['model'] = 0xF1E823A2 --[[s_f_y_airhostess_01]] },
		pos = { ['x'] = 1302.6696777344, ['y'] = 4226.1025390625, ['z'] = 32.908679962158 },
		name = "Liam",
		buys = {
			xtc = true,
			acid = true,
			weed = true,
			cocaine = true,
			meth = true
		},
		sells = {
			xtc = true,
			acid = true,
			weed = true,
			cocaine = true,
			meth = true
		},
		prefferedBuy = "cocaine",
		prefferedSell = "acid",
		RatesSell = {
			xtc = 900,
			acid = 800,
			weed = 800,
			cocaine = 1000,
			meth = 1100,
		},
		RatesBuy = {
			xtc = 700,
			acid = 600,
			weed = 600,
			cocaine = 800,
			meth = 900,
		},
		NormalizationSell = {
			xtc = 900,
			acid = 800,
			weed = 800,
			cocaine = 1000,
			meth = 1100,
		},
		NormalizationBuy = {
			xtc = 700,
			acid = 600,
			weed = 600,
			cocaine = 800,
			meth = 900,
		},
	} 
}

local DrugNames = {weed = "Weed", cocaine = "Cocaine", meth = "Meth", acid = "Acid", xtc = "XTC"}
local DrugInventory = {	{drug = 'weed', amount = 0}, {drug = 'cocaine', amount = 0}, {drug = 'meth', amount = 0}, {drug = 'acid', amount = 0}, {drug = 'xtc', amount = 0} }

RegisterNetEvent("es_miscstores:setDrugRates")
AddEventHandler("es_miscstores:setDrugRates", function(dealer, rateBuy, rateSell)
	DrugDealers[dealer].RatesBuy = rateBuy
	DrugDealers[dealer].RatesSell = rateSell
end)

RegisterNetEvent("es_miscstores:setDrugRatesAll")
AddEventHandler("es_miscstores:setDrugRatesAll", function(dealer)
	DrugDealers[dealer].RatesBuy = DrugDealers[dealer].NormalizationBuy
	DrugDealers[dealer].RatesSell = DrugDealers[dealer].NormalizationSell
end)

RegisterNetEvent("es_miscstores:updateInventory")
AddEventHandler("es_miscstores:updateInventory", function(item, value)
	for k,v in ipairs(DrugInventory) do
		if(v.drug == item)then
			DrugInventory[k].amount = value
		end
	end
end)

local function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline, center, bcolour)
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

local inMenu = false
local dealer = ""
local selected = 1
local options = {}
local allowedToHold = false
local allowedToHoldNow = false
local firstEnter = true

Citizen.CreateThread(function()
	for k,v in pairs(DrugDealers) do
		while not HasModelLoaded(v.ped.model) do
			RequestModel(v.ped.model)
			Citizen.Wait(0)
		end
		local ped = CreatePed(4, v.ped.model, v.pos.x, v.pos.y, v.pos.z, v.ped.heading, false, false)
		local pos = GetEntityCoords(ped, false)
		SetBlockingOfNonTemporaryEvents(ped, true)
		SetPedFleeAttributes(ped, 0, 0)
		SetPedCombatAttributes(ped, 17, 1)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)

		DrugDealers[k].ped = ped

		TaskSetBlockingOfNonTemporaryEvents(ped, true)
	end



	while true do
		Citizen.Wait(0)

		local pos = GetEntityCoords(GetPlayerPed(-1), false)

		for k,v in pairs(DrugDealers) do
			TaskStandStill(DrugDealers[k].ped, 100)
			SetEntityCoords(DrugDealers[k].ped,  DrugDealers[k].pos.x,  DrugDealers[k].pos.y,  DrugDealers[k].pos.z)
			if(Vdist(v.pos.x, v.pos.y, v.pos.z, pos.x, pos.y, pos.z) < 1.5)then
				if(not inMenu)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to trade with this dealer.")

					if(IsControlJustPressed(1, 51))then
						selected = 1
						dealer = k
						inMenu = true
					end
				end
			end

			if(Vdist(v.pos.x, v.pos.y, v.pos.z, pos.x, pos.y, pos.z) < 6.0)then
				drawTxt(0.505, 1.17, 1.0,1.0,0.6, "You are currently in a safezone", 255, 255, 255, 255)

				SetCurrentPedWeapon(GetPlayerPed(-1),  0xA2719263, true)
				SetEntityInvincible(GetPlayerPed(-1), true)

				if(firstEnter)then
					dealer = k
					
					PlayAmbientSpeech2(DrugDealers[k].ped, "GENERIC_HI", "SPEECH_PARAMS_INTERRUPT")

					firstEnter = false
				end
			end
		end

		if(not inMenu)then
			if(DrugDealers[dealer])then
				local dest = DrugDealers[dealer].pos
				if(Vdist(dest.x, dest.y, dest.z, pos.x, pos.y, pos.z) > 6.0 and not firstEnter)then
					SetEntityInvincible(GetPlayerPed(-1), false)

					firstEnter = true
				end
			end
		end

		if inMenu then
			local dest = DrugDealers[dealer].pos
			if(Vdist(dest.x, dest.y, dest.z, pos.x, pos.y, pos.z) > 2.5)then
				inMenu = false
			end

			DisplayHelpText("Controls ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ ~INPUT_CELLPHONE_RIGHT~ ~INPUT_CELLPHONE_LEFT~")

			local t = 0

			DisableControlAction(1, 27, true)

			DrawRect(0.4405, 0.149, 0.302, 0.10, 0, 0, 0, 235)
			drawTxt(0.944, 0.606, 1.0,1.0,0.81, "" .. DrugDealers[dealer].name, 255, 255, 255, 255, false, true)
			drawTxt(0.79, 0.66, 1.0,1.0,0.41, "Drug", 200, 200, 200, 255)
			drawTxt(0.955, 0.66, 1.0,1.0,0.41, "Buy", 200, 200, 200, 255)
			drawTxt(1.030, 0.66, 1.0,1.0,0.41, "Sell", 200, 200, 200, 255)

			DrawRect(0.152 --[[-0.35]], 0.149 --[[+0.1]], 0.225, 0.1, 0, 0, 0, 235)
			drawTxt(0.657, 0.606, 1.0,1.0,0.81, "Inventory", 255, 255, 255, 255, false, true)
			 
			drawTxt(0.546, 0.66, 1.0,1.0,0.41, "Drug", 200, 200, 200, 255)
			drawTxt(0.711, 0.66, 1.0,1.0,0.41, "Amount", 200, 200, 200, 255)		

			local q = 0
			for k,v in ipairs(DrugInventory) do
				q = q + 1
				DrawRect(0.152, 0.17939 + (q * 0.037),  0.225,  0.037,  65,  65, 65,  200)
				-- 0.244
				drawTxt(0.546, 0.66 + (q * 0.037), 1.0,1.0,0.37, "" .. DrugNames[v.drug], 255, 255, 255, 255, true)
				drawTxt(0.735, 0.66 + (q * 0.037), 1.0,1.0,0.37, "" .. v.amount, 200, 200, 200, 255, true, true)
			end

			options = {}

			for c,e in pairs(DrugDealers[dealer].buys)do
				t = t + 1
				if(t ~= selected)then
					DrawRect(0.4405, 0.17939 + (t * 0.037),  0.302,  0.037,  100,  100, 100,  200)
				end

				DrawRect(0.4405, 0.17939 + (selected * 0.037),  0.302,  0.037,  200,  200, 200,  200)
				drawTxt(0.79, 0.66 + (t * 0.037), 1.0,1.0,0.37, "" .. DrugNames[c], 255, 255, 255, 255, true)
				drawTxt(0.955, 0.66 + (t * 0.037), 1.0,1.0,0.37, "" .. DrugDealers[dealer].RatesSell[c], 0, 100, 0, 255, false)
				drawTxt(1.030, 0.66 + (t * 0.037), 1.0,1.0,0.37, "" .. DrugDealers[dealer].RatesBuy[c], 100, 0, 0, 255, false)

				options[#options + 1] = {item = c, price = DrugDealers[dealer].RatesBuy[c]}
			end

			if(IsControlJustPressed(1, 172)) then -- Up
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if(selected ~= 1)then
					selected = selected - 1
				end
			elseif(IsControlJustPressed(1, 173)) then -- Down
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if(selected ~= (returnIndexesInTable(DrugDealers[dealer].sells)))then
					selected = selected + 1
				end
			elseif(IsControlJustPressed(1, 175)) then -- Right
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

				TriggerServerEvent("es_miscstores:buySellDrug", dealer, "buy", options[selected].item)

				allowedToHold = true
			elseif(IsControlJustPressed(1, 174)) then -- Left
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

				TriggerServerEvent("es_miscstores:buySellDrug", dealer, "sell", options[selected].item)

				allowedToHold = true
			end

			if(IsControlJustReleased(1,  174) or IsControlJustReleased(1,  175))then
				allowedToHold = false
				allowedToHoldNow = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if(allowedToHold)then
			Citizen.Wait(500)
			allowedToHoldNow = true

			allowedToHold = false
		end

		if inMenu and allowedToHoldNow then
			if(IsControlPressed(1, 175)) then -- Right
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

				TriggerServerEvent("es_miscstores:buySellDrug", dealer, "buy", options[selected].item)
			elseif(IsControlPressed(1, 174)) then -- Left
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

				TriggerServerEvent("es_miscstores:buySellDrug", dealer, "sell", options[selected].item)
			end
		end
	end
end)