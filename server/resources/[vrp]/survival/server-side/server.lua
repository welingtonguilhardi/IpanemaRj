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
Tunnel.bindInterface("survival",cRP)
vCLIENT = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"dono.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					vCLIENT._revivePlayer(nplayer,200)
					--vRP.upgradeThirst(parseInt(args[1]),100)
					--vRP.upgradeHunger(parseInt(args[1]),100)
					--vRP.downgradeStress(parseInt(args[1]),100)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
				end
			else
				--vRP.upgradeThirst(user_id,100)
				--vRP.upgradeHunger(user_id,100)
				--vRPclient.setArmour(source,100)
				--vRP.downgradeStress(user_id,100)
				vCLIENT._revivePlayer(source,200)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"staff.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					vCLIENT._revivePlayer(nplayer,102)
					--vRP.upgradeThirst(parseInt(args[1]),100)
					--vRP.upgradeHunger(parseInt(args[1]),100)
					--vRP.downgradeStress(parseInt(args[1]),100)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
				end
			else
				--vRP.upgradeThirst(user_id,100)
				--vRP.upgradeHunger(user_id,100)
				--vRPclient.setArmour(source,100)
				--vRP.downgradeStress(user_id,100)
				vCLIENT._revivePlayer(source,102)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- kill
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kill",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"dono.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					vCLIENT._revivePlayer(nplayer,101)
					--vRP.upgradeThirst(parseInt(args[1]),100)
					--vRP.upgradeHunger(parseInt(args[1]),100)
					--vRP.downgradeStress(parseInt(args[1]),100)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
				end
			else
				--vRP.upgradeThirst(user_id,100)
				--vRP.upgradeHunger(user_id,100)
				--vRPclient.setArmour(source,100)
				--vRP.downgradeStress(user_id,100)
				vCLIENT._revivePlayer(source,101)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("good",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"dono.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					vRP.upgradeThirst(parseInt(args[1]),100)
					vRP.upgradeHunger(parseInt(args[1]),100)
					vRP.downgradeStress(parseInt(args[1]),100)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
				end
			else
				vRP.upgradeThirst(user_id,100)
				vRP.upgradeHunger(user_id,100)
				vRP.downgradeStress(user_id,100)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("health",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"dono.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					vCLIENT._revivePlayer(nplayer,200)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
				end
			else
				vCLIENT._revivePlayer(source,200)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("armour",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"dono.permissao") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					vRPclient.setArmour(nplayer,100)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
				end
			else
				vRPclient.setArmour(source,100)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,parseInt(number))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("re",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"dono.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then
			local nplayer = vRPclient.nearestPlayer(source,2)
			if nplayer then
				if vRPclient.getHealth(nplayer) <= 101 then
					TriggerClientEvent("Progress",source,10000,"Revivendo...")
					TriggerClientEvent("cancelando",source,true)
					vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
					SetTimeout(10000,function()
						vRPclient._removeObjects(source)
						vCLIENT._revivePlayer(nplayer,110)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("cancelando",source,false)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.ResetPedToHospital()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local clear = vRP.clearInventory(user_id)
			if clear then
				vRPclient._clearWeapons(source)
				Wait(2000)
			end
		end
	end