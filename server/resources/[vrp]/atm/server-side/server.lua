-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("atm",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local recompensa = 0
local andamento = false
local dinheirosujo = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookcaixaeletronico = "https://discord.com/api/webhooks/1027243037165899796/R7jPhZVAnJKAgFhbbA37R16PIVjpHRZX79vF9NXarOSzM9QHuznEjR2elcQbZ-yaFBJb"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local caixas = {
	[1] = { ['seconds'] = 25 },
	[2] = { ['seconds'] = 39 },
	[3] = { ['seconds'] = 39 },
	[4] = { ['seconds'] = 35 },
	[5] = { ['seconds'] = 33 },
	[6] = { ['seconds'] = 33 },
	[7] = { ['seconds'] = 55 },
	[8] = { ['seconds'] = 39 },
	[9] = { ['seconds'] = 35 },
	[10] = { ['seconds'] = 60 },
	[11] = { ['seconds'] = 43 },
	[12] = { ['seconds'] = 27 },
	[13] = { ['seconds'] = 45 },
	[14] = { ['seconds'] = 50 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkRobbery(x,y,z) --id,x,y,z,head
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if #policia <= -1 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		elseif (os.time()-timers) <= 1800 then
			TriggerClientEvent("Notify",source,"aviso","Os caixas estão vazios, aguarde <b>"..vRP.format(parseInt((1800-(os.time()-timers)))).." segundos</b> até que os civis depositem dinheiro.",8000)
			return false
		else
			andamento = true
			timers = os.time()
			dinheirosujo = {}
			for l,w in pairs(policia) do
				player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('blip:criar:caixaeletronico',player,x,y,z)
						vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
						TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou no ^1Caixa Eletrônico^0, dirija-se até o local e intercepte os assaltantes.")
					end)
				end
			end
			SendWebhookMessage(webhookcaixaeletronico,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
				end)
			end
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.cancelRobbery()
	if andamento then
		andamento = false
		local policia = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			for k,v in pairs(dinheirosujo) do
				if v > 0 then
					dinheirosujo[k] = v - 1
					vRP._giveInventoryItem(k,"dollars2",recompensa)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"paisanapolicia.permissao") or vRP.hasPermission(user_id,"paisanaparamedico.permissao"))
end

function cnVRP.giveItens()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		random = math.random(250,350)
		vRP.giveInventoryItem(user_id,"dollars2",parseInt(random))
		TriggerClientEvent("itensNotify",source,{"+","dollars",random.."","Dinheiro sujo."})
		-- TriggerClientEvent("itensNotify",nSource,{ "+","dollars",vRP.format(valor),"Dólares" })
		
	end
end

function cnVRP.getItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"c4",1) then
			return true
		else
			return false
		end
	end
end

function cnVRP.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"c4") >= 1 then
			return true
		else
			return false
		end
	end
end

-- RegisterCommand("teste",function(source,args,rawCommand)
-- 	source = source
-- 	vCLIENT.inicio_cancelar(source)
-- end)




















-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local atmTimers = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(atmTimers) do
			if v[1] > 0 then
				v[1] = v[1] - 10
				if v[1] <= 0 then
					atmTimers[k] = nil
				end
			end
		end
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSALDO
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getSaldo()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getBank(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SACARVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.sacarValor(valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(valor) > 5000 then
			TriggerClientEvent("Notify",source,"amarelo","Limite de saque máximo atingido.",5000)
			return vRP.getBank(user_id)
		end

		if parseInt(valor) > 0 then
			if atmTimers[user_id] then
				if atmTimers[user_id][1] > 0 and atmTimers[user_id][2] >= 5000 then
					TriggerClientEvent("Notify",source,"azul","Aguarde "..vRP.getTimers(parseInt(atmTimers[user_id][1])).."</b>.",5000)
					return vRP.getBank(user_id)
				end

				if (atmTimers[user_id][2] + parseInt(valor)) <= 5000 then
					if vRP.withdrawCash(user_id,parseInt(valor)) then
						atmTimers[user_id][2] = atmTimers[user_id][2] +  parseInt(valor)
					else
						TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Você atingiu o limite de retiradas.",5000)
				end
			else
				if vRP.withdrawCash(user_id,parseInt(valor)) then
					atmTimers[user_id] = { 600,parseInt(valor) }
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			end
		end

		return vRP.getBank(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERIRVALOR
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.transferirValor(valor,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,valor) then
			vRP.addBank(target,valor)

			local nSource = vRP.getUserSource(target)
			if nSource then
				TriggerClientEvent("itensNotify",nSource,{ "+","dollars",vRP.format(valor),"Dólares" })
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na sua conta bancária.",5000)
		end

		return vRP.getBank(user_id)
	end
end