-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vBARBER = Tunnel.getInterface("barbershop")
vTATTOOS = Tunnel.getInterface("tattoos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("admin",cRP)
vCLIENT = Tunnel.getInterface("admin")
vHOMES = Tunnel.getInterface("homes")

local screenshotOptions = {
	encoding = "png",
	quality = 1
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookadmin = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookkick = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookfac = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookkeys = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookcds = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookblacklist = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookgive = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookban = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookadminwl = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookunwl = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookadmingod = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookinfernao = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhooktroxao = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"
local webhookaddcar = "https://discord.com/api/webhooks/943690850498641941/TzmM5KwLHB1RVk-Xwjpk5-QsSoeIDO_YqXLQrgLQ6DuWE9bQ1SBZXzH14r_oj0s69kp4"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		vCLIENT.setDiscord(source,"#"..user_id.." "..identity.name.." "..identity.name2)
		TriggerClientEvent(source,"active:checkcam",true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ney",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id, "nc.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                if nplayer then
                    TriggerClientEvent("ney",nplayer,args[1])
                end
            end
        end
    end
end)

-- TROCAR SEXO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('smulher',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local mulher = "mp_f_freemode_01"
    if vRP.hasPermission(user_id,"admin.permissao") then
        TriggerClientEvent("skinmenu",source,mulher)
        vRPclient.setHealth(source,400)
    end
end)

RegisterCommand('shomem',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local homem = "mp_m_freemode_01"
    if vRP.hasPermission(user_id,"admin.permissao") then
        TriggerClientEvent("skinmenu",source,homem)
        vRPclient.setHealth(source,400)
    end
end)

-----------------------------------------------------------------------------
------ SPANWAR ARMA /arma ------
-----------------------------------------------------------------------------
local qtdAmmunition = 250 --// Quantidade de balas
local itemlist = {
    ["WEAPON_COMPACTRIFLE"] = { arg = "akcompacta" }, --// pra adicionais mais armas só pegar id modelo em https://wiki.rage.mp/index.php?title=Weapons // em arg= "nome spawn que vai ser a arma"
    ["WEAPON_PISTOL_MK2"] = { arg = "five" },
    ["WEAPON_ASSAULTSMG"] = { arg = "smg" },
    ["WEAPON_SPECIALCARBINE_MK2"] = { arg = "g36" },
    ["WEAPON_SPECIALCARBINE"] = { arg = "parafal" },
    ["WEAPON_RAYPISTOL"] = { arg = "adm" },
    ["WEAPON_COMBATPISTOL"] = { arg = "glock" }, --// não esquece, ultima arma não tem virgula e as demais sim
	["WEAPON_ASSAULTRIFLE"] = { arg = "ak" }
}
RegisterCommand('a',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
        if vRP.hasPermission(user_id,"arma.permissao") then --// troca a permissão de quem pode usar o comando // pra ter log, so copiar uma log do vrp_admin la bo inicio e subistituir por "webhookarma" e o link
        if args[1] then
            for k,v in pairs(itemlist) do
                if v.arg == args[1] then
                    result = k
                    vRPclient.giveWeapons(source,{[result] = { ammo = qtdAmmunition }})
					SendWebhookMessage(webhookarma,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..(args[1]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                end
            end
        end
    end
end)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--RGBCAR
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rgbcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        TriggerClientEvent('rgbcar',source)
        TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> RGB com sucesso.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id, "nc.permissao") then
        if args[1] then
            local tuser_id = tonumber(args[1])
            local tplayer = vRP.getUserSource(tonumber(tuser_id))
            local tplayerID = vRP.getUserId (tonumber(tplayer))
                if tplayerID ~= nil then
                local identity = vRP.getUserIdentity(user_id)
                    vRP.clearInventory(tuser_id)
                    TriggerClientEvent("Notify",source,"amarelo","Limpou inventario do ID "..args[1].."</b>.",3000)
                else
                    TriggerClientEvent("Notify",source,"vermelho","Algo deu errado.",3000)
            end
        else
            vRP.clearInventory(user_id)
            TriggerClientEvent("Notify",source,"amarelo","Você limpou seu inventário.",3000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "dono.permissao") then
		TriggerClientEvent("skinmenu",source,args[2])
		TriggerClientEvent("Notify",source,"amarelo","Setada a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.",5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") then
			if args[1] and args[2] and vRP.itemNameList(args[1]) ~= nil then
				vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]),true)
				SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.."\n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..parseInt(args[2]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("plate",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") and args[1] and args[2] and args[3] then
			vRP.execute("vRP/update_plate_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = args[3] })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") and args[1] and args[2] then
			vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"amarelo","Recebido o veículo <b>"..args[2].."</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"amarelo","Adicionado o veiculo <b>"..args[2].."</b> na garagem de ID <b>"..args[1].."</b>.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") and args[1] then
			TriggerClientEvent("hud:toggleHood",source,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.enablaNoclip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") then
			vRPclient.noClip(source)
--			TriggerClientEvent("noclipeffect",source) -- NOCLIP EFFECT
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") and parseInt(args[1]) > 0 then
			vRP.kick(parseInt(args[1]),"Você foi expulso da cidade.")
			SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.."\n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.kick(user_id,"Você foi banido da Cidade.")
				vRP.execute("vRP/set_banned",{ steam = tostring(identity.steam), banned = 1 })
				SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "ban.permissao") then
			vRP.execute("vRP/set_whitelist",{ steam = tostring(args[1]), whitelist = 1 })
			SendWebhookMessage(webhookadminwl,"```prolog\n[ID]: "..user_id.."\n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "wl.permissao") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.kick(user_id,"Você perdeu a sua Whitelist na Cidade.")
				vRP.execute("vRP/set_whitelist",{ steam = tostring(identity.steam), whitelist = 0 })
				SendWebhookMessage(webhookunwl,"```prolog\n[ID]: "..user_id.."\n[RETIROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIPCOINS
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("gems",function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if vRP.hasPermission(user_id, "nc.permissao") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
-- 			local identity = vRP.getUserIdentity(parseInt(args[1]))
-- 			if identity then
-- 				vRP.addGmsId(args[1],args[2])
-- 				TriggerClientEvent("Notify",source,"amarelo","Entregado <b>"..args[2].." Gemas</b> para ["..args[1].."]<b>"..identity.name.."</b>.",10000)
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "ban.permissao") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.execute("vRP/set_banned",{ steam = tostring(identity.steam), banned = 0 })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			local fcoords = vRP.prompt(source,"Cordenadas:","")
			if fcoords == "" then
				return
			end

			local coords = {}
			for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
				table.insert(coords,parseInt(coord))
			end
			vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.prompt(source,"Cordenadas:",x..","..y..","..z..","..h)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			if not vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
				vRP.insertPermission(parseInt(args[1]),tostring(args[2]))
				vRP.execute("vRP/add_group",{ user_id = parseInt(args[1]), permiss = tostring(args[2]) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			if vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
				vRP.removePermission(parseInt(args[1]),tostring(args[2]))
				vRP.execute("vRP/del_group",{ user_id = parseInt(args[1]), permiss = tostring(args[2]) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "staff.permissao") and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(nplayer,vRPclient.getPositions(source))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(source,vRPclient.getPositions(nplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) <= 101 then
			vCLIENT.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			-- local vehicle = vRPclient.getNearVehicle(source,7)
			--local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
			local vehicle = vRP.prompt(source,"Spawn:","")
			vCLIENT.syncHash(source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delnpcs",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") then
			vCLIENT.deleteNpcs(source)
			TriggerClientEvent("Notify",source,"amarelo","NPCs próximos deletados.",3000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			TriggerClientEvent("admin:vehicleTuning",source)
			TriggerClientEvent("Notify",source,"amarelo","Realizado melhorias no veículo.",3000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cone",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "nc.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then
		TriggerClientEvent("cone",source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("barreira",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "nc.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then
		TriggerClientEvent("barreira",source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "staff.permissao") then
			local vehicle,vehNet = vRPclient.vehList(source,11)
			if vehicle then
				TriggerClientEvent("inventory:repairVehicle",-1,vehNet,true)
				TriggerClientEvent("Notify",source,"amarelo","Veículo totalmente arrumado.",3000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleararea",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "nc.permissao") then
			local x,y,z = vRPclient.getPositions(source)
			TriggerClientEvent("syncarea",-1,x,y,z,100)
			TriggerClientEvent("Notify",source,"amarelo","Toda área próxima foi limpa.",3000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PON ONLINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("onlines",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "staff.permissao") then
		local users = vRP.getUsers()
		local players = ""
		local quantidade = 0
		for k,v in pairs(users) do
			if k ~= #users then
				players = players..", "
			end
			players = players..k
			quantidade = quantidade + 1
		end
		TriggerClientEvent("chatMessage",source,"Total onlines",{1, 136, 0},quantidade)
		TriggerClientEvent("chatMessage",source,"IDs onlines",{1, 136, 0},players)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "staff.permissao") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.updateTxt(user_id..".txt",x..","..y..","..z..","..h)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COORDENADAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") then
		local x,y,z = vRPclient.getPositions(source)
		vRP.prompt(source,"Cordenadas:",tD(x)..", "..tD(y)..", "..tD(z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") then
		local x,y,z = vRPclient.getPositions(source)
		vRP.prompt(source,"Cordenadas:","{name='ATM', id=277, x="..tD(x)..", y="..tD(y)..", z="..tD(z).."},")
	end
end)

RegisterCommand('cds4',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") then
		local x,y,z = vRPclient.getPositions(source)
		vRP.prompt(source,"Cordenadas:","x = "..tD(x)..", y = "..tD(y)..", z = "..tD(z))
	end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "staff.permissao") then
			local message = vRP.prompt(source,"Mensagem:","")
			if message == "" then
				return
			end
			TriggerClientEvent("Notify",-1,"roxo",message,60000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "dono.permissao") then
			local users = vRP.getUsers()
			for k,v in pairs(users) do
				vRP.giveInventoryItem(parseInt(k),tostring(args[1]),parseInt(args[2]),true)
			end
		end
	end
end)


RegisterCommand('vergrupos',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    --print("source: "..source)
    if vRP.hasPermission(user_id,"staff.permissao") then
        if args[1] then
            local other_id = vRP.getUserSource(parseInt(args[1]))
            local playerId = vRP.getUserId(other_id)
            
            --print("other_id: "..other_id)
            --print("playerId: "..playerId)
            if other_id  then
                local ppgrupo = {}
                p_grupos = vRP.getUserGroups(playerId)
                for x, y in pairs(p_grupos) do
                
                    table.insert(ppgrupo, x)
                    --print(tostring(x))
                    TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Grupos: "..tostring(x))
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('vroupas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local custom = vRPclient.getCustomization(source)
    --if vRP.hasPermission(user_id,"admin.permissao") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end

            player_customs[source] = true
            vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end)
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('vroupas2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local custom = vRPclient.getCustomization(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."\n" 
            end

            player_customs[source] = true
            vRP.prompt(source,"Roupas:",content)
        end
    end
end)