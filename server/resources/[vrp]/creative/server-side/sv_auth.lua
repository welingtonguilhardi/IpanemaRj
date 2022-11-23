-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("creative")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/update_idade","UPDATE vrp_users SET age = @age WHERE id = @id")
cRP = {}
Tunnel.bindInterface("creative",cRP)


AddEventHandler("vRP:playerSpawn",function(user_id,source)
    
    local user_id = vRP.getUserId(source)
	local search =  vRP.getUserIdentity(user_id)
    local idade = search.age
    if tonumber(idade) == 0 or idade == nil then 
        vCLIENT.Open(source)
    end
end)


function cRP.UpIdade(age)

    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.execute("vRP/update_idade",{ id = parseInt(user_id), age = age})
        local search =  vRP.getUserIdentity(user_id)
        local idade = search.age
        if tonumber(idade) ~= 0 and idade ~= nil then
            vCLIENT.Open(source)
            TriggerClientEvent("Notify",source,"verde","Você atualizou sua idade com sucesso.",5000)
        end    
    end     

end




-- RegisterCommand("nui",function(source)
--     vCLIENT.Open(source)
-- end)