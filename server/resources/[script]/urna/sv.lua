-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("urna")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("urna",cRP)
vRP.prepare("vRP/verificar_candidato","SELECT * FROM candidato WHERE user_id = @user_id")
vRP.prepare("vRP/create_candidato","INSERT INTO candidato (user_id,nome) VALUES(@user_id,@nome)")


vRP.prepare("vRP/get_votos","SELECT * FROM urnas WHERE candidato = @candidato")
vRP.prepare("vRP/verificar_votos","SELECT * FROM urnas WHERE user_id = @user_id")
vRP.prepare("vRP/create_votos","INSERT INTO urnas (candidato,user_id,name,name2) VALUES(@candidato,@user_id,@name,@name2)")

local count1 = 0 -- varivel de contagem de votos do candidato1
local count2 = 0 -- varivel de contagem de votos do candidato2
function cRP.ResultVotos()
    local source = source
    local user_id = vRP.getUserId(source)
    local GetVotos1 = vRP.query("vRP/get_votos",{ candidato = Config.NumberCandidato1 })
    local GetVotos2 = vRP.query("vRP/get_votos",{ candidato = Config.NumberCandidato2 })
    if #GetVotos1 > 0 or #GetVotos2 > 0 then
        for k,v in pairs(GetVotos1) do--contagem de votos candidato1
            if GetVotos1[k].candidato then
                count1 = count1 + 1 
            end    
        end

        for k,v in pairs(GetVotos2) do--contagem de votos candidato2
            if GetVotos2[k].candidato then
                count2 = count2 + 1 
            end    
        end
        TriggerClientEvent("Notify",source,"amarelo",Config.NameCandidato1..": "..count1.." votos\n"..Config.NameCandidato2..": "..count2.." votos",5000)
        vCLIENT.CloseUrna(source) -- fecha a nui
        count1 = 0
        count2 = 0
    else
        TriggerClientEvent("Notify",source,"vermelho","Nenhum voto computado.",5000)   
        vCLIENT.CloseUrna(source) -- fecha a nui 
    end
end    

function cRP.CreateVoto(data)-- data = NUMERO DO CANDIDATO

    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(source)
    local verificar_votos = vRP.query("vRP/verificar_votos",{ user_id = user_id})
    local success = true
    for k,v in pairs(verificar_votos) do
        if k == user_id then success = false end -- verifica se o player já votou
    end
    if success then -- variavel de verificação
        if tonumber(data) == Config.NumberCandidato2 or tonumber(data) == Config.NumberCandidato1 then
            TriggerClientEvent("sounds:source",user_id,"urna",0.5) -- som de confirmação de urna
            vRP.execute("vRP/create_votos",{ candidato = data, user_id = user_id,name = identity.name, name2 = identity.name2 }) -- cria o voto
            TriggerClientEvent("Notify",source,"verde","Você votou com sucesso.",5000)
            vCLIENT.CloseUrna(source) -- fecha a nui
        else
            TriggerClientEvent("Notify",source,"vermelho","Candidato invalido.",5000)
        end    
    else
        TriggerClientEvent("Notify",source,"amarelo","Você Já votou.",5000)
        vCLIENT.CloseUrna(source) -- fecha a nui
        
    end    
end   


RegisterCommand("CreateCandidato",function(source,args,rawCommand)
        
    source = source
    id = vRP.getUserId(source)
    local verificar_candidato = vRP.query("vRP/verificar_candidato",{ user_id = args[1]})
    local success = true
    for k,v in pairs(verificar_candidato) do
        if v["user_id"] > 0 then success = false end -- verifica a quantidade da coluna user_id para cada candidato 
    end
    if vRP.hasPermission(id, "dono.permissao") then

        if success then
            if args[1] and args[2] then
                vRP.execute("vRP/create_candidato",{user_id =parseInt(args[1]) ,nome = args[2] }) -- cria um candidato
                TriggerClientEvent("Notify",source,"verde","Você registrou  o id: "..args[1].." com sucesso.",5000)
            else
                TriggerClientEvent("Notify",source,"vermelho","Formato errado.",5000)
            end
        else
            TriggerClientEvent("Notify",source,"vermelho","Candidato já existe.",5000)    
        end    
    else
        TriggerClientEvent("Notify",source,"vermelho","Não autorizado.",5000)  
    end        
end) 