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
cnVRP = {}
Tunnel.bindInterface("inspect",cnVRP)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local opened = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("revistar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			
			local nuser_id = vRP.getUserId(nplayer)
			if not vRP.hasPermission(nuser_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then -- apenas policias e dono do servidor 
				if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao")  then -- apenas policias e dono do servidor 
					--vCLIENT.toggleCarry(nplayer,source)

					-- local weapons = vRPclient.replaceWeapons(nplayer)
					-- for k,v in pairs(weapons) do
					-- 	vRP.giveInventoryItem(nuser_id,k,1)
					-- 	if v.ammo > 0 then
					-- 		vRP.giveInventoryItem(nuser_id,vRP.itemAmmoList(k),v.ammo)
					-- 	end
					-- end

					-- vRPclient.updateWeapons(nplayer)
					opened[user_id] = parseInt(nuser_id)
					vCLIENT.openInspect(source)
					
				else
					if not vRP.wantedReturn(nuser_id) then
						local policia = vRP.numPermission("policia.permissao")
							if vRPclient.getHealth(nplayer) > 101 then
								local request = vRP.request(nplayer,"Você está sendo revistado, você permite?",60)
								if request then
									vCLIENT.setUNARMED(nplayer)
									vRPclient._playAnim(nplayer,true,{"random@arrests@busted","idle_a"},true)
									--vCLIENT.toggleCarry(nplayer,source)

									-- local weapons = vRPclient.replaceWeapons(nplayer)
									-- for k,v in pairs(weapons) do
									-- 	vRP.giveInventoryItem(nuser_id,k,1)
									-- 	if v.ammo > 0 then
									-- 		vRP.giveInventoryItem(nuser_id,vRP.itemAmmoList(k),v.ammo)
									-- 	end
									-- end

									vRP.wantedTimer(user_id,600) -- old is 60 need try
									-- vRPclient.updateWeapons(nplayer)
									opened[user_id] = parseInt(nuser_id)
									vCLIENT.openInspect(source)
								else
									TriggerClientEvent("Notify",source,"negado","Pedido de revista recusado.",5000)
								end
							end
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Policias não podem ser revistados.",5000)
			end
		end
	end
end)
RegisterCommand("saquear",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer and vRPclient.getHealth(nplayer) < 102 then
			vCLIENT.setUNARMED(nplayer)
			local nuser_id = vRP.getUserId(nplayer)
			if not vRP.hasPermission(nuser_id,"policia.permissao") then

				if vRP.hasPermission(user_id,"policia.permissao") then
					TriggerClientEvent("Notify",source,"negado","Policias não podem saquear.",5000)	
				else
					if not vRP.wantedReturn(nuser_id) then
									vRPclient._playAnim(nplayer,true,{"random@arrests@busted","idle_a"},true)
									vRPclient._playAnim(source,false,{"amb@medic@standing@kneel@idle_a","idle_a"},true)

									-- local weapons = vRPclient.replaceWeapons(nplayer)
									-- for k,v in pairs(weapons) do
									-- 	vRP.giveInventoryItem(nuser_id,k,1)
									-- 	if v.ammo > 0 then
									-- 		vRP.giveInventoryItem(nuser_id,vRP.itemAmmoList(k),v.ammo)
									-- 	end
									-- end

									vRP.wantedTimer(user_id,600) -- old is 60 need try
									-- vRPclient.updateWeapons(nplayer)
									opened[user_id] = parseInt(nuser_id)
									vCLIENT.openInspect(source)
					end
				end



			else
				TriggerClientEvent("Notify",source,"negado","Você não pode saquear policias.",5000)	
			end


		else
			TriggerClientEvent("Notify",source,"negado","Só dá para saquear corpo morto.",5000)	
		end


	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.openChest()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if opened[user_id] ~= nil then

			local ninventory = {}
			local myInv = vRP.getInventory(user_id)
			for k,v in pairs(myInv) do
				if string.sub(v.item,1,9) == "toolboxes" then
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)

					v.durability = advDecode[v.item]
				end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				ninventory[k] = v
			end

			local uinventory = {}
			local othInv = vRP.getInventory(opened[user_id])
			for k,v in pairs(othInv) do
				-- if string.sub(v.item,1,9) == "toolboxes" then
				-- 	local advFile = LoadResourceFile("logsystem","toolboxes.json")
				-- 	local advDecode = json.decode(advFile)

				-- 	v.durability = advDecode[v.item]
				-- end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				uinventory[k] = v
			end

			local identity = vRP.getUserIdentity(user_id)
			return ninventory,uinventory,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),vRP.computeInvWeight(opened[user_id]),vRP.getBackpack(opened[user_id]),{ identity.name.." "..identity.name2,user_id,parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:populateSlot")
AddEventHandler("inspect:populateSlot",function(itemName,slot,target,amount)
	if vRP.itemSubTypeList(itemName) then
		return
	end	
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("inspect:Update",source,"updateChest")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:updateSlot")
AddEventHandler("inspect:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.itemSubTypeList(itemName) then
		
		return
	end	
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

		TriggerClientEvent("inspect:Update",source,"updateChest")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUMSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:sumSlot")
AddEventHandler("inspect:sumSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.itemSubTypeList(itemName) then
		
		return
	end	
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(target)] and inv[tostring(target)].item == itemName then
				if vRP.tryGetInventoryItem(opened[user_id],itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
					TriggerClientEvent("inspect:Update",source,"updateChest")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUM2SLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:sum2Slot")
AddEventHandler("inspect:sum2Slot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.itemSubTypeList(itemName) then
			return
		end	
		local inv = vRP.getInventory(opened[user_id])
		if inv[tostring(target)] and inv[tostring(target)].item == item then
			if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
				vRP.giveInventoryItem(opened[user_id],itemName,amount,false,target)
				TriggerClientEvent("inspect:Update",source,"updateChest")
			end
		end
	end
end)


local noStorePolice = {
	["WEAPON_KNIFE"] = true,
	--PISTOL
	["WEAPON_PISTOL"] = true,
	["WEAPON_PISTOL_MK2"] = true,
	["WEAPON_COMBATPISTOL"] = true,
	["WEAPON_REVOLVER"] = true,
	["WEAPON_PISTOL50"] = true,
	["WEAPON_VINTAGEPISTOL"] = true,
	["WEAPON_SNSPISTOL_MK2"] = true,
	["WEAPON_SNSPISTOL"] = true,
	["WEAPON_HEAVYPISTOL"] = true,
	["WEAPON_APPISTOL"] = true,
	--SMG


	["WEAPON_MACHINEPISTOL"] = true,
	["WEAPON_GUSENBERG"] = true,
	["WEAPON_ASSAULTSMG"] = true,
	["WEAPON_SMG"] = true,
	["WEAPON_MINISMG"] = true,
	["WEAPON_MICROSMG"] = true,
	["WEAPON_COMPACTRIFLE"] = true,


	--RIFLE
	["WEAPON_SPECIALCARBINE_MK2"] = true,
	["WEAPON_SPECIALCARBINE"] = true,
	["WEAPON_ASSAULTRIFLE_MK2"] = true,
	["WEAPON_ASSAULTRIFLE"] = true,
	["WEAPON_CARBINERIFLE"] = true,

	--DOZE
	["WEAPON_SAWNOFFSHOTGUN"] = true,
	["WEAPON_PUMPSHOTGUN"] = true,
	["WEAPON_MUSKET"] = true,
}


-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.storeItem(itemName,slot,amount,target)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local durability = vRP.getInventoryItemDurability(user_id,itemName)
		local policia = vRP.hasPermission(user_id,"policia.permissao")

		if policia then -- verificar se é policial
			if noStorePolice[itemName] then -- verificar itens não permitidos
				TriggerClientEvent("Notify",source,"vermelho","Policias não podem passar este tipo de item.",5000)
				return
			end
		else
			if user_id then
				if vRP.computeInvWeight(opened[user_id]) + vRP.itemWeightList(itemName) * parseInt(amount) <= vRP.getBackpack(opened[user_id]) then
					if vRP.itemSubTypeList(itemName) and amount > 1 then
						-- if vRP.getInventoryItemAmount(opened[user_id],itemName) > 0 then
						-- 	TriggerClientEvent("Notify",source,"negado","O jogador já possui esse tipo de item.",5000)
						-- else
							
							
							if vRP.tryGetInventoryItem(user_id,itemName,amount,true,slot,durability) then
								vRP.giveInventoryItem(opened[user_id],itemName,amount,false,target,parseInt(durability))
								TriggerClientEvent("inspect:Update",source,"updateChest")
							end
						-- end
					else
						if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
							
							vRP.giveInventoryItem(opened[user_id],itemName,amount,true,target,durability)
							TriggerClientEvent("inspect:Update",source,"updateChest")
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
				end
			end
		end	
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local rouboLog = "https://discord.com/api/webhooks/1016441505281478750/xXAg6LLiLdyhBW7kZ761yjz_W2lZ0Bf2-vz1oYgJdUlrtNTaYQPTsDe8KsnBEufsrm6w"
local webhookapreender = "https://discord.com/api/webhooks/1038990303207637022/hwEb_bBkIdB_J_pQzfCAOQb3eMWY1qfxTJ0Qww_OLQxn9KTA93pJ5CDnDPJLPAQiPmo_"
function cnVRP.takeItem(itemName,slot,amount,target)
	if amount == nil then
		return
	end	
	local source = source
	local nplayer = vRPclient.nearestPlayer(source,5)
	local nuser_id = vRP.getUserId(nplayer)
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id then
			local policia = vRP.hasPermission(user_id,"policia.permissao")

			if policia then -- verificar se é policial, caso seja os itens só seram apreendidos 

				if vRP.tryGetInventoryItem(opened[user_id],itemName,amount,true,slot,durability) then
					TriggerClientEvent("Notify",source,"verde","Você apreendeu um item.",5000)
					TriggerClientEvent("inspect:Update",source,"updateChest")
					PerformHttpRequest(webhookapreender, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "Aprendeu:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
								thumbnail = {
								url = "https://cdn.discordapp.com/attachments/1016469986384027738/1038998324721758259/server.png"
								}, 
								fields = {
									{ 
										name = "**Nº do ID Policial:**", 
										value = "` "..user_id.." ` "
									},
									{ 
										name = "**Nº do ID Abordado:**", 
										value = "` "..nuser_id.." ` "
									},
									{ 
										name = "**Nome do item:**", 
										value = "` "..itemName.." ` "
									},
									{ 
										name = "**Quantidade do item:**", 
										value = "` "..amount.." `\n⠀"
									}
								}, 
								footer = { 
									text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
									icon_url = "https://cdn.discordapp.com/attachments/1016469986384027738/1038998324721758259/server.png" 
								},
								color = 15914080 
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				
				end
			else	
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList(itemName) * parseInt(amount) <= vRP.getBackpack(user_id) then
					if vRP.itemSubTypeList(itemName) then
						-- if vRP.getInventoryItemAmount(user_id,itemName) > 0 then
						-- 	TriggerClientEvent("Notify",source,"negado","Você já possui esse tipo de item.",5000)
						-- else
							local durability = vRP.getInventoryItemDurability(opened[user_id],itemName)
							--print(durability)
							if vRP.tryGetInventoryItem(opened[user_id],itemName,amount,true,slot,durability) then
								vRP.giveInventoryItem(user_id,itemName,amount,false,target,parseInt(durability))
								TriggerClientEvent("inspect:Update",source,"updateChest")
								PerformHttpRequest(rouboLog, function(err, text, headers) end, 'POST', json.encode({
									embeds = {
										{ 
											title = "Roubou:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
											thumbnail = {
											url = "https://cdn.discordapp.com/attachments/1016469986384027738/1038998324721758259/server.png"
											}, 
											fields = {
												{ 
													name = "**Nº do ID:**", 
													value = "` "..user_id.." ` "
												},
												{ 
													name = "**Nº do ID Roubado:**", 
													value = "` "..nuser_id.." ` "
												},
												{ 
													name = "**Nome do item:**", 
													value = "` "..itemName.." ` "
												},
												{ 
													name = "**Quantidade do item:**", 
													value = "` "..amount.." `\n⠀"
												}
											}, 
											footer = { 
												text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
												icon_url = "https://cdn.discordapp.com/attachments/1016469986384027738/1038998324721758259/server.png" 
											},
											color = 15914080 
										}
									}
								}), { ['Content-Type'] = 'application/json' })
							end
						-- end
					else
						if vRP.tryGetInventoryItem(opened[user_id],itemName,amount,true,slot,durability) then
							vRP.giveInventoryItem(user_id,itemName,amount,false,target,durability)
							TriggerClientEvent("inspect:Update",source,"updateChest")
							PerformHttpRequest(rouboLog, function(err, text, headers) end, 'POST', json.encode({
								embeds = {
									{ 
										title = "Roubou:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
										thumbnail = {
										url = "https://cdn.discordapp.com/attachments/1016469986384027738/1038998324721758259/server.png"
										}, 
										fields = {
											{ 
												name = "**Nº do ID:**", 
												value = "` "..user_id.." ` "
											},
											{ 
												name = "**Nº do ID Roubado:**", 
												value = "` "..nuser_id.." ` "
											},
											{ 
												name = "**Nome do item:**", 
												value = "` "..itemName.." ` "
											},
											{ 
												name = "**Quantidade do item:**", 
												value = "` "..amount.." `\n⠀"
											}
										}, 
										footer = { 
											text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
											icon_url = "https://cdn.discordapp.com/attachments/1016469986384027738/1038998324721758259/server.png" 
										},
										color = 15914080 
									}
								}
							}), { ['Content-Type'] = 'application/json' })
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
				end
			end	
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.resetInspect()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			vRPclient._stopAnim(nplayer,false)
			vCLIENT.toggleCarry(nplayer,source)
		end

		if opened[user_id] ~= nil then
			opened[user_id] = nil
		end
		vRPclient._stopAnim(source,false)
	end
end