local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


kush = {}
Tunnel.bindInterface("kush_dnotify",kush)
vCLIENT = Tunnel.getInterface("kush_dnotify")

RegisterCommand('dnotify',function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
     if vRP.hasPermission(user_id,"dono.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"streamercerificado.permissao") then
        vCLIENT.tAdm(source)
    end
end)

function kushlogs(webhook,message)
	if webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATHLEGTH
-----------------------------------------------------------------------------------------------------------------------------------------
function mathLegth(n)
    n = math.ceil(n * 100) / 100
    return n
end


local webhookarcadius = 'https://discord.com/api/webhooks/1009399020919214081/WQTYNG3Qf1FQRMSSn1cT5Il7yx_fOL1IxYf1NVigwRkhJxvgPqOl086H8xZOpQ4Prktg'


function synterinho(corzinha, titulopika, logfull)
    local synter = {
      {
        ["color"] = corzinha,
        ["title"] = titulopika,
        ["description"] = logfull,
        ["footer"] = {
            ["text"] = marcadagua,
            ["icon_url"] = img,
        },
    }
  }
	PerformHttpRequest(webhookarcadius, function(err, text, headers) end, 'POST', json.encode({avatar_url = img, username = marcadagua, embeds = synter}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent('kush-common:killed')
AddEventHandler('kush-common:killed',function(killer,weapon)
    local source = source
    local user_id = vRP.getUserId(source)
    local killer_id = vRP.getUserId(killer)

    local identityK = vRP.getUserIdentity(killer_id)
    local identityV = vRP.getUserIdentity(user_id)

    local x, y, z = vRPclient.getPosition(source)
    TriggerEvent('john:ncdelay',user_id)
    if killer_id ~= nil then
        TriggerEvent('john:ncdelay',killer_id)
        synterinho(3553599,"🔫 LOG DE KILL", "> **__QUEM MATOU:__** \n```yaml\n"..killer_id.." " .. identityK.name .. " " .. identityK.name2 .. " ```\n> **__QUEM MORREU:__** \n```yaml\n"..user_id.." "..identityV.name.." "..identityV.name2.." ```\n> **__ARMA:__** \n```yaml\n "..weapon..'')
        local amountStaff = vRP.getUsersByPermission("dono.permissao")
        for k,v in pairs(amountStaff) do 
            local player = vRP.getUserSource(parseInt(v))
            TriggerClientEvent("kush:DeathNotify",player,weapon,killer_id.." "..identityK.name.." "..identityK.name2,user_id.." "..identityV.name.." "..identityV.name2.." ")
            TriggerEvent('pass:mission',killer,2)
            --TriggerClientEvent("kush:DeathNotify",player,weapon,identityK.name.." "..killer_id,identityK.name2,identityV.name.." "..identityV.name2)
        end
    else
        synterinho(3553599,"💀 LOG DE KILL", "> **__MORREU:__** \n```yaml\n"..user_id.." " .. identityV.name .. " " .. identityV.name2 .. "```\n> **__ARMA:__** \n```yaml\n "..weapon..'')
    end
end)