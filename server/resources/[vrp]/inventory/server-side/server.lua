-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator() 
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("inventory",func)
vCLIENT = Tunnel.getInterface("inventory")
vRPRAGE = Tunnel.getInterface("garages")
vSURVIVAL = Tunnel.getInterface("survival")
vPLAYER = Tunnel.getInterface("player")
vWEPLANTS = Tunnel.getInterface("vrp_weplants")
vWEPLANTSS = Tunnel.getInterface("weplants")
vHOMES = Tunnel.getInterface("homes")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local active = {}
local weaponrechenger = {}
local firecracker = {}
local registerTimers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/temgps","SELECT * FROM vrp_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND gps = 1")
vRP.prepare("vRP/update_gps","UPDATE vrp_vehicles SET gps = @gps WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(registerTimers) do
			if registerTimers[k][4] > 0 then
				registerTimers[k][4] = registerTimers[k][4] - 1

				if registerTimers[k][4] <= 0 then
					registerTimers[k] = nil
					TriggerClientEvent("inventory:updateRegister",-1,registerTimers)
				end
			end
		end
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(firecracker) do
			if firecracker[k] > 0 then
				firecracker[k] = firecracker[k] - 30
				if firecracker[k] <= 0 then
					firecracker[k] = nil
				end
			end
		end
		Citizen.Wait(30000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(active) do
			if active[k] > 0 then
				active[k] = active[k] - 1
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.fireStress()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.upgradeStress(user_id,0.5)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.fire()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.fire(user_id)
	
end


function func.getammo()
	--print("getammo")
	local source = source 
	local user_id = vRP.getUserId(source)
	local weapons = vRPclient.replaceWeapons(source)
	for k,v in pairs(weapons) do
		if v.ammo > 0 then
			vRP.giveInventoryItem(user_id,vRP.itemAmmoList(k),v.ammo)
		end
	end
end	
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function func.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			local inventory = {}
			for k,v in pairs(inv) do
				if (parseInt(v.amount) <= 0 or vRP.itemBodyList(v.item) == nil) then
					vRP.removeInventoryItem(user_id,v.item,parseInt(v.amount),false)
				else
					if string.sub(v.item,1,9) == v.item then
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

					inventory[k] = v
				end
			end

			local identity = vRP.getUserIdentity(user_id)
			return inventory,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),vRP.getUserGroupByType(user_id,"job"),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration,identity.garage }
		end
	end
end

function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k, v in pairs(o) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
  end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON_AMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_ammos = {
-- START PISTOLS
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_COMPACTRIFLE",
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_ASSAULTSMG",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_CARBINERIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_SAWNOFFSHOTGUN"
	},
-- START OTHERS
    ["WEAPON_RPG_AMMO"] = {
		"WEAPON_RPG"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
-- END OTHERS
}

-- local function checkWeaponByAmmo(ammo, weapon)
-- 	local is_w = weapon_ammos[ammo]
-- 	if is_w then
-- 		for k, v in pairs(is_w) do
-- 			if v == weapon then
-- 				return true
-- 			end
-- 		end
-- 	end
-- 	return false
-- end
-- local function getAmmoTypeByWeapon(wea)
-- 	for ammo, weapons in pairs(weapon_ammos) do
-- 		for _, weapon in pairs(weapons) do
-- 			if weapon  == wea then
-- 				return ammo
-- 			end
-- 		end
-- 	end
-- 	return ""
-- end


-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON_AMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local _weapon = {
	-- START PISTOLS
			"WEAPON_PISTOL",
			"WEAPON_PISTOL_MK2",
			"WEAPON_APPISTOL",
			"WEAPON_HEAVYPISTOL",
			"WEAPON_SNSPISTOL",
			"WEAPON_SNSPISTOL_MK2",
			"WEAPON_VINTAGEPISTOL",
			"WEAPON_PISTOL50",
			"WEAPON_REVOLVER",
			"WEAPON_COMBATPISTOL",
			"WEAPON_COMPACTRIFLE",
			"WEAPON_MICROSMG",
			"WEAPON_MINISMG",
			"WEAPON_SMG",
			"WEAPON_ASSAULTSMG",
			"WEAPON_GUSENBERG",
			"WEAPON_MACHINEPISTOL",
			"WEAPON_CARBINERIFLE",
			"WEAPON_ASSAULTRIFLE",
			"WEAPON_ASSAULTRIFLE_MK2",
			"WEAPON_SPECIALCARBINE",
			"WEAPON_SPECIALCARBINE_MK2",
			"WEAPON_PUMPSHOTGUN",
			"WEAPON_SAWNOFFSHOTGUN",
			"WEAPON_RPG",
			"WEAPON_PETROLCAN",
	-- END OTHERS
	}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateSlot")
AddEventHandler("inventory:updateSlot",function(itemName,slot,target,amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if amount == nil then amount = 1 end
        if amount <= 0 then amount = 1 end

        local inv = vRP.getInventory(user_id)
        if inv then	
				if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
					if vRP.itemSubTypeList(itemName) then 
				 		TriggerClientEvent("Notify",source,"vermelho","Você não pode juntar itens deste tipos.",5000)
					else	
						if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
							vRP.giveInventoryItem(user_id,itemName,amount,false,target)
						end
					end	
				else
					vRP.swapSlot(user_id,slot,target)
				end
			-- end	

            TriggerClientEvent("inventory:Update",source,"updateMochila")
        end
    end
end)

function func.givePneuRoubado()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,"tires",1,false)
		TriggerClientEvent("Notify",source,"sucesso","Você roubou o pneu com sucesso.",5000)
	end

end

----------------------------------------------------------------------------------------------------------------------------------------
-- RETIRA PNEU
-----------------------------------------------------------------------------------------------------------------------------------------
function func.retiraPneu(vehicle,pneu)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vehicle then
			TriggerClientEvent("finalizarTroca",-1,vehicle,pneu)
			if vRP.tryGetInventoryItem(user_id,"tires",1) then
				return true
			end
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURA PNEU
-----------------------------------------------------------------------------------------------------------------------------------------
function func.estouraPneu(vehicle,pneu)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vehicle then
			TriggerClientEvent("retiraPneu",-1,vehicle,pneu)
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKILLBAR
-----------------------------------------------------------------------------------------------------------------------------------------
function func.skillbar()
	local source = source
	if vTASKBAR.taskMechanic(source) then
		return true
	else
		return false
	end
end

function func.notifyarma(itemName,modo)
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ modo,vRP.itemIndexList(itemName),vRP.format(parseInt(1)),vRP.itemNameList(itemName) })
end








-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
local garmas= false
RegisterCommand('garmas',function(source,args,rawCommand)
	garmas = true
	local user_id = vRP.getUserId(source)
	if user_id and not vRP.hasPermission(user_id,"policia.permissao")then
		TriggerClientEvent("Notify",source,"aviso","<b>Aguarde</b><br>Suas armas estão sendo desequipadas.",9500)
		local weapons = vRPclient.replaceWeapons(source,{})
		Citizen.Wait(math.random(500,1999))
		for k,v in pairs(weapons) do
			vRP.removeWeaponTable(user_id,k)
			vRP.giveInventoryItem(user_id,k,1,true)
			if v.ammo > 0 then
				vRP.giveInventoryItem(user_id,vRP.itemAmmoList(k),v.ammo,true)
			end
			Citizen.Wait(10)
		end
		vRPclient.updateWeapons(source)
		TriggerClientEvent("Notify",source,"sucesso","Armamento Guardado.",10000)
	else
		TriggerClientEvent("Notify",source,"negado","Policias não podem guardar armamento.",10000)	 	
	end
	SetTimeout(3000, function()
		garmas = false
	end)
end)









-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:useItem")
AddEventHandler("inventory:useItem",function(slot,rAmount)
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		if rAmount == nil then rAmount = 1 end
		if rAmount <= 0 then rAmount = 1 end

		if active[user_id] == nil then
			local inv = vRP.getInventory(user_id)
			if inv then
				if not inv[tostring(slot)] or inv[tostring(slot)].item == nil then
					return
				end

				local itemName = inv[tostring(slot)].item
				if vRP.itemTypeList(itemName) == "use" then
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					-- vCLIENT.removeWeaponInHand(source)
					if not vPLAYER.getHandcuff(source) then
						if itemName == "bandage" then
							if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 200 then
								active[user_id] = 10
								vCLIENT.closeInventory(source)
								vCLIENT.blockButtons(source,true)
								TriggerClientEvent("Progress",source,10000,"Utilizando...")
								vRPclient._playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

								repeat
									if active[user_id] == 0 then
										active[user_id] = nil
										vRPclient._stopAnim(source,false)
										vCLIENT.blockButtons(source,false)

										if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
											vRP.upgradeStress(user_id,2)
											vRPclient.updateHealth(source,15)
										end
									end
									Citizen.Wait(0)
								until active[user_id] == nil
							else
								TriggerClientEvent("Notify",source,"vermelho","Você não pode utilizar de vida cheia ou nocauteado.",5000)
							end
						end

						if itemName == "analgesic" then
							if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 200 then
								active[user_id] = 5
								vCLIENT.closeInventory(source)
								vCLIENT.blockButtons(source,true)
								TriggerClientEvent("Progress",source,5000,"Utilizando...")
								vRPclient._playAnim(source,true,{"mp_suicide","pill"},true)

								repeat
									if active[user_id] == 0 then
										active[user_id] = nil
										vRPclient._stopAnim(source,false)
										vCLIENT.blockButtons(source,false)

										if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
											vRP.upgradeStress(user_id,1)
											vRPclient.updateHealth(source,2)
										end
									end
									Citizen.Wait(0)
								until active[user_id] == nil
							else
								TriggerClientEvent("Notify",source,"vermelho","Você não pode utilizar de vida cheia ou nocauteado.",5000)
							end
						end

						if itemName == "weed" then
							if vRP.getInventoryItemAmount(user_id,"weed") >= parseInt(rAmount) and vRP.getInventoryItemAmount(user_id,"silk") >= parseInt(rAmount) then
							active[user_id] = parseInt(rAmount*3)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,parseInt(rAmount*3000),"Utilizando...")

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)

										if vRP.tryGetInventoryItem(user_id,"weed",parseInt(rAmount),true,slot) and vRP.tryGetInventoryItem(user_id,"silk",parseInt(rAmount),true) then
											vRP.giveInventoryItem(user_id,"joint",parseInt(rAmount),true)
										end
									end
									Citizen.Wait(0)
								until active[user_id] == nil
							else
								TriggerClientEvent("Notify",source,"vermelho","Você não tem uma seda.",5000)
							end
						end

						if itemName == "joint" then
							if vRP.getInventoryItemAmount(user_id,"lighter") <= 0 then
								TriggerClientEvent("Notify",source,"vermelho","Você não tem um isqueiro.",5000)
								return
							end
							
							active[user_id] = 60
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,60000,"Fumando...")
							vRPclient._createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._removeObjects(source)
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.weedTimer(user_id,2)
										vRP.downgradeHunger(user_id,10)
										vRP.downgradeThirst(user_id,10)
										vRP.downgradeStress(user_id,15)
										vPLAYER.movementClip(source,"move_m@shadyped@a")
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "lean" then
							active[user_id] = 6
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,6000,"Utilizando...")
							vRPclient._playAnim(source,true,{"mp_suicide","pill"},true)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._stopAnim(source,false)
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.chemicalTimer(user_id,2)
										vRP.downgradeStress(user_id,50)
										--TriggerClientEvent("cleanEffectDrugs",source)
										TriggerClientEvent("setMeth",source)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "ecstasy" then
							active[user_id] = 6
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,6000,"Utilizando...")
							vRPclient._playAnim(source,true,{"mp_suicide","pill"},true)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._stopAnim(source,false)
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.chemicalTimer(user_id,2)
										TriggerClientEvent("setEcstasy",source)
										TriggerClientEvent("setEnergetic",source,10,1.45)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "meth" then
							active[user_id] = 6
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,6000,"Utilizando...")
							vRPclient._playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._stopAnim(source)
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.chemicalTimer(user_id,2)
										vRPclient.setArmour(source,20)
										TriggerClientEvent("setMeth",source)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end
						
						if itemName == "notebook" then
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							TriggerClientEvent("notebook:openSystem",source)
						end

						if itemName == "dildo" then
							active[user_id] = 15
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,15000,"Utilizando...")
							vRPclient._playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._stopAnim(source)
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.chemicalTimer(user_id,2)
										TriggerClientEvent("setMeth",source)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "cigarette" then
							if vRP.getInventoryItemAmount(user_id,"lighter") <= 0 then
								TriggerClientEvent("Notify",source,"vermelho","Você não tem um isqueiro.",5000)
								return
							end

							active[user_id] = 60
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,60000,"Fumando...")
							vRPclient._createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._removeObjects(source)
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.downgradeStress(user_id,15)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "vape" then
							--active[user_id] = 60
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							--vRPclient._CarregarObjeto(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","ba_prop_battle_vape_01",49,18905,0.08,-0.00,0.03,-150.0,90.0,-10.0)
							TriggerClientEvent("Vape:StartVaping", source, 0)
							--vRP.varyStress(user_id,-3)
							vCLIENT.blockButtons(source,false)
							--vRPclient._DeletarObjeto(source,"one")
							Citizen.Wait(0)
							--until active[user_id] == nil
						end
							

						if itemName == "warfarin" then
							if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 200 then
								active[user_id] = 60
								vCLIENT.closeInventory(source)
								vCLIENT.blockButtons(source,true)
								TriggerClientEvent("Progress",source,60000,"Utilizando...")
								vRPclient._createObjects(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)

								repeat
									if active[user_id] == 0 then
										active[user_id] = nil
										vRPclient._removeObjects(source)
										vCLIENT.blockButtons(source,false)

										if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
											vRPclient.updateHealth(source,45)
											TriggerClientEvent("resetBleeding",source)
										end
									end
									Citizen.Wait(0)
								until active[user_id] == nil
							else
								TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.",5000)
							end
						end

						if itemName == "gauze" then
							if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 200 then
								active[user_id] = 3
								vCLIENT.closeInventory(source)
								vCLIENT.blockButtons(source,true)
								TriggerClientEvent("Progress",source,3000,"Utilizando...")
								vRPclient._playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

								repeat
									if active[user_id] == 0 then
										active[user_id] = nil
										vRPclient._stopAnim(source,false)
										vCLIENT.blockButtons(source,false)

										if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
											TriggerClientEvent("resetBleeding",source)
										end
									end
									Citizen.Wait(0)
								until active[user_id] == nil
							else
								TriggerClientEvent("Notify",source,"vermelho","Você não pode utilizar de vida cheia ou nocauteado.",5000)
							end
						end

						if itemName == "newgarage" then
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								vRP.execute("vRP/update_garages",{ id = parseInt(user_id) })
								TriggerClientEvent("Notify",source,"sucesso","Voce adicionou uma vaga na garagem.",5000)
							end
						end

						if itemName == "binoculars" then
							active[user_id] = 2
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,2000,"Utilizando...")

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._createObjects(source,"amb@world_human_binoculars@male@enter","enter","prop_binoc_01",50,28422)
									Citizen.Wait(750)
									TriggerClientEvent("useBinoculos",source)
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "camera" then
							active[user_id] = 2
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,2000,"Utilizando...")

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._createObjects(source,"amb@world_human_paparazzi@male@base","base","prop_pap_camera_01",49,28422)
									Citizen.Wait(100)
									TriggerClientEvent("useCamera",source)
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "cellphone" then
							TriggerClientEvent("gcPhone:activePhone",source)
						end

						if itemName == "adrenaline" then
							local distance = vCLIENT.adrenalineDistance(source)

							local nplayer = vRPclient.nearestPlayer(source,2)
							if nplayer then
								if vRPclient.getHealth(nplayer) <= 101 then
										active[user_id] = 10
										vRPclient.stopActived(source)
										vCLIENT.closeInventory(source)
										vCLIENT.blockButtons(source,true)
										TriggerClientEvent("Progress",source,10000,"Utilizando...")
										vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
										repeat
											if active[user_id] == 0 then
												active[user_id] = nil
												vSURVIVAL._revivePlayer(nplayer,110)
												vCLIENT.blockButtons(source,false)
												vRPclient._stopAnim(source,false)
												if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
													vRP.upgradeStress(user_id,10)
													vRP.upgradeStress(nuser_id,10)
													vRP.upgradeThirst(nuser_id,10)
													vRP.upgradeHunger(nuser_id,10)
													vRP.chemicalTimer(nuser_id,1)
													
													TriggerClientEvent("resetBleeding",nplayer)
												end
											end
											Citizen.Wait(0)
										until active[user_id] == nil
								else
									TriggerClientEvent("Notify",source,"vermelho","Você não pode utilizar em alguem com vida.",5000)		
								end		
							end
						end
						if itemName == "cellbattery" then
							if vRP.getInventoryItemAmount(user_id,"cellphone") < 1 then
								if vRP.tryGetInventoryItem(user_id,"nbcellphone",1,true) then
									active[user_id] = 15
									vRPclient.stopActived(source)
									vCLIENT.closeInventory(source)
									vCLIENT.blockButtons(source,true)
									TriggerClientEvent("Progress",source,15000,"Utilizando...")
								else
									vCLIENT.closeInventory(source)
									TriggerClientEvent("Notify",source,"vermelho","Celular não encontrado.",3000)
								end	
							else
									vCLIENT.closeInventory(source)
									TriggerClientEvent("Notify",source,"vermelho","Já tem um celular carregado em sua mochila.",3000)
							end	
	
							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")
	
									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.giveInventoryItem(user_id,"cellphone",1)
										vRP.removeInventoryItem(user_id,"nbcellphone",1)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "teddy" then
							vCLIENT.closeInventory(source)
							vRPclient._createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","v_ilev_mr_rasberryclean",49,24817,-0.20,0.46,-0.016,-180.0,-90.0,0.0)
						end

						if itemName == "rose" then
							vCLIENT.closeInventory(source)
							vRPclient._createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","prop_single_rose",49,18905,0.13,0.15,0.0,-100.0,0.0,-20.0)
						end

						if itemName == "identity" then
							local nplayer = vRPclient.nearestPlayer(source,2)
							if nplayer then
								local identity = vRP.getUserIdentity(user_id)
								if identity then
									TriggerClientEvent("Notify",nplayer,"default","<b>Passaporte:</b> "..vRP.format(parseInt(identity.id)).."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone,10000)
								end
							end
						end

						if itemName == "bonusDelivery" then
							local myBonus = vRP.bonusDelivery(user_id)
							if parseInt(myBonus) >= 1 then
								TriggerClientEvent("Notify",source,"vermelho","O nível de experiência no <b>Delivery</b> já está no maximo.",5000)
								return
							end

							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								vRP.setBonusDelivery(user_id,1)
								TriggerClientEvent("Notify",source,"verde","O nível de experiência no <b>Delivery</b> aumentou.",5000)
							end
						end

						if itemName == "firecracker" then
							if firecracker[user_id] == nil then
								active[user_id] = 3
								firecracker[user_id] = 250
								vCLIENT.closeInventory(source)
								vCLIENT.blockButtons(source,true)
								TriggerClientEvent("Progress",source,3000,"Utilizando...")
								vRPclient._playAnim(source,false,{"anim@mp_fireworks","place_firework_3_box"},true)

								repeat
									if active[user_id] == 0 then
										active[user_id] = nil
										vRPclient._stopAnim(source,false)
										vCLIENT.blockButtons(source,false)

										if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
											TriggerClientEvent("inventory:Firecracker",source)
										end
									end
									Citizen.Wait(0)
								until active[user_id] == nil
							end
						end

						if itemName == "gsrkit" then
							local nplayer = vRPclient.nearestPlayer(source,5)
							if nplayer then
								if vPLAYER.getHandcuff(nplayer) then
									active[user_id] = 10
									vCLIENT.closeInventory(source)
									vCLIENT.blockButtons(source,true)
									TriggerClientEvent("Progress",source,10000,"Utilizando...")

									repeat
										if active[user_id] == 0 then
											active[user_id] = nil
											vCLIENT.blockButtons(source,false)

											if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
												local check = vRP.fireReturn(nplayer)
												if parseInt(check) > 0 then
													TriggerClientEvent("Notify",source,"verde","Resultado positivo.",5000)
												else
													TriggerClientEvent("Notify",source,"vermelho","Resultado negativo.",3000)
												end
											end
										end
										Citizen.Wait(0)
									until active[user_id] == nil
								end
							end
						end

						if itemName == "gdtkit" then
							local nplayer = vRPclient.nearestPlayer(source,5)
							if nplayer then
								local nuser_id = vRP.getUserId(nplayer)
								if nuser_id then
									active[user_id] = 10
									vCLIENT.closeInventory(source)
									vCLIENT.blockButtons(source,true)
									TriggerClientEvent("Progress",source,10000,"Utilizando...")

									repeat
										if active[user_id] == 0 then
											active[user_id] = nil
											vCLIENT.blockButtons(source,false)

											if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
												local weed = vRP.weedReturn(nuser_id)
												local chemical = vRP.chemicalReturn(nuser_id)
												local alcohol = vRP.alcoholReturn(nuser_id)
												local chemStr = ""
												local alcoholStr = ""
												local weedStr = ""

												if chemical == 0 then
													chemStr = "Nenhum"
												elseif chemical == 1 then
													chemStr = "Baixo"
												elseif chemical == 2 then
													chemStr = "Médio"
												elseif chemical >= 3 then
													chemStr = "Alto"
												end

												if alcohol == 0 then
													alcoholStr = "Nenhum"
												elseif alcohol == 1 then
													alcoholStr = "Baixo"
												elseif alcohol == 2 then
													alcoholStr = "Médio"
												elseif alcohol >= 3 then
													alcoholStr = "Alto"
												end

												if weed == 0 then
													weedStr = "Nenhum"
												elseif weed == 1 then
													weedStr = "Baixo"
												elseif weed == 2 then
													weedStr = "Médio"
												elseif weed >= 3 then
													weedStr = "Alto"
												end

												TriggerClientEvent("Notify",source,"default","<b>Químicos:</b> "..chemStr.."<br><b>Álcool:</b> "..alcoholStr.."<br><b>Drogas:</b> "..weedStr,10000)
											end
										end
										Citizen.Wait(0)
									until active[user_id] == nil
								end
							end
						end

						if itemName == "vest" then
							active[user_id] = 10
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._stopAnim(source,false)
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRPclient.setArmour(source,100)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "GADGET_PARACHUTE" then
							active[user_id] = 10
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")

							repeat	
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vCLIENT.parachuteColors(source)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "skate" then
							active[user_id] = 3
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,3000,"Utilizando...")

							repeat	
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									TriggerClientEvent("skate",source)
									
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "toolbox" then
							if not vRPclient.inVehicle(source) then
								local vehicle,vehNet = vRPclient.vehList(source,11)
								if vehicle then
									if vCLIENT.checkBurstTyres(source,vehNet) then
										active[user_id] = 30
										vRPclient.stopActived(source)
										vCLIENT.closeInventory(source)
										vRPclient._playAnim(source,false,{"mini@repair","fixing_a_player"},true)
										-- vRP.createDurability(itemName)

										local taskResult = vTASKBAR.taskMechanic(source)
										if taskResult then
											vRP.upgradeStress(user_id,5)
											if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
												TriggerClientEvent("inventory:repairVehicle",-1,vehNet,true)
												TriggerClientEvent("Notify",source,"verde","Arrumado com sucesso.",5000)
											end
										else
											TriggerClientEvent("Notify",source,"vermelho","Você infelizmente falhou.",5000)
										end

										vRPclient._stopAnim(source,false)
										active[user_id] = nil
									else
										TriggerClientEvent("Notify",source,"vermelho","Você precisa arrumar os pneus primeiro.",5000)
									end
								end
							end
						end

						if itemName == "lockpick" then
							local vehicle,vehNet,vehPlate,vehName,vehLock,vehBlock,vehHealth,vehModel,vehClass = vRPclient.vehList(source,3)
							if vehicle and vehClass ~= 15 and vehClass ~= 16 then
								if vRPclient.inVehicle(source) then
									active[user_id] = 100
									vRPclient.stopActived(source)
									vCLIENT.closeInventory(source)
									vCLIENT.blockButtons(source,true)
									vRPRAGE.startAnimHotwired(source)
	--								vRP.createDurability(itemName)

									local taskResult = vTASKBAR.taskLockpick(source)
									if taskResult then
										vRP.upgradeStress(user_id,5)
										local iddoroubado = vRP.getVehiclePlate(vehPlate)
										if iddoroubado and math.random(100) >= 50 then
											TriggerClientEvent("Notify",source,"amarelo","<b>"..vRP.vehicleName(vehName).."</b> disparou o alarme.",5000)
										end
										if math.random(100) >= 20 then
											TriggerEvent("setPlateEveryone",vehPlate)
											TriggerEvent("setPlatePlayers",vehPlate,user_id)
										end

										if math.random(100) >= 75 then
											local x,y,z = vRPclient.getPositions(source)
											local copAmount = vRP.getUsersByPermission("policia.permissao")
											for k,v in pairs(copAmount) do
												async(function()
													TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Roubo de Veículo", x = x, y = y, z = z, vehicle = vRP.vehicleName(vehName).." - "..vehPlate, rgba = {15,110,110} })
												end)
											end
										end
	--								else
	--									TriggerClientEvent("Notify",source,"vermelho","Você infelizmente falhou.",5000)
									end

									if parseInt(math.random(1000)) >= 950 then
										vRP.removeInventoryItem(user_id,itemName,1,true,slot)
									end

									vCLIENT.blockButtons(source,false)
									vRPRAGE.stopAnimHotwired(source,vehicle)
									active[user_id] = nil
								else
									active[user_id] = 100
									vRPclient.stopActived(source)
									vCLIENT.closeInventory(source)
									vCLIENT.blockButtons(source,true)
									vRPclient._playAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)

									local taskResult = vTASKBAR.taskLockpick(source)
									if taskResult then
										vRP.upgradeStress(user_id,4)
										local iddoroubado = vRP.getVehiclePlate(vehPlate)
										if iddoroubado then
											TriggerClientEvent("Notify",source,"verde","<b>"..vRP.vehicleName(vehName).."</b> foi roubado.",5000)
										end
										if math.random(100) >= 50 then
											TriggerEvent("setPlateEveryone",vehPlate)
											TriggerClientEvent("inventory:lockpickVehicle",-1,vehNet)
										end

										if math.random(100) >= 75 then
											local x,y,z = vRPclient.getPositions(source)
											local copAmount = vRP.getUsersByPermission("policia.permissao")
											for k,v in pairs(copAmount) do
												async(function()
													TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Roubo de Veículo", x = x, y = y, z = z, vehicle = vRP.vehicleName(vehName).." - "..vehPlate, rgba = {15,110,110} })
												end)
											end
										end
	--								else
	--									TriggerClientEvent("Notify",source,"vermelho","Você infelizmente falhou.",5000)
									end

									if parseInt(math.random(1000)) >= 950 then
										vRP.removeInventoryItem(user_id,itemName,1,true,slot)
									end

									vCLIENT.blockButtons(source,false)
									vRPclient._stopAnim(source,false)
									active[user_id] = nil
								end
							else
								local checkHomes,homeName = vHOMES.checkHomesTheft(source)
								if checkHomes then
									active[user_id] = 100
									vRPclient.stopActived(source)
									vCLIENT.closeInventory(source)
									vCLIENT.blockButtons(source,true)
									vRPclient.playAnim(source,false,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)

									local taskResult = vTASKBAR.taskLockpick(source)
									if taskResult then
										vRP.upgradeStress(user_id,4)
										vHOMES.enterHomesTheft(source,homeName)
										TriggerEvent("vrp:homes:ApplyTime",homeName)
									
	--								else
	--									TriggerClientEvent("Notify",source,"vermelho","Você infelizmente falhou.",5000)
									end

									if parseInt(math.random(1000)) >= 950 then
										vRP.removeInventoryItem(user_id,itemName,1,true,slot)
									end

									vRPclient._stopAnim(source,false)
									vCLIENT.blockButtons(source,false)
									active[user_id] = nil
								else
									local status,x,y,z = vCLIENT.cashRegister(source)
									if status then
										active[user_id] = 10
										vRPclient.stopActived(source)
										vCLIENT.closeInventory(source)
										vCLIENT.blockButtons(source,true)
										table.insert(registerTimers,{ x,y,z,360 })
										TriggerClientEvent("Progress",source,10000,"Utilizando...")
										TriggerClientEvent("inventory:updateRegister",-1,registerTimers)
										vRPclient._playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)

										repeat
											if active[user_id] == 0 then
												active[user_id] = nil
												vRP.upgradeStress(user_id,1)
												vRPclient._removeObjects(source)
												vCLIENT.blockButtons(source,false)
												vRP.giveInventoryItem(user_id,"dollars2",math.random(4,6),true)

												if math.random(100) >= 75 then
													vRP.wantedTimer(user_id,30) -- old is 15 need try
													local copAmount = vRP.getUsersByPermission("policia.permissao")
													for k,v in pairs(copAmount) do
														async(function()
															TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 20, title = "Roubo a Caixa Registradora", x = x, y = y, z = z, rgba = {170,80,25} })
														end)
													end
												end
											end
											Citizen.Wait(0)
										until active[user_id] == nil
									else
										if x ~= nil and y ~= nil and z ~= nil then
											for k,v in pairs(registerTimers) do
												if v[1] == x and v[2] == y and v[3] == z then
													TriggerClientEvent("Notify",source,"azul","Aguarde "..vRP.getTimers(parseInt(v[4]*10))..".",5000)
												end
												Citizen.Wait(1)
											end
										end
									end
								end
							end
						end

						if itemName == "energetic" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309,0.0,0.0,0.0,0.0,0.0,130.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeStress(user_id,4)
										TriggerClientEvent("setEnergetic",source,90,1.10)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "absolut" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.alcoholTimer(user_id,1)
										vRP.upgradeThirst(user_id,20)
										TriggerClientEvent("setDrunkTime",source,300)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "hennessy" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.alcoholTimer(user_id,1)
										vRP.upgradeThirst(user_id,20)
										TriggerClientEvent("setDrunkTime",source,300)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "chandon" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.alcoholTimer(user_id,1)
										vRP.upgradeThirst(user_id,20)
										TriggerClientEvent("setDrunkTime",source,300)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "dewars" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.alcoholTimer(user_id,1)
										vRP.upgradeThirst(user_id,20)
										TriggerClientEvent("setDrunkTime",source,300)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "water" then
							active[user_id] = 15
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,15000,"Utilizando...")
							vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_ld_flow_bottle",49,60309,0.0,0.0,0.02,0.0,0.0,130.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeThirst(user_id,100)
										vRP.giveInventoryItem(user_id,"emptybottle",1)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "sinkalmy" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_ld_flow_bottle",49,28422)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeThirst(user_id,5)
										vRP.chemicalTimer(user_id,1)
										vRP.downgradeStress(user_id,25)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "ritmoneury" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_ld_flow_bottle",49,28422)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeThirst(user_id,5)
										vRP.chemicalTimer(user_id,1)
										vRP.downgradeStress(user_id,50)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "dirtywater" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_ld_flow_bottle",49,60309)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeStress(user_id,5)
										vRP.upgradeThirst(user_id,35)
										vRPclient.downHealth(source,10)
										vRP.giveInventoryItem(user_id,"emptybottle",1)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "cola" then
							active[user_id] = 15
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,15000,"Utilizando...")
							vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_ecola_can",49,60309,0.0,0.0,0.04,0.0,0.0,130.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeThirst(user_id,100)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "soda" then
							active[user_id] = 15
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,15000,"Utilizando...")
							vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.0,0.0,-0.04,0.0,0.0,130.0)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeThirst(user_id,100)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "fishingrod" then
							if vCLIENT.fishingStatus(source) then
								active[user_id] = 30
								vCLIENT.closeInventory(source)
								vCLIENT.blockButtons(source,true)

								if not vCLIENT.fishingAnim(source) then
									vRPclient.stopActived(source)
									vRPclient._createObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
								end

								if vTASKBAR.taskFishing(source) then
									local rand = parseInt(math.random(3))
									local fishs = { "octopus","shrimp","carp" }

									if vRP.computeInvWeight(user_id) + vRP.itemWeightList(fishs[rand]) * rand <= vRP.getBackpack(user_id) then
										if vRP.tryGetInventoryItem(user_id,"bait",rand,true) then
											vRP.giveInventoryItem(user_id,fishs[rand],rand,true)
										else
											TriggerClientEvent("Notify",source,"amarelo","Você precisa de <b>"..vRP.format(rand).."x "..vRP.itemNameList("bait").."</b>.",5000)
											vRPclient._removeObjects(source,"one")
										end
									else
										TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
										vRPclient._removeObjects(source,"one")
									end
								end

								vRPclient._removeObjects(source,"one")
								vCLIENT.blockButtons(source,false)
								active[user_id] = nil
							end
						end

						if itemName == "emptybottle" then
							local status,style = vCLIENT.checkFountain(source)
							if status then
								vRPclient.stopActived(source)
								vCLIENT.blockButtons(source,true)

								if style == "fountain" then
									vCLIENT.closeInventory(source)
									vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
								elseif style == "floor" then
									vCLIENT.closeInventory(source)
									vRPclient._playAnim(source,false,{"amb@world_human_bum_wash@male@high@base","base"},true)
								end

								active[user_id] = parseInt(rAmount*5)

								TriggerClientEvent("Progress",source,parseInt(rAmount*5000),"Enchendo...")

								repeat
									if active[user_id] == 0 then
										active[user_id] = nil
										vRPclient._removeObjects(source)
										vCLIENT.blockButtons(source,false)

										if vRP.computeInvWeight(user_id)+vRP.itemWeightList(itemName) * parseInt(rAmount) <= vRP.getBackpack(user_id) then
											if vRP.tryGetInventoryItem(user_id,itemName,parseInt(rAmount),true,slot) then
												if style == "floor" then
													vRP.giveInventoryItem(user_id,"dirtywater",parseInt(rAmount))
												else
													vRP.giveInventoryItem(user_id,"water",parseInt(rAmount))
												end
											end
										end
									end
									Citizen.Wait(0)
								until active[user_id] == nil
							end
						end

						if itemName == "coffee" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.downgradeStress(user_id,50)
	--									TriggerClientEvent("setEnergetic",source,30,1.15)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "hamburger" then
							active[user_id] = 15
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,15000,"Utilizando...")
							vRPclient._createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeHunger(user_id,100)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "chocolate" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.downgradeStress(user_id,50)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "donut" then
							active[user_id] = 10
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							vCLIENT.blockButtons(source,true)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_amb_donut",49,28422)

							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vCLIENT.blockButtons(source,false)
									vRPclient._removeObjects(source,"one")

									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.downgradeStress(user_id,50)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end

						if itemName == "postit" then
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								vCLIENT.closeInventory(source)
								TriggerClientEvent("notepad:createNotepad",source)
							end
						end

						if itemName == "backpack" then
							local exp = vRP.getBackpack(user_id)
							if exp <= 50 then
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									vRP.setBackpack(user_id,100)
									TriggerClientEvent("inventory:Update",source,"updateMochila")
									vCLIENT.closeInventory(source)
								end
							else
								TriggerClientEvent("Notify",source,"vermelho","No momento você não pode usar essa mochila.",5000)
								vCLIENT.closeInventory(source)
							end
						end

						if itemName == "compost" or itemName == "bucket" or itemName == "cannabisseed" then
							local homeEnter = vHOMES.getHomeStatistics(source)
							if homeEnter == "" then
								local weWater = vWEPLANTS.checkWater(source)
								if weWater then
									TriggerClientEvent("Notify",source,"negado","Só pode ser plantado em terra firme.",3000)
									return
								end
	
									local status,x,y,z = vWEPLANTS.entityInWorldCoords(source)
									if status and vRP.getInventoryItemAmount(user_id,"compost") >= 1 and vRP.getInventoryItemAmount(user_id,"bucket") >= 1 and vRP.getInventoryItemAmount(user_id,"cannabisseed") >= 1 then
										active[user_id] = 7
										vRPclient.stopActived(source)
										vCLIENT.closeInventory(source)
										vCLIENT.blockButtons(source,true)
										TriggerClientEvent("Progress",source,7000,"Utilizando...")
										vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
	
										repeat
											if active[user_id] == 0 then
												active[user_id] = nil
												vRPclient._stopAnim(source,false)
												vCLIENT.blockButtons(source,false)
	
												if vRP.tryGetInventoryItem(user_id,"compost",1,true) and vRP.tryGetInventoryItem(user_id,"bucket",1,true) and vRP.tryGetInventoryItem(user_id,"cannabisseed",1,true) then
													vRP.weedTimer(user_id,1)
													vRP.upgradeStress(user_id,1)
													vWEPLANTS.pressPlants(source,x,y,z)
												end
											end
											Citizen.Wait(0)
										until active[user_id] == nil
									else
										TriggerClientEvent("Notify",source,"negado","Voce nao possui todos os itens.",6000)
									end
								--end
							end
						end

						if itemName == "tires" then
							local veh,vnetid,placa,vname,lock,banned,work = vRPclient.vehList(source,7)
							if veh then
							TriggerClientEvent("mike:pneunamao",source)
							else
								TriggerClientEvent("Notify",source,"negado","Você não está próximo à nenhum veículo.",8000)
							end
						end

						if itemName == "premiumplate" then
							vCLIENT.closeInventory(source)

							local vehModel = vRP.prompt(source,"Nome de Spawn do veículo:","")
							if vehModel == "" then
								return
							end

							local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(vehModel) })
							if vehicle[1] then
								local vehPlate = vRP.prompt(source,"Nova placa do veículo:","")
								if vehPlate == "" or string.upper(vehPlate) == "Ipanema" then
									return
								end

								local plateUserId = vRP.getVehiclePlate(vehPlate)
								if plateUserId then
									TriggerClientEvent("Notify",source,"vermelho","A placa escolhida já está sendo usada por outro veículo.",5000)
									return
								end

								local plateCheck = sanitizeString(vehPlate,"abcdefghijklmnopqrstuvwxyz0123456789",true)
								if plateCheck and string.len(plateCheck) == 8 then
									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.execute("vRP/update_plate_vehicle",{ user_id = parseInt(user_id), vehicle = tostring(vehModel), plate = string.upper(tostring(vehPlate)) })
										TriggerClientEvent("Notify",source,"sucesso","Placa atualizada com sucesso.",5000)
									end
								else
									TriggerClientEvent("Notify",source,"importante","O nome da definição para placas deve conter no máximo 8 caracteres e podem ser usados números e letras minúsculas.",5000)
								end
							else
								TriggerClientEvent("Notify",source,"vermelho","Modelo de veículo não encontrado em sua garagem.",5000)
							end
						end

						
						if itemName == "namechange" then
							vCLIENT.closeInventory(source)
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then

							local newName = vRP.prompt(source,"O seu novo Primeiro nome:","")
							if newName == "" then
								return
							end

							local newLastName = vRP.prompt(source,"O seu novo Sobrenome:","")
							if newLastName == "" then
								return
							end
							
							vRP.execute("vRP/rename_characters",{ id = user_id, name = newName, name2 = newLastName })
						end
						end

						if itemName == "plate" then
							if not vRPclient.inVehicle(source) then
								local vehicle,vehNet = vRPclient.vehList(source,3)
								if vehicle then
									active[user_id] = 30
									vRPclient.stopActived(source)
									vCLIENT.closeInventory(source)
									vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
		
									local taskResult = vTASKBAR.taskThree(source)
									if taskResult then
										if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										local plate = vRP.genPlate()
										vCLIENT.plateApply(source,plate)
										TriggerEvent("setPlateEveryone",plate)
										TriggerClientEvent("Notify",source,"sucesso","Placa do veiculo clonada.",7000)
									end
								else
									TriggerClientEvent("Notify",source,"vermelho","Voce falhou.",7000)
								end
									vRPclient._stopAnim(source,false)
									active[user_id] = nil
								end
							end
						end

						if itemName == "fueltech" then
							if vRPclient.inVehicle(source) then
								if vCLIENT.techDistance(source) then
									local vehPlate = vRPclient.vehiclePlate(source)
									local plateUsers = vRP.getVehiclePlate(vehPlate)
									if not plateUsers then
										active[user_id] = 30
										vCLIENT.closeInventory(source)
										vCLIENT.blockButtons(source,true)
										TriggerClientEvent("Progress",source,30000,"Utilizando...")
										vRPclient._playAnim(source,true,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

										repeat
											if active[user_id] == 0 then
												active[user_id] = nil
												vRPclient._stopAnim(source,false)
												vCLIENT.blockButtons(source,false)

												if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
													TriggerClientEvent("admin:vehicleTuning",source)
												end
											end
											Citizen.Wait(0)
										until active[user_id] == nil
									end
								end
							end
						end

						if itemName == "radio" then
							vRPclient.stopActived(source)
							vCLIENT.closeInventory(source)
							TriggerClientEvent("radio:openSystem",source)
						end

						if itemName == "divingsuit" then
							if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
								TriggerClientEvent("hud:setDiving",source)
							end
						end

						if itemName == "handcuff" then
							
							vCLIENT.AlgemarInv(source)
						end

						if itemName == "hood" then
							local nplayer = vRPclient.nearestPlayer(source,1)
							if nplayer and vPLAYER.getHandcuff(nplayer) then
								TriggerClientEvent("hud:toggleHood",nplayer)
							end
						end

						if itemName == "rope" then
							if not vPLAYER.getHandcuff(source) then
								local nplayer = vRPclient.nearestPlayer(source,2)
								if nplayer and not vRPclient.inVehicle(source) then
									local taskResult = vTASKBAR.taskHandcuff(nplayer)
									if not taskResult then
										TriggerClientEvent("rope:toggleRope",source,nplayer)
									else
										TriggerClientEvent("Notify",source,"amarelo","O cidadão resistiu ao ser carregado.",5000)
									end
								end
							else
								TriggerClientEvent("Notify",source,"amarelo","Você está algemado.",5000)
							end	
						end

						if itemName == "c4" then
							TriggerClientEvent("cashmachine:machineRobbery",source)
						end

						if itemName == "premium01" then
							local identity = vRP.getUserIdentity(user_id)
							if identity then
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									if not vRP.getPremium(user_id) then
										vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), predays = 3, priority = 15 })
									else
										vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 3 })
									end
								end
							end
						end

						if itemName == "premium02" then
							local identity = vRP.getUserIdentity(user_id)
							if identity then
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									if not vRP.getPremium(user_id) then
										vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), predays = 7, priority = 30 })
									else
										vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 7 })
									end
								end
							end
						end

						if itemName == "premium03" then
							local identity = vRP.getUserIdentity(user_id)
							if identity then
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									if not vRP.getPremium(user_id) then
										vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), predays = 15, priority = 45 })
									else
										vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 15 })
									end
								end
							end
						end

						if itemName == "premium04" then
							local identity = vRP.getUserIdentity(user_id)
							if identity then
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									if not vRP.getPremium(user_id) then
										vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), predays = 30, priority = 60 })
									else
										vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 30 })
									end
								end
							end
						end
						
						if itemName == "newchars" then
							local identity = vRP.getUserIdentity(user_id)
							if identity then
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									if not vRP.getPremium(user_id) then
										vRP.execute("vRP/set_morechars",{ steam = identity.steam })
									end
								end
							end
						end
						
						if itemName == "gemstone" then
							local identity = vRP.getUserIdentity(user_id)
							if identity then
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									vRP.execute("vRP/set_vRP_gemsitem",{ steam = identity.steam })
								end
							end
						end

						if itemName == "pager" then
							local nplayer = vRPclient.nearestPlayer(source,2)
							if nplayer then
								local nuser_id = vRP.getUserId(nplayer)
								if nuser_id then
									if vRP.hasPermission(nuser_id,"Police") then
										TriggerClientEvent("radio:outServers",nplayer)
										TriggerEvent("blipsystem:serviceExit",nplayer)
										vRP.removePermission(vRP.getUserSource(nuser_id),"Police")
										vRP.execute("vRP/upd_group",{ user_id = nuser_id, permiss = "Police", newpermiss = "waitPolice" })
										TriggerClientEvent("Notify",source,"verde","Comunicações da polícia foram retiradas.",5000)
									end
								end
							end
						end
						if itemName == "eletronics" then
							local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
							local plateUser = vRP.getVehiclePlate(vehPlate)
							local identity = vRP.getUserIdentity(plateUser)
							if not vCLIENT.getItem(source) then
								TriggerClientEvent("Notify",source,"amarelo","Você deve estar com uma Chave Inglesa em mãos.",5000)
							else	
								if vehicle then
									local vehicle = vRP.query("vRP/temgps",{ user_id = identity.id, vehicle = vehName })
									if vehicle[1]  == nil then
										TriggerClientEvent("Notify",source,"GPS","Veículo não tem gps.",5000)
									else
										TriggerClientEvent("Progress",source,10000,"Utilizando...")
										vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
										vCLIENT.closeInventory(source)
										vCLIENT.blockButtons(source,true)
										Citizen.Wait(10000)
										if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
											vRP.execute("vRP/update_gps",{ gps = 0, user_id = identity.id, vehicle = vehName })
											vRPclient._stopAnim(source,false)
											vCLIENT.blockButtons(source,false)
										end
									end		
								end
							end	
						end
						if itemName == "cpuchip" then
							local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
							local plateUser = vRP.getVehiclePlate(vehPlate)
							local identity = vRP.getUserIdentity(plateUser)
							if vehicle then
								local vehicle = vRP.query("vRP/temgps",{ user_id = identity.id, vehicle = vehName })
								if vehicle[1]  ~= nil then
									TriggerClientEvent("Notify",source,"GPS","Veículo já tem gps.",5000)
								else
									TriggerClientEvent("Progress",source,10000,"Utilizando...")
									vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
									vCLIENT.closeInventory(source)
									vCLIENT.blockButtons(source,true)
									Citizen.Wait(10000)
									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.execute("vRP/update_gps",{ gps = 1, user_id = identity.id, vehicle = vehName })
										vRPclient._stopAnim(source,false)
										vCLIENT.blockButtons(source,false)
									end
								end		
							end
						end
						if itemName == "solvente" then
							local user_id = vRP.getUserId(source)
							local polvora = vRP.fireReturn(user_id)
							if polvora == 1 then
								vCLIENT.closeInventory(source)
								TriggerClientEvent("Progress",source,10000,"Limpando as mãos...")
								vRPclient._playAnim(source,true,{"missfbi3_camcrew","final_loop_guy"},true)
								Citizen.Wait(10000)
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									vRP.firedown(user_id,1)
									TriggerClientEvent("Notify",source,"verde","Você lavou suas mãos.",5000)
									vRPclient._stopAnim(source,false)
								end
							else
								TriggerClientEvent("Notify",source,"vermelho","Suas mãos já estão limpas.",5000)
							end
						end


					else
						TriggerClientEvent("Notify",source,"amarelo","Você está algemado.",5000)
					end		
					end

				if vRP.itemTypeList(itemName) == "equip" then
					-- TriggerClientEvent("inventory:Update",source,"updateMochila")
					-- local pistols =     {"WEAPON_PISTOL_MK2", "WEAPON_COMBATPISTOL", "WEAPON_SKSPISTOL", "WEAPON_PISTOL","WEAPON_APPISTOL","WEAPON_PISTOL50","WEAPON_SNSPISTOL","WEAPON_SNSPISTOL_MK2","WEAPON_HEAVYPISTOL","WEAPON_VINTAGEPISTOL","WEAPON_FLAREGUN","WEAPON_MARKMANPISTOL","WEAPON_REVOLVER","WEAPON_REVOLVER_MK2","WEAPON_DOUBLEACTION","WEAPON_CERAMICPISTOL","WEAPON_NAVYREVOLVER","WEAPON_GADGETPISTOL","WEAPON_RAYPISTOL"}
					-- local submachine =  {"WEAPON_MICROSMG","WEAPON_SMG","WEAPON_SMG_MK2","WEAPON_ASSAULTSMG","WEAPON_COMBATPDW","WEAPON_MACHINEPISTOL","WEAPON_MINISMG","WEAPON_GUSENBERG","WEAPON_RPG"}
					-- local shotgun =     {"WEAPON_PUMPSHOTGUN","WEAPON_PUMPSHOTGUN_MK2","WEAPON_SAWNOFFSHOTGUN","WEAPON_ASSAULTSHOTGUN","WEAPON_BULLUPSHOTGUN","WEAPON_MUSKET","WEAPON_HEAVYSHOTGUN","WEAPON_DBSHOTGUN","WEAPON_AUTOSHOTGUN","WEAPON_COMBATSHOTGUN" }
					-- local rifles =      {"WEAPON_ASSAULTRIFLE", "WEAPON_ASSAULTRIFLE_MK2", "WEAPON_CARBINERIFLE","WEAPON_CARBINERIFLE_MK2","WEAPON_ADVANCEDRIFLE", "WEAPON_SPECIALCARBINE","WEAPON_SPECIALCARBINE_MK2","WEAPON_BULLUPRIFLE","WEAPON_BULLUPRIFLE_MK2","WEAPON_COMPACTRFILE","WEAPON_MILITARYRIFLE"}
					-- local weaponsList = vRPclient.getWeapons(source)
					-- local weaponName = string.gsub(itemName,"wbody|","")
					-- if has_value(pistols, weaponName) then
					-- 	for k,v in pairs(weaponsList) do
					-- 		if has_value(pistols, k) then
					-- 			TriggerClientEvent("Notify",source,"amarelo","Você já possui uma <b>pistola</b> equipada.",5000)
					-- 			return
					-- 		end
					-- 	end
					-- end
					-- if has_value(submachine, weaponName) then
					-- 	for k,v in pairs(weaponsList) do
					-- 		if has_value(submachine, k) then
					-- 			TriggerClientEvent("Notify",source,"amarelo","Você já possui uma <b>submachine</b> equipada.",5000)
					-- 			return
					-- 		end
					-- 	end
					-- end
					-- if has_value(shotgun, weaponName) then
					-- 	for k,v in pairs(weaponsList) do
					-- 		if has_value(shotgun, k) then
					-- 			TriggerClientEvent("Notify",source,"amarelo","Você já possui uma <b>shotgun</b> equipada.",5000)
					-- 			return
					-- 		end
					-- 	end
					-- end
					-- if has_value(rifles, weaponName) then
					-- 	for k,v in pairs(weaponsList) do
					-- 		if has_value(rifles, k) then
					-- 			TriggerClientEvent("Notify",source,"amarelo","Você já possui um <b>rifle</b> equipada.",5000)
					-- 			return
					-- 		end
					-- 	end
					-- end
					vCLIENT.closeInventory(source)
					vCLIENT.weaponItem(source,tostring(itemName))
					
					if vCLIENT.getItem(source) then
						--local vehicle = vRPclient.getNearVehicle(source,15)
						local vehicle,vehNet,vehPlate,vehName,vehLock,vehBlock,vehHealth,vehModel,vehClass = vRPclient.vehList(source,3)
						if vehicle then
							TriggerClientEvent("roubarpneu",source)	
						end	
					end	
                    
                end
				--MODIFICADO
                if vRP.itemTypeList(itemName) == "recharge" then
					if vCLIENT.rechargeCheck(source,itemName) then
	
						if parseInt(rAmount) >= 250 then
							rAmount = 250
						end
	
						if vRP.tryGetInventoryItem(user_id,itemName,parseInt(rAmount),true,slot) then
							vCLIENT.rechargeWeapon(source,itemName,parseInt(rAmount))
							vCLIENT.closeInventory(source)
							TriggerClientEvent("inventory:Update",source,"updateMochila")
						end
					end
				end
            end

            TriggerClientEvent("inventory:Update",source,"updateMochila")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gmuni",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
            local weapons = vRPclient.replaceWeapons(source)
			local durability = vRP.getInventoryItemDurability(user_id,weapons)
            for k,v in pairs(weapons) do
                --vRP.giveInventoryItem(user_id,k,1,true,true,parseInt(durability))
				--vRP.giveInventoryItem(user_id,k,1)
                if v.ammo > 0 then
                    vRP.giveInventoryItem(user_id,vRP.itemAmmoList(k),v.ammo)
                end
            end
            --vRPclient.updateWeapons(source)

            TriggerClientEvent("Notify",source,"verde","Suas munições foram todas guardadas.",5000)
        end
    end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- UPDATE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function func.updateWeaponAmmo(weapon,ammo)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		local ammoType = getAmmoTypeByWeapon(weapon)
-- 		if ammoType ~= "" then
-- 			vRP.remAmmoWeaponId(user_id,ammoType,ammo)
-- 		end
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooksendLog = 'https://discord.com/api/webhooks/1009482985499795466/hS5ICqH2NLJn0kPtk7LHSJoeMNDiv7b5X8Os7v1aqLk5CL7PDEnFTIOoJrAWAVSzgT0h'
RegisterNetEvent("inventory:sendItem")
AddEventHandler("inventory:sendItem",function(itemName,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiapaisana.permissao") then

		for k,v in pairs(_weapon) do 
			if v == itemName then
				vCLIENT.closeInventory(source)
				TriggerClientEvent("Notify",source,"vermelho","Policias não podem enviar armas.",5000)

				return 
			end	
			
		end	
	end
	if user_id then
		if active[user_id] == nil and not vPLAYER.getHandcuff(source) then
			if amount == nil then amount = 1 end
			if amount <= 0 then amount = 1 end

			if not vRP.wantedReturn(user_id) then
				local nplayer = vRPclient.nearestPlayer(source,3)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						if vRP.computeInvWeight(nuser_id) + vRP.itemWeightList(itemName) * parseInt(amount) <= vRP.getBackpack(nuser_id) then
							if vRP.itemSubTypeList(itemName) then
								if vRP.getInventoryItemAmount(nuser_id,itemName) > 0 then
									TriggerClientEvent("Notify",source,"vermelho","O cidadão já possúi um item do mesmo.",5000)
								else
									local durability = vRP.getInventoryItemDurability(user_id,itemName)
									if vRP.tryGetInventoryItem(user_id,itemName,amount,true) then
										func.getammo(source)
										vCLIENT.setUNARMED(source)
										vRP.giveInventoryItem(nuser_id,itemName,amount,true,nil,parseInt(durability))
										TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
										vRPclient._playAnim(source,true,{"pickup_object","putdown_low"},false)
										local identity = vRP.getUserIdentity(user_id)
										local identitynu = vRP.getUserIdentity(nuser_id)
	
										PerformHttpRequest(webhooksendLog, function(err, text, headers) end, 'POST', json.encode({
											embeds = {
												{ 
													title = "ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
													thumbnail = {
													url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png"
													}, 
													fields = {
														{ 
															name = "**Registro do usuário que enviou:**", 
															value = "` "..identity.name.." "..identity.name2.." ` "
														},
														{ 
															name = "**Registro do usuário que recebeu:**", 
															value = "` "..identitynu.name.." "..identitynu.name2.." ` "
														},
														{ 
															name = "**Nº do ID que enviou:**", 
															value = "` "..user_id.." ` "
														},
														{ 
															name = "**Nº do ID que recebeu:**", 
															value = "` "..nuser_id.." ` "
														},
														{ 
															name = "**Nome do item:**", 
															value = "` "..itemName.." ` "
														},
														{ 
															name = "**Quantidade do item:**", 
															value = "` "..amount.." ` "
														},
													}, 
													footer = { 
														text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
														icon_url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png" 
													},
													color = 15914080 
												}
											}
										}), { ['Content-Type'] = 'application/json' })

										Citizen.Wait(750)
										vRPclient._removeObjects(source)
										func.getammo(source)
										vCLIENT.setUNARMED(source)
										

									end
								end
							else
								if vRP.tryGetInventoryItem(user_id,itemName,parseInt(amount),true) then
									vRP.giveInventoryItem(nuser_id,itemName,parseInt(amount),true)
									TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
									vRPclient._playAnim(source,true,{"pickup_object","putdown_low"},false)
									local identity = vRP.getUserIdentity(user_id)
									local identitynu = vRP.getUserIdentity(nuser_id)

									PerformHttpRequest(webhooksendLog, function(err, text, headers) end, 'POST', json.encode({
										embeds = {
											{ 
												title = "ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
												thumbnail = {
												url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png"
												}, 
												fields = {
													{ 
														name = "**Registro do usuário que enviou:**", 
														value = "` "..identity.name.." "..identity.name2.." ` "
													},
													{ 
														name = "**Registro do usuário que recebeu:**", 
														value = "` "..identitynu.name.." "..identitynu.name2.." ` "
													},
													{ 
														name = "**Nº do ID que enviou:**", 
														value = "` "..user_id.." ` "
													},
													{ 
														name = "**Nº do ID que recebeu:**", 
														value = "` "..nuser_id.." ` "
													},
													{ 
														name = "**Nome do item:**", 
														value = "` "..itemName.." ` "
													},
													{ 
														name = "**Quantidade do item:**", 
														value = "` "..amount.." ` "
													},
												}, 
												footer = { 
													text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
													icon_url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png" 
												},
												color = 15914080 
											}
										}
									}), { ['Content-Type'] = 'application/json' })
									Citizen.Wait(750)
									vRPclient._removeObjects(source)
									func.getammo(source)
									vCLIENT.setUNARMED(source)
								end
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local dropLog = 'https://discord.com/api/webhooks/1009184766404350033/OEMuawVE-yg7FjXzc5e1z7gR_9Z59dV-tOjZe55-qcQVmonYAp5fiwo8ZG206X0rpdr7'
RegisterNetEvent("inventory:dropItem")
AddEventHandler("inventory:dropItem",function(itemName,amount,bole)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiapaisana.permissao") then

		for k,v in pairs(_weapon) do 
			if v == itemName then
				vCLIENT.closeInventory(source)
				TriggerClientEvent("Notify",source,"vermelho","Policias não podem dropar armas.",5000)

				return 
			end	
			
		end	
	end
	weaponrechenger[itemName] = false

	--if user_id then
		local x,y,z = vRPclient.getPosition(source)
		if parseInt(amount) > 0 then
			-- vCLIENT.removeWeaponInHand(source)
			if bole == true then
				local durability = vRP.getInventoryItemDurability(user_id,itemName)
	    		if vRP.tryGetInventoryItem(user_id,itemName,parseInt(amount)) then
	    			TriggerEvent("itemdrop:Create",itemName,parseInt(amount),source,durability)
					vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vCLIENT.closeInventory(source)
				end
			else
				TriggerEvent("itemdrop:Create",itemName,parseInt(amount),source)
				vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
				TriggerClientEvent("inventory:Update",source,"updateMochila")
				vCLIENT.closeInventory(source)
			end
			
		end
		local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
		end
		PerformHttpRequest(dropLog, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
					thumbnail = {
					url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png"
					}, 
					fields = {
						{ 
							name = "**Nº do ID:**", 
							value = "` "..user_id.." ` "
						},
						{ 
							name = "**Nome do item:**", 
							value = "` "..itemName.." ` "
						},
						{ 
							name = "**Quantidade do item:**", 
							value = "` "..parseInt(amount).." `\n⠀"
						}
					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png" 
					},
					color = 15914080 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
		func.getammo(source)
		vCLIENT.setUNARMED(source)
		
		
	
	--end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local droplist = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("itemdrop:Create")
AddEventHandler("itemdrop:Create",function(item,count,source,durability)
    local id = idgens:gen()
    local x,y,z = vRPclient.getPositions(source)
    droplist[id] = { item = item, count = count, x = x, y = y, z = z, economy = vRP.itemEconomyList(item),tipo = vRP.itemTipoList(item), unity = vRP.itemUnityList(item), desc = vRP.itemDescList(item), name = vRP.itemNameList(item), durability = durability,  index = vRP.itemIndexList(item), peso = vRP.itemWeightList(item) }
    TriggerClientEvent("itemdrop:Players",-1,id,droplist[id])
	TriggerClientEvent("inventory:Update",source,"updateMochila") -- try
	local nplayer = vRPclient.nearestPlayer(source,5)
		if nplayer then
			TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
		end
end)
-- ROUBO
RegisterServerEvent("vrp_itemdrop:Create")
AddEventHandler("vrp_itemdrop:Create",function(item,count,x,y,z,source)
    local id = idgens:gen()
    droplist[id] = { item = item, count = count, x = x, y = y, z = z,economy = vRP.itemEconomyList(item), tipo = vRP.itemTipoList(item), unity = vRP.itemUnityList(item), desc = vRP.itemDescList(item), name = vRP.itemNameList(item),  index = vRP.itemIndexList(item), peso = vRP.itemWeightList(item) }
    TriggerClientEvent("itemdrop:Players",-1,id,droplist[id])
	TriggerClientEvent("inventory:Update",source,"updateMochila") -- try
	local nplayer = vRPclient.nearestPlayer(source,5)
	if nplayer then
		TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
local giveLog = 'https://discord.com/api/webhooks/1009206531457286164/5utCT9BS3PN5i8AuqSUJnTnkt_8z4HFF7DgcfRfMY5UoQmLeCdE1sTPKTob2-Xl0YsTh'
RegisterServerEvent("itemdrop:Pickup")
AddEventHandler("itemdrop:Pickup",function(id,slot,amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local inv = vRP.getInventory(user_id)
    if droplist[id] == nil then
        return
    else
    if vRP.computeInvWeight(user_id) + vRP.itemWeightList(tostring(droplist[id].item)) * parseInt(droplist[id].count) <= vRP.getBackpack(user_id) then
	TriggerClientEvent("inventory:Update",source,"updateMochila")
	vCLIENT.closeInventory(source)
        if droplist[id].count - amount >= 1 then 
			if vRP.itemSubTypeList(droplist[id].item) then
				if vRP.getInventoryItemAmount(user_id,droplist[id].item) > 0 then
					TriggerClientEvent("Notify",source,"vermelho","Você já possui esse tipo de item.",5000)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vCLIENT.closeInventory(source)
					return
				else
					TriggerClientEvent("itemdrop:Remove",-1,id)
					vRP.giveInventoryItem(user_id,tostring(droplist[id].item),parseInt(amount),true,slot,parseInt(droplist[id].durability))
					local newamount = droplist[id].count - amount
					vCLIENT.dropItem(source,droplist[id].item,newamount)
					vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
					PerformHttpRequest(giveLog, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "PEGOU:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
								thumbnail = {
								url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png"
								}, 
								fields = {
									{ 
										name = "**Nº do ID:**", 
										value = "` "..user_id.." ` "
									},
									{ 
										name = "**Nome do item:**", 
										value = "` "..droplist[id].item.." ` "
									},
									{ 
										name = "**Quantidade do item:**", 
										value = "` "..amount.." `\n⠀"
									}
								}, 
								footer = { 
									text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
									icon_url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png" 
								},
								color = 15914080 
							}
						}
					}), { ['Content-Type'] = 'application/json' })
					droplist[id] = nil
					idgens:free(id)
				end
			else
				TriggerClientEvent("itemdrop:Remove",-1,id)
				vCLIENT.closeInventory(source)
				vRP.giveInventoryItem(user_id,tostring(droplist[id].item),parseInt(amount),true,slot,parseInt(droplist[id].durability))
				local newamount = droplist[id].count - amount
				vCLIENT.dropItem(source,droplist[id].item,newamount)
				vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
				PerformHttpRequest(giveLog, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "PEGOU:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
							thumbnail = {
							url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png"
							}, 
							fields = {
								{ 
									name = "**Nº do ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**Nome do item:**", 
									value = "` "..droplist[id].item.." ` "
								},
								{ 
									name = "**Quantidade do item:**", 
									value = "` "..amount.." `\n⠀"
								}
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png" 
							},
							color = 15914080 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
				droplist[id] = nil
				idgens:free(id)
			end
            return
        else
			if vRP.itemSubTypeList(droplist[id].item) and amount > 1 then
				if vRP.getInventoryItemAmount(user_id,droplist[id].item) > 0 then
					TriggerClientEvent("Notify",source,"vermelho","Você já possui esse tipo de item.",5000)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vCLIENT.closeInventory(source)
					return
				else
					TriggerClientEvent("itemdrop:Remove",-1,id)
					vRP.giveInventoryItem(user_id,tostring(droplist[id].item),parseInt(droplist[id].count),true,slot,parseInt(droplist[id].durability))
					vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
					PerformHttpRequest(giveLog, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "PEGOU:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
								thumbnail = {
								url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png"
								}, 
								fields = {
									{ 
										name = "**Nº do ID:**", 
										value = "` "..user_id.." ` "
									},
									{ 
										name = "**Nome do item:**", 
										value = "` "..droplist[id].item.." ` "
									},
									{ 
										name = "**Quantidade do item:**", 
										value = "` "..amount.." `\n⠀"
									}
								}, 
								footer = { 
									text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
									icon_url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png" 
								},
								color = 15914080 
							}
						}
					}), { ['Content-Type'] = 'application/json' })
					droplist[id] = nil
					idgens:free(id)
				end
			else
				TriggerClientEvent("itemdrop:Remove",-1,id)
				vRP.giveInventoryItem(user_id,tostring(droplist[id].item),parseInt(droplist[id].count),true,slot,parseInt(droplist[id].durability))
				vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
				PerformHttpRequest(giveLog, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 
							title = "PEGOU:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
							thumbnail = {
							url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png"
							}, 
							fields = {
								{ 
									name = "**Nº do ID:**", 
									value = "` "..user_id.." ` "
								},
								{ 
									name = "**Nome do item:**", 
									value = "` "..droplist[id].item.." ` "
								},
								{ 
									name = "**Quantidade do item:**", 
									value = "` "..amount.." `\n⠀"
								}
							}, 
							footer = { 
								text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								icon_url = "https://cdn.discordapp.com/attachments/664627490228011099/945190825678229504/96x96_ComFundo.png" 
							},
							color = 15914080 
						}
					}
				}), { ['Content-Type'] = 'application/json' })
				droplist[id] = nil
				idgens:free(id)
			end
        end
    else
        TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",3000)
		vCLIENT.closeInventory(source)
        end
    end

    local nplayer = vRPclient.nearestPlayer(source,5)
    if nplayer then
        TriggerClientEvent("inventory:Update",nplayer,"updateMochila")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("itemdrop:Update",source,droplist)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if not vRP.getPremium(user_id) then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			vRP.execute("vRP/update_priority",{ steam = identity.steam })
		end
	end

	if active[user_id] then
		active[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- inventory:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if active[user_id] ~= nil and active[user_id] > 0 then
			active[user_id] = nil
			TriggerClientEvent("Progress",source,1500,"Cancelando...")

			SetTimeout(1000,function()
				vRPclient._removeObjects(source)
				vCLIENT.blockButtons(source,false)
				vRPRAGE.updateHotwired(source,false)
			end)
		else
			vRPclient._removeObjects(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if active[user_id] ~= nil and active[user_id] > 0 then
			return false
		end
		return true
	end
end

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end