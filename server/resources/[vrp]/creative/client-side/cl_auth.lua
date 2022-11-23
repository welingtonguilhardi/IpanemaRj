-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("creative",cRP)
vSERVER = Tunnel.getInterface("creative")
local onNui = false
function cRP.Open()
    onNui = not onNui
    if onNui then
        SetNuiFocus(true, true)
        SendNUIMessage({
            idade = true
        })
    else
        SetNuiFocus(false,false)
        SendNUIMessage({
            idade = false
        })
    end
end    
RegisterNUICallback("botao", function(data)
    local idade = tonumber(data.idade)
    if idade > 17 then
        vSERVER.UpIdade(idade)
    else
        TriggerEvent("Notify","amarelo","Seu personagem deve ter mais de 17 anos.",8000)
    end    
end)