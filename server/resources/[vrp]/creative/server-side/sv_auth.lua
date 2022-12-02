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



-----------------------------------------------------------------------------------------------------------------------------------------
-- Verificar idade
-----------------------------------------------------------------------------------------------------------------------------------------

-- AddEventHandler("vRP:playerSpawn",function(user_id,source)
    
--     local user_id = vRP.getUserId(source)
-- 	local search =  vRP.getUserIdentity(user_id)
--     local idade = search.age
--     if tonumber(idade) == 0 or idade == nil then 
--         vRP.kick(parseInt(user_id),"Você foi expulso da cidade pois sua identidade está atrasada,Entre em contato com nossa staff.")
--     end
-- end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP INICIAL + idade
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/vip_inicial","SELECT iniciante FROM vrp_users WHERE id = @id")
vRP.prepare("vRP/veiculoinicial","INSERT IGNORE INTO vrp_vehicles(user_id,vehicle,plate,phone,premiumtime,predays,work) VALUES(@user_id,@vehicle,@plate,@phone,@premiumtime,@predays,@work)")
vRP.prepare("vRP/setIdVip","UPDATE vrp_users SET iniciante = @iniciante WHERE id = @id")

function cRP.verificar()
    local source = source
	local user_id = vRP.getUserId(source)
	local rows = vRP.query("vRP/vip_inicial",{ id = user_id })
	if rows[1].iniciante == 1 then
        vCLIENT.Open(source)
    else
        local search =  vRP.getUserIdentity(user_id)
        local idade = search.age
        if tonumber(idade) == 0 or idade == nil then 
            vRP.kick(parseInt(user_id),"Você foi expulso da cidade pois sua identidade está atrasada,Entre em contato com nossa staff.")
        end  
	end	

end



function cRP.UpIdade(age)

    local source = source
    local user_id = vRP.getUserId(source)
    local veiculo = nil
    local var = math.random(1,2)
    if var == 1 then veiculo = 'uno' end
	if var == 2 then veiculo = 'akuma' end
    if user_id then
            vRP.execute("vRP/update_idade",{ id = parseInt(user_id), age = age})
            vRP.execute("vRP/setIdVip",{ iniciante = 0, id = user_id})
            vRP.execute("vRP/veiculoinicial",{ user_id = parseInt(user_id), vehicle = veiculo, plate = vRP.generatePlateNumber(), phone = vRP.getPhone(user_id), premiumtime = premiumtime,predays = 7,work = tostring(false) })
            vRP.giveInventoryItem(user_id,"backpack",1,true)
            vRP.giveInventoryItem(user_id,"cellphone",1,true)
            vRP.giveInventoryItem(user_id,"cellbattery",1,true)
            vRP.giveInventoryItem(user_id,"radio",1,true)
            vRP.giveInventoryItem(user_id,"roupas",1,true)
            vRP.giveInventoryItem(user_id,"toolbox",1,true)
            vRP.giveInventoryItem(user_id,"water",5,true)
            vRP.giveInventoryItem(user_id,"chocolate",1,true)
            vRP.giveInventoryItem(user_id,"lockpick",1,true)	
            vCLIENT.Open(source)
            TriggerClientEvent("Notify",source,"verde","Você atualizou sua idade com sucesso.",5000)
            TriggerClientEvent("Notify",source,"verde","Você ganhou um "..veiculo.." com sucesso.",5000)
    end

end




-- RegisterCommand("nui",function(source)
--      vCLIENT.Open(source)
-- end)