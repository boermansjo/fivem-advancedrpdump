local DrugDealers = {
	['matthew'] = {
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
		pos = { ['x'] = 1177.1647949219, ['y'] = 2722.220703125, ['z'] = 38.004173278809 },
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
		pos = { ['x'] = -1724.7882080078, ['y'] = 234.66094970703, ['z'] = 58.471710205078 },
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
		ped = { ['heading'] = 0.0, ['model'] = 0x54DBEE1F --[[a_m_m_bevhills_01]] },
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
		name = "T. Varent",
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

function returnIndexesInTable(t)
	local i = 0;
	for _,v in pairs(t)do
 		i = i + 1
	end
	return i;
end

local function randomDrugEvent()
	math.randomseed(os.time())
	math.random(); math.random(); math.random()
	SetTimeout(math.random(600000, 900000), function()
		local keyset = {}
		for k in pairs(DrugDealers) do
		    table.insert(keyset, k)
		end

		math.randomseed(os.time())
		math.random(); math.random(); math.random()
		local dealer = keyset[math.random(#keyset + 1)]


		local keyset = {}
		for k in pairs(DrugDealers[dealer].sells) do
		    table.insert(keyset, k)
		end

		math.randomseed(os.time())
		math.random(); math.random(); math.random()
		local drug = keyset[math.random(#keyset + 1)]


		math.randomseed(os.time())
		math.random(); math.random(); math.random()

		local type = math.random(3)

		if(type == 1)then
			if (DrugDealers[dealer].RatesSell[drug] * 0.85) < DrugDealers[dealer].NormalizationSell[drug] then
				DrugDealers[dealer].RatesSell[drug] = math.ceil(DrugDealers[dealer].NormalizationSell[drug] * 0.85)
			else
				DrugDealers[dealer].RatesSell[drug] = DrugDealers[dealer].NormalizationSell[drug]
			end

			TriggerClientEvent("chatMessage", -1, "DEALERS", {255, 0, 0}, "^2^*" .. DrugDealers[dealer].name .. "^0^r is selling ^2^*" .. DrugNames[drug] .. "^r^0 for extremely low prices!")
			TriggerClientEvent("es_miscstores:setDrugRates", -1, dealer, DrugDealers[dealer].RatesBuy, DrugDealers[dealer].RatesSell)
		else
			DrugDealers[dealer].RatesBuy[drug] = math.ceil(DrugDealers[dealer].RatesBuy[drug] * 1.20)
		
			TriggerClientEvent("chatMessage", -1, "DEALERS", {255, 0, 0}, "^2^*" .. DrugDealers[dealer].name .. "^0^r is buying ^2^*" .. DrugNames[drug] .. "^r^0 for extremely high prices!")
			TriggerClientEvent("es_miscstores:setDrugRates", -1, dealer, DrugDealers[dealer].RatesBuy, DrugDealers[dealer].RatesSell)
		end
		randomDrugEvent()
	end)
end
randomDrugEvent()

function normalizationPrices()
	SetTimeout(15000000, function()
		TriggerClientEvent("chatMessage", -1, "DEALERS", {255, 0, 0}, "Dealer prices will be normalized in: ^2^*5 minutes.")

		SetTimeout(300000, function()
			for k,v in pairs(DrugDealers) do
				DrugDealers[k].RatesBuy = v.NormalizationBuy
				DrugDealers[k].RatesSell = v.NormalizationSell


				TriggerClientEvent("es_miscstores:setDrugRatesAll", -1, k)
			end

			TriggerClientEvent("chatMessage", -1, "DEALERS", {255, 0, 0}, "Supply & Demand of all dealers have been normalized.")

			normalizationPrices()
		end)
	end)
end
normalizationPrices()

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end


local tHandle = type
RegisterServerEvent("es_miscstores:buySellDrug")
AddEventHandler("es_miscstores:buySellDrug", function(dealer, type, drug)

	if(DrugDealers[dealer] == nil)then
		return
	end

	if(type == "buy")then
		if(DrugDealers[dealer].sells[drug] == nil)then
			return
		end
	elseif(type == "sell")then
		if(DrugDealers[dealer].buys[drug] == nil)then
			return
		end
	else
		return
	end

	TriggerEvent("es:getPlayerFromId", source, function(user)
		local dPos = DrugDealers[dealer].pos
		if(get3DDistance(user.coords.x, user.coords.y, user.coords.z, dPos.x, dPos.y, dPos.z) > 10.0)then
			return
		end

		if(type == "sell")then
			if(user:getSessionVar("drugs:" .. drug))then
				if(user:getSessionVar("drugs:"  .. drug) > 0)then
					local sellPrice = DrugDealers[dealer].RatesBuy[drug]

					if(math.ceil(DrugDealers[dealer].RatesBuy[drug] - (DrugDealers[dealer].RatesBuy[drug] * 0.01)) > DrugDealers[dealer].NormalizationBuy[drug])then
						DrugDealers[dealer].RatesBuy[drug] = math.ceil(DrugDealers[dealer].RatesBuy[drug] - (DrugDealers[dealer].RatesBuy[drug] * 0.01))
					else
						DrugDealers[dealer].RatesBuy[drug] = DrugDealers[dealer].NormalizationBuy[drug]
					end

					if(math.ceil(DrugDealers[dealer].RatesSell[drug] - (DrugDealers[dealer].RatesSell[drug] * 0.02)) > DrugDealers[dealer].NormalizationSell[drug])then
						DrugDealers[dealer].RatesSell[drug] = math.ceil(DrugDealers[dealer].RatesSell[drug] - (DrugDealers[dealer].RatesSell[drug] * 0.02))
					else
						DrugDealers[dealer].RatesSell[drug] = DrugDealers[dealer].NormalizationSell[drug]
					end

					TriggerClientEvent("chatMessage", source, "" .. DrugDealers[dealer].name, {255, 0, 0}, "You sold ^2^*" .. DrugNames[drug] .. "^0^r for ^2^*" .. sellPrice)
					TriggerClientEvent("es_miscstores:setDrugRates", -1, dealer, DrugDealers[dealer].RatesBuy, DrugDealers[dealer].RatesSell)
					TriggerClientEvent("es_miscstores:updateInventory", source, drug, user:getSessionVar("drugs:" .. drug) - 1)

					user:setSessionVar("drugs:" .. drug, user:getSessionVar("drugs:" .. drug) - 1)

					user:addMoney(sellPrice, function() end)
				else
					TriggerClientEvent("chatMessage", source, "" .. DrugDealers[dealer].name, {255, 0, 0}, "You do not have ^2^*" .. DrugNames[drug] .. "^0^r in your inventory.")
				end
			else
				TriggerClientEvent("chatMessage", source, "" .. DrugDealers[dealer].name, {255, 0, 0}, "You do not have ^2^*" .. DrugNames[drug] .. "^0^r in your inventory.")
			end
		else
			local buyPrice = DrugDealers[dealer].RatesSell[drug]

			if(user.money + 0.0 > buyPrice)then
				user:removeMoney(buyPrice, function() end)

				DrugDealers[dealer].RatesBuy[drug] = math.ceil(DrugDealers[dealer].RatesBuy[drug] * 1.008)
				DrugDealers[dealer].RatesSell[drug] = math.ceil(DrugDealers[dealer].RatesSell[drug] * 1.010)

				TriggerClientEvent("es_miscstores:setDrugRates", -1, dealer, DrugDealers[dealer].RatesBuy, DrugDealers[dealer].RatesSell)

				if(user:getSessionVar("drugs:" .. drug))then
					user:setSessionVar("drugs:" .. drug, user:getSessionVar("drugs:" .. drug) + 1)
				else
					user:setSessionVar("drugs:" .. drug, 1)
				end

				TriggerClientEvent("es_miscstores:updateInventory", source, drug, user:getSessionVar("drugs:" .. drug))

				TriggerClientEvent("chatMessage", source, "" .. DrugDealers[dealer].name, {255, 0, 0}, "You bought ^2^*" .. DrugNames[drug] .. "^0^r for ^2^*" .. buyPrice)
			else
				TriggerClientEvent("chatMessage", source, "" .. DrugDealers[dealer].name, {255, 0, 0}, "You don't have enough money to buy ^2^*" .. DrugNames[drug] .. "^0^r for ^2^*" .. buyPrice)
			end
		end	
	end)
end)