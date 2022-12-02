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
    local check = data.checkbox
    local idade = tonumber(data.idade)
    local successAge = false 
    local successCheck = false
    if idade > 17 then
       successAge = true
    else
        TriggerEvent("Notify","amarelo","Seu personagem deve ter mais de 17 anos.",8000)
    end    
    if check ~= nil then
        successCheck = true
    else
        TriggerEvent("Notify","amarelo","Marque alguma opção.",8000)
    end   

    if successAge and successCheck then --verifica se algum campo foi marcado e a idade e maior de 17
        SetNuiFocus(false,false)
        SendNUIMessage({
            idade = false
        })
        vSERVER.UpIdade(idade)
    end    
end)