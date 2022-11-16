Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ PREPAREs ]----------------------------------------------------------------------------------------------------------------


--[ CONFIGURAÇÃO ]----------------------------------------------------------------------------------------------------------------

Config.hasPermission = vRP.hasPermission

Config.tryPayment = vRP.paymentBank

Config.getGroupTitle = vRP.getGroupTitle

Config.getIdentity = function (nuser_id)
    local identidade = vRP.getUserIdentity(nuser_id)

    return {
        nome = identidade.name,
        sobrenome = identidade.name2,
        idade = identidade.id,
        registro = identidade.registration
    }
end

Config.setMultas = function (source, nuser_id, multa)
    local user_id = vRP.getUserId(source)
    local uMultas = vRP.getUData(parseInt(nuser_id), 'vRP:multas')
    local multas = json.decode(uMultas) or 0
    vRP.setFines(user_id,multas,nuser_id,'teste')
end

Config.getMultas = function (nuser_id)
    local uMultar = vRP.getUData(parseInt(nuser_id), 'vRP:multas')
    return json.decode(uMultar) or 0
end

Config.setPrisao = function (nuser_id, pena)
    local uPrisao = vRP.getUData(parseInt(nuser_id), 'cc:Prisao')
    local prisao = json.decode(uPrisao) or -1
    vRP.setUData(parseInt(nuser_id), 'cc:Prisao', json.encode(parseInt(prisao) + parseInt(pena)))
end

Config.getPrisao = function (nuser_id)
    local uPrisao = vRP.getUData(parseInt(nuser_id), 'cc:Prisao')
    return json.decode(uPrisao) or -1
end

Config.initAnimacao = function (nsource)
    SetPlayerRoutingBucket(nsource, parseInt(nsource))
end

Config.initPrisao = function (source)
    TriggerClientEvent('cc_mdt:statusPrisao', source, true)
	prisonLoop(vRP.getUserId(source))
end

Config.endPrisao = function (source)
    TriggerClientEvent('cc_mdt:statusPrisao', source, false)
    vRP.removeCloak(source)
    vRPclient.teleport(source, 1850.5, 2604.0, 45.5)
end

Config.recompensaMulta = function (source, multaTotal)
    local random = math.random( 0.8 * multaTotal, multaTotal)
    vRP.giveMoney(vRP.getUserId(source) , parseInt(random))
    TriggerClientEvent("Notify", source, "importante", "Você recebeu <b>$"..random.." dólares</b> de bonificação.")
end

Config.recompensaFianca = function (source, fiancaTotal)
    vRP.giveMoney(vRP.getUserId(source) , parseInt(fiancaTotal))
end

--[[ WISE ]-----------------------------------------------------------------------------------------------------------------------
Para funcionar em bases com banco da loja Wise Resources. Você deve adicionar os Prepares no local indicado e alterar as funcoes 
"Config.getMultas" e "Config.setMultas". 
*Prestamos suporte quanto a adaptações para sua base, mas não para incompatibilidades de terceiros.

    vRP.prepare("cc_mdt/getMultasWise","SELECT SUM(valor) as total FROM wise_multas WHERE user_id = @user_id)")
    vRP.prepare("cc_mdt/multarWise","INSERT IGNORE INTO wise_multas(user_id,motivo,valor,descricao) VALUES(@user_id,@motivo,@multas,@descricao)")

    Config.getMultas = function (nuser_id)
        local getMulta = vRP.query("cc_mdt/getMultasWise",{ user_id = nuser })
        local multasbalance = json.encode(getMulta[1].total)
        return multasbalance:gsub('%"', '')
    end 

    Config.setMultas = function (nuser_id, multa)
        local identity = vRP.getUserIdentity(vRP.getUserId(source))
        vRP.execute("cc_mdt/multarWise",{ user_id = nuser, motivo = 'Multa aplicada por '..identity.nome.." "..identity.sobrenome, multas = multa, descricao = motivo}) 
    end

]]