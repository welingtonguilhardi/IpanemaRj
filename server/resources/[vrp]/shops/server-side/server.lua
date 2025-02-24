-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("shops",cnVRP)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["departamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 10,
			["cigarette"] = 75,
			["dewars"] = 215,
			["emptybottle"] = 650,
			["hennessy"] = 215,
			["roupas"] = 5000,
			["tires"] = 500,
			["cellbattery"] = 200,
			["toolbox"] = 3500
		}
	},
	["ammunationStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_BAT"] = 40000,
			["WEAPON_MACHETE"] = 40000,
			["WEAPON_FLASHLIGHT"] = 40000,
			["WEAPON_HATCHET"] = 7000,
			["WEAPON_BATTLEAXE"] = 40000,
			["WEAPON_STONE_HATCHET"] = 40000,
			["WEAPON_HAMMER"] = 40000,
			["GADGET_PARACHUTE"] = 40000,
			["WEAPON_KNUCKLE"] = 40000,
			["WEAPON_GOLFCLUB"] = 40000,
			["WEAPON_POOLCUE"] = 40000
		}
	},
	["normalpharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["adrenaline"] = 40000,
			["analgesic"] = 1005,
			["bandage"] = 2025,
			["gauze"] = 1705,
			["warfarin"] = 525,
			["ritmoneury"] = 475,
			["sinkalmy"] = 325
		}
	},
	["hospitalpharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["adrenaline"] = 40000,
			["analgesic"] = 550,
			["bandage"] = 1005,
			["gauze"] = 105,
			["warfarin"] = 225,
			["ritmoneury"] = 275,
			["sinkalmy"] = 120
		}
	},
	["premiumStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["backpack"] = 7000,
			["cellphone"] = 3000,
			["radio"] = 2500,
			["WEAPON_BAT"] = 40000,
			["WEAPON_MACHETE"] = 40000,
			["WEAPON_FLASHLIGHT"] = 40000,
			["WEAPON_HATCHET"] = 10000,
			["WEAPON_BATTLEAXE"] = 40000,
			["WEAPON_STONE_HATCHET"] = 40000,
			["WEAPON_HAMMER"] = 40000,
			["GADGET_PARACHUTE"] = 40000,
			["WEAPON_KNUCKLE"] = 40000,
			["WEAPON_GOLFCLUB"] = 40000,
			["WEAPON_POOLCUE"] = 40000
		}
	},
	["jewelryStore"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["ametista"] = 22,
			["diamante"] = 26,
			["esmeralda"] = 30,
			["rubi"] = 22,
			["safira"] = 20,
			["turquesa"] = 20,
			["ambar"] = 20
		}
	},
	["huntingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_SWITCHBLADE"] = 15000,
			["WEAPON_MUSKET_AMMO"] = 70,
			["WEAPON_MUSKET"] = 3250
		}
	},
	["restauranteStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 20,
			["hamburger"] = 40,
			["chocolate"] = 50

		}
	},
	["fishingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 10,
			["fishingrod"] = 5000
		}
	},
	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["shrimp"] = 50,
			["octopus"] = 45,
			["carp"] = 40
		}
	},
	["recyclingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["plastic"] = 15,
			["glass"] = 15,
			["rubber"] = 15,
			["aluminum"] = 20,
			["copper"] = 20,
			["eletronics"] = 20,
			["emptybottle"] = 20,
			["lighter"] = 300,
			["bucket"] = 100,
			["divingsuit"] = 2500,
			["teddy"] = 250,
			["fishingrod"] = 2500,
			["identity"] = 300,
			["radio"] = 2000,
			["cellphone"] = 1000,
			["binoculars"] = 500,
			["camera"] = 1000,
			["vape"] = 5000,
			["pager"] = 3000,
			["keyboard"] = 250,
			["mouse"] = 225,
			["ring"] = 200,
			["watch"] = 350,
			["goldbar"] = 500,
			["playstation"] = 400,
			["xbox"] = 400,
			["legos"] = 200,
			["ominitrix"] = 350,
			["bracelet"] = 500,
			["dildo"] = 250,
			["notepad"] = 10,
			["dollars2"] = 40
		}
	},
	["registryStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 600
		}
	},
	["megaMallStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["notepad"] = 20,
			["emptybottle"] = 40,
			["cigarette"] = 20,
			["lighter"] = 600,
			["teddy"] = 500,
			["rose"] = 50,
			["bucket"] = 200,
			["compost"] = 10,
			["cannabisseed"] = 10,
			["silk"] = 3,
			["paperbag"] = 50,
			["firecracker"] = 1000
		}
	},
	["barsStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["energetic"] = 3250,
			["lighter"] = 175,
			["absolut"] = 200,
			["chandon"] = 200,
			["dewars"] = 200,
			["hennessy"] = 200,
			["coffee"] = 195,
			["vape"] = 5000,
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 80
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["soda"] = 40
		}
	},
	["colaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 40
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["donut"] = 9,
			["chocolate"] = 50
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 920
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 900
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 850
		}
	},
	["policeStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 1000,
			["gsrkit"] = 200,
			["gdtkit"] = 200,
			["WEAPON_SMG"] = 5000,
--			["WEAPON_PUMPSHOTGUN"] = 20000,
			["WEAPON_CARBINERIFLE"] = 10000,
			["WEAPON_FIREEXTINGUISHER"] = 200,
			-- ["WEAPON_STUNGUN"] = 200,
			["WEAPON_NIGHTSTICK"] = 200,
			["WEAPON_COMBATPISTOL"] = 2500,
			["WEAPON_SMG_AMMO"] = 10,
--			["WEAPON_SHOTGUN_AMMO"] = 10,
			["WEAPON_PISTOL_AMMO"] = 10,
			["handcuff"] = 1000,
			["WEAPON_RIFLE_AMMO"] = 10
		}
	},
	["drugsSelling"] = {
		["mode"] = "Buy",
		["type"] = "Consume",
		["item"] = "dollars2",
		["list"] = {
			["meth"] = 500,
			["lean"] = 500,
			["ecstasy"] = 500
		}
	},
	["robberysSelling"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["meth"] = 500,
			["lean"] = 500,
			["ecstasy"] = 500
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ price = parseInt(v), name = vRP.itemNameList(k), desc = vRP.itemDescList(k), tipo = vRP.itemTipoList(k), unity = vRP.itemUnityList(k), economy = vRP.itemEconomyList(k), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k) })
		end

		local inventoryUser = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				if string.sub(v.item,1,9) == "toolboxes" then
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)

					v.durability = advDecode[v.item]
				end
				if v.item and v.timestamp then
						local actualTime = os.time()
						local finalTime = v.timestamp
						local durabilityInSeconds = vRP.itemDurabilityList(v.item)
						local startTime = (v.timestamp - durabilityInSeconds)
						
						local actualTimeInSeconds = (actualTime - startTime)
						local porcentage = (actualTimeInSeconds/durabilityInSeconds)-1
						if porcentage < 0 then porcentage = porcentage*-1 end
						if porcentage <= 0.0 then
							porcentage = 0.0
						elseif porcentage >= 100.0 then
							porcentage = 100.0
						end
						if porcentage then
							v.durability = porcentage
						end
					end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.desc = vRP.itemDescList(v.item)
				v.tipo = vRP.itemTipoList(v.item)
				v.unity = vRP.itemUnityList(v.item)
				v.economy = vRP.itemEconomyList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getShopType(name)
    return shops[name].mode
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local inv = vRP.getInventory(user_id)
		if inv then
			if shops[shopType]["mode"] == "Buy" then
				if vRP.computeInvWeight(parseInt(user_id)) + vRP.itemWeightList(shopItem) * parseInt(shopAmount) <= vRP.getBackpack(parseInt(user_id)) then
					if shops[shopType]["type"] == "Cash" then
						if shops[shopType]["list"][shopItem] then

							if vRP.itemSubTypeList(shopItem) then
								teste = inv[tostring(slot)]
								if teste ~= nil then
									TriggerClientEvent("Notify",source,"vermelho","Você não consegue junta esse item, coloquem em outro slot.",5000)
									return
								end	
							end
							if vRP.paymentBank(parseInt(user_id),parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
								if inv[tostring(slot)] then
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
								else
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
								end						
							else
								TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
							end
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Insuficiente "..vRP.itemNameList(shops[shopType]["item"])..".",5000)
						end
					elseif shops[shopType]["type"] == "Premium" then
						local identity = vRP.getUserIdentity(parseInt(user_id))
						local consult = vRP.getInfos(identity.steam)
						if parseInt(consult[1].gems) >= parseInt(shops[shopType]["list"][shopItem]*shopAmount) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end							vRP.remGmsId(user_id,parseInt(shops[shopType]["list"][shopItem]*shopAmount))
							TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>"..vRP.format(parseInt(shopAmount)).."x "..vRP.itemNameList(shopItem).."</b> por <b>"..vRP.format(parseInt(shops[shopType]["list"][shopItem]*shopAmount)).." coins</b>.",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","Coins Insuficientes.",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			elseif shops[shopType]["mode"] == "Sell" then
				if shops[shopType]["list"][shopItem] then
					if shops[shopType]["type"] == "Cash" then

						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then	
							vRP.giveInventoryItem(parseInt(user_id),"dollars",parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
							TriggerClientEvent("Notify",source,"amarelo","Você recebeu $"..shops[shopType]["list"][shopItem]*shopAmount.." Dólares.",5000)
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then

							vRP.giveInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
						end
					end
				end
			end
		end

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(itemName,slot,target,amount)
	print("shops:populateSlot")
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("shops:Update",source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
        if inv then	
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.itemSubTypeList(itemName) then 
					TriggerClientEvent("Notify",source,"vermelho","Você não pode juntar itens deste tipos.",5000)
					return
				else	
					if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
						vRP.giveInventoryItem(user_id,itemName,amount,false,target)
					end
				end	
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end	
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end)