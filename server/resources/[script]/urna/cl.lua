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
Tunnel.bindInterface("urna",cRP)
vSERVER = Tunnel.getInterface("urna")


local onNui = false

RegisterCommand("nui", function()
    
    onNui = not onNui
    if onNui then

        SetNuiFocus(true, true)
        SendNUIMessage({
            teste = true,
            candidato1 = Config.NameCandidato1, -- envia pro javascript nome do candidato1
            candidato2 = Config.NameCandidato2,-- envia pro javascript nome do candidato2
            NumberCandidato1 = Config.NumberCandidato1,-- envia pro javascript numero do candidato1
            NumberCandidato2 = Config.NumberCandidato2-- envia pro javascript numero do candidato2
        })
    else
        SetNuiFocus(false,false)
        SendNUIMessage({
            teste = false
        })
    end
end)
function cRP.CloseUrna() -- função responsavel em fechar a nui 
    onNui = not onNui
    SetNuiFocus(false,false)
    SendNUIMessage({
        teste = false
    })

end


-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(data) -- fechar no ESC
    onNui = not onNui
    SetNuiFocus(false,false)
    SendNUIMessage({
        teste = false
    })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Butão
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("botao", function(data) --confirmar voto 
    --print("Ok, recebi o candidato", data.teste)
    vSERVER.CreateVoto(data.teste)

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Apuração
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("apuracao", function(data) --botão de apuração 
    --print("Ok, recebi o candidato", data.teste)
    vSERVER.ResultVotos(source)

end)