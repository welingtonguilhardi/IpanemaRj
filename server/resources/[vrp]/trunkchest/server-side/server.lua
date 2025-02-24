-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("trunkchest",cRP)
vCLIENT = Tunnel.getInterface("trunkchest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehChest = {}
local vehNames = {}
local vehWeight = {}
local chestOpen = {}
local webhookbau = 'https://discord.com/api/webhooks/1031535159712944179/qH-gKm092AxNA-2GVbKETLumWJKfgjL73_zf_BcR-YtC-DDdHLRcW1wdNHonePeKn5vQ'



function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end




RegisterNetEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local vehicle,vehNet,vehPlate,vehName,vehLock,vehBlock,vehHealth = vRPclient.vehList(source,7)
        if vehicle then
            for k,v in pairs(chestOpen) do
                if v == vehPlate then
                    return
                end
            end

            if not vehLock then
                if vehBlock then
                    return
                end

                if vehHealth < 100 then
                    return
                end

                local plateUserId = vRP.getVehiclePlate(vehPlate)
                if plateUserId then
                    chestOpen[user_id] = vehPlate
                    vCLIENT.trunkOpen(source)

                    if not vRPclient.inVehicle(source) then
                        TriggerClientEvent("player:syncDoors",-1,vehNet,"5")
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function generateSpecialName(name,count)
	local s = ''
	for i=0,count do
		s=s..'#'
	end
	return (name..s)
end

-- function countSpecialItems(itemname,table)
-- 	local count = 1
-- 	local f = json.encode(table)
-- 	local ntable = json.decode(f)
-- 	for itemName,_ in pairs(ntable) do
-- 		local stringFind = ('#')
-- 		--print('procurar por',stringFind,itemName)
-- 		if itemName:find(stringFind) then
-- 			count = count + 1
-- 			ntable[itemName] = nil
-- 		end
-- 	end
-- 	return count
-- end

function countSpecialItems(itemname,table)
	local count = 0
	local f = json.encode(table)
	local ntable = json.decode(f)
	for itemName,_ in pairs(ntable) do
		for i=1, #itemName do
			if itemName:sub(i, i) == "#" then
				ntable[itemName] = nil
				count = count + 1
			end
		end
	end
	return count
end 






function cRP.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,7)
		if vehicle then
			local plateUserId = vRP.getVehiclePlate(vehPlate)
			if plateUserId then
				local myinventory = {}
				local myvehicle = {}

				if vRPclient.inVehicle(source) then
					vehWeight[user_id] = 7
					vehChest[parseInt(user_id)] = "gloves:"..parseInt(plateUserId)..":"..vehName
				else
					vehWeight[user_id] = parseInt(vRP.vehicleChest(vehName))
					vehChest[parseInt(user_id)] = "chest:"..parseInt(plateUserId)..":"..vehName
				end

				vehNames[parseInt(user_id)] = vehName

				local inv = vRP.getInventory(parseInt(user_id))
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

					myinventory[k] = v
				end

				local data = vRP.getSData(vehChest[parseInt(user_id)])
				local sdata = json.decode(data) or {}
				if data then
					for k,v in pairs(sdata) do
						local _k = k:find("#")
						local s = ''
						if _k then
							s = k
							k = string.gsub(k,"#","")
						end
						table.insert(myvehicle,{economy = vRP.itemEconomyList(k),custom = s ~= '' and s or false,unity = vRP.itemUnityList(k), tipo = vRP.itemTipoList(k),custom = s ~= '' and s or false, desc = vRP.itemDescList(k), amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.itemWeightList(k) })
					end
				end

				return myinventory,myvehicle,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),vRP.computeChestWeight(sdata),parseInt(vehWeight[user_id]),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["cola"] = true,
	["soda"] = true,
	["coffee"] = true,
	["water"] = true,
	["dirtywater"] = true,
	["emptybottle"] = true,
	-- ["hamburger"] = true,
	["tacos"] = true,
	["chocolate"] = true,
	["donut"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local storeVehs = {
	["mule3"] = {
		["bait"] = true,
		["shrimp"] = true,
		["octopus"] = true,
		["carp"] = true
	},
	["ratloader"] = {
		["woodlog"] = true
	},
	["stockade"] = {
		["pouch"] = true
	},
	["trash"] = {
		["plastic"] = true,
		["glass"] = true,
		["rubber"] = true,
		["aluminum"] = true,
		["copper"] = true,
		["emptybottle"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:populateSlot")
AddEventHandler("trunkchest:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end
		if vRP.itemSubTypeList(itemName) then
			--TriggerClientEvent("Notify",source,"importante","Você não pode mexer este item.",5000)
			return
		end	

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("trunkchest:Update",source,"updateMochila")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:updateSlot")
AddEventHandler("trunkchest:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
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

		TriggerClientEvent("trunkchest:Update",source,"updateMochila")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:sumSlot")
AddEventHandler("trunkchest:sumSlot",function(itemName,slot,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(slot)].item == itemName then
				if vRP.tryChestItem(user_id,vehChest[parseInt(user_id)],itemName,amount,slot) then
					TriggerClientEvent("trunkchest:Update",source,"updateMochila")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(itemName,slot,amount)
	--print(amount)
	local itemLog = itemName
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		local durability = vRP.getInventoryItemDurability(user_id,itemName)
		if user_id then
			if storeVehs[vehNames[parseInt(user_id)]] then
				if not storeVehs[vehNames[parseInt(user_id)]][itemName] then
					TriggerClientEvent("Notify",source,"vermelho","Você não pode guardar este item.",3000)
					vCLIENT.trunkClose(source)
					return
				end
			end


			if noStore[itemName]  then
				TriggerClientEvent("Notify",source,"vermelho","Você não pode guardar este item.",3000)
				vCLIENT.trunkClose(source)
				return
			end
			local data = vRP.getSData(vehChest[parseInt(user_id)])
			local sdata = json.decode(data) or {}
			if vRP.itemSubTypeList(itemName) then
				local inv = vRP.getInventory(user_id)
				local count = countSpecialItems(itemName,sdata)
				if count > 1 then
					itemName = generateSpecialName(itemName,count)
				else
					itemName = itemName..'##'
				end
			end

			if vRP.storeChestItem(user_id,vehChest[parseInt(user_id)],itemName,amount,parseInt(vehWeight[user_id]),slot,durability) then
				TriggerClientEvent("trunkchest:Update",source,"updateMochila")
				SendWebhookMessage(webhookbau,"```prolog\n[ID]: "..user_id.."  \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemLog).." \n[BAU]: "..vehChest[parseInt(user_id)].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(itemName,slot,amount,custom)
	local durability = nil
	--print(custom)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			local _k = itemName:find("#") -- está retornando nill
			if _k then
			
				itemName = string.gsub(itemName,"#","")
			end 

			realname = custom

			local data = vRP.getSData(vehChest[parseInt(user_id)])
			local sdata = json.decode(data) or {}

			for k,v in pairs(sdata) do
				if k == custom then
				 	durability = v.durability
				end	
			end


			if vRP.tryChestItem(user_id,vehChest[parseInt(user_id)],itemName,amount,slot,durability,realname) then
				TriggerClientEvent("trunkchest:Update",source,"updateMochila")
				SendWebhookMessage(webhookbau,"```prolog\n[ID]: "..user_id.."  \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..vehChest[parseInt(user_id)].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,7)
		if vehicle then
			if not vRPclient.inVehicle(source) then
				TriggerClientEvent("player:syncDoors",-1,vehNet,"5")
			end

			if chestOpen[user_id] then
				chestOpen[user_id] = nil
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function()
local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local vehicle,vehNet,vehPlate,vehName,vehLock,vehBlock,vehHealth = vRPclient.vehList(source,7)
        if vehicle then
            for k,v in pairs(chestOpen) do
                if v == vehPlate then
                    return
                end
            end

            if not vehLock then
                if vehBlock then
                    return
                end

                if vehHealth < 100 then
                    return
                end

                local plateUserId = vRP.getVehiclePlate(vehPlate)
                if plateUserId then
                    chestOpen[user_id] = vehPlate
                    RemoveAllPedWeapons(source, true)
                    vCLIENT.trunkOpen(source)
                    if not vRPclient.inVehicle(source) then
                        TriggerClientEvent("player:syncDoors",-1,vehNet,"5")
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if chestOpen[user_id] then
		chestOpen[user_id] = nil
	end
end)