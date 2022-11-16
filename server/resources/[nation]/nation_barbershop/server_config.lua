local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_barbershop")
func = {}
Tunnel.bindInterface("nation_barbershop", func)


function func.checkPermission(permission, src)
    local source = src or source
    local user_id = vRP.getUserId(source)
    if type(permission) == "table" then
        for i, perm in pairs(permission) do
            if vRP.hasPermission(user_id, perm) then
                return true
            end
        end
        return false
    end
    return vRP.hasPermission(user_id, permission)
end


function func.saveChar(char)
    local source = source
    local user_id = vRP.getUserId(source)
    vRP._setUData(user_id, "currentCharacterMode", json.encode(char,{indent=false}))
    return true
end


function func.tryPay(value)
    local source = source
    local user_id = vRP.getUserId(source)
    if value >= 0 then
        if vRP.tryPayment(user_id, value) or vRP.paymentBank(user_id, value) or value == 0 then
            return true
        end
    end
    return false
end



local chairsUsers = {}
function func.checkChair(barberId, chairIndex, perm)
    local source = source
    if perm and not func.hasPermission(perm, source) then return end
    for src, v in pairs(chairsUsers) do
        if v.barberId == barberId and v.chairIndex == chairIndex then
            return false
        end
    end
    chairsUsers[source] = { barberId = barberId, chairIndex = chairIndex  }
    return true
end

function func.leaveChar(_source)
    local source = _source or source
    if chairsUsers[source] then
        chairsUsers[source] = nil
    end
end


AddEventHandler('playerDropped', function()
    func.leaveChar(source)
end)


function func.getOverlay()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUData(user_id, "currentCharacterMode")
        if data and data ~= "" then
            local char = json.decode(data)
            if char and char.overlay then
                return char.overlay
            end
        end
    end
    return 0
end

function getUserClothes(user_id)
    local data = vRP.getUData(user_id, "Clothings")
    if data and data ~= "" then
        local clothes = json.decode(data)
        if clothes then
            return clothes
        end
    end
    local datatable = vRP.getUserDataTable(user_id) or {}
    return datatable.customization or {}
end

--fix pigmentação
function setPlayerTattoos(source, user_id)
    local data = vRP.getUData(user_id,"currentCharacterMode")
    if data and data ~= "" then 
        tattoos = json.decode(data) or {}
        TriggerClientEvent("tattoos:setTattoos", source, tattoos)
    end
    TriggerClientEvent("reloadtattos", source)
    TriggerEvent('dpn_tattoo:setPedServer',source)
    TriggerClientEvent("nyoModule:tattooUpdate",source, false)
end

function func.setPlayerTattoos()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        setPlayerTattoos(source, user_id)
    end
end
--fix pigmentação e cabelo verde
AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local user_id = vRP.getUserId(source)
    local consult = vRP.getUData(user_id, "currentCharacterMode")
    if consult and consult ~= "" then
        local char = json.decode(consult)
        --fclient._setPlayerChar(source, char, false, true)   
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
        Wait(2000)
        TriggerClientEvent("nation_barbershop:reloadOverlay", source)
        --fclient._setClothing(source, getUserClothes(user_id))

	end	

end)


--comnado debugar cabelo
RegisterCommand("bcabelo", function(source)
    if not use then
        local user_id = vRP.getUserId(source)
        local data = vRP.getUData(user_id, "currentCharacterMode")
        if data and data ~= "" then
            local char = json.decode(data)
            --fclient._setPlayerChar(source, char, false, true)
            TriggerClientEvent("nation_barbershop:init", source, char)
            --Wait(200)
            --TriggerClientEvent("nation_barbershop:reloadOverlay", source)
            setPlayerTattoos(source, user_id)
            --fclient._setClothing(source, getUserClothes(user_id))
            use = true
            SetTimeout(2000000,function()--33 minutos
                use = false
                TriggerClientEvent("Notify",source,"aviso","Você já pode usar o comando /bcabelo.",5000)
            end)
        end
    else
        TriggerClientEvent("Notify",source,"aviso","Aguarde para usar esse comando.",5000)
    end    
end)

-- tattoos dope nuis

AddEventHandler("dpn_tattoo:setPedServer", function(source)
    Wait(200)
    TriggerClientEvent("nation_barbershop:reloadOverlay", source)
end) 
