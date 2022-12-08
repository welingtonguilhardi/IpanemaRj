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
Tunnel.bindInterface("vrp_skinshop",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateClothes(clothes,demand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		-- if demand then
		-- 	local valor = math.random(100,350)
		-- 	if vRP.paymentBank(user_id,valor) then
		-- 		TriggerClientEvent("Notify",source,"sucesso","Voce pagou $"..valor.." em roupas.",5000)
		-- 	else
		-- 		TriggerClientEvent("Notify",source,"negado","Voce nao tem dinheiro.",5000)
		-- 	end
		-- end
		vRP.setUData(user_id,"Clothings",clothes)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"dono.permissao") and args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.applySkin(nplayer,GetHashKey(args[2]))
				vRP.updateSelectSkin(parseInt(args[1]),GetHashKey(args[2]))
				TriggerClientEvent("Notify",nplayer,"amarelo","Setada a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.",5000)
				TriggerClientEvent("Notify",source,"amarelo","Setada a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.",5000)
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:debugar")
AddEventHandler("skinshop:debugar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local model = vRPclient.getModelPlayer(source)--busca o modelo do personagem que fez a solicitação.
		local data = vRP.getUserDataTable(user_id)
		if data then
			vRPclient.applySkin(source,GetHashKey(model))--seta uma skin no personagem, resetando todas sua caracteristicas e roupas
			local charmode = vRP.getUData(user_id, "currentCharacterMode")--Busca no banco de dados as caracteristicas do personagem 
			local custsom = json.decode(charmode) or {}  
			if charmode then
				TriggerClientEvent("barbershop:setCustomization", source, custsom)--atualiza caracteristicas do player
			end	
			local custom = vCLIENT.getCustomization(source) --Função para buscar roupas no banco de dados
			TriggerClientEvent("updateRoupas",source,custom)
		end	
	end
end)



-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- MASCARA
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("mascara",function(source,args)
-- 	local user_id = vRP.getUserId(source)
-- 	local action = args[1]
-- 	if user_id then
-- 		if action then
-- 			if action == "true" or action == "1" then
-- 				local item,texture = vCLIENT.getMask(source)
-- 				TriggerClientEvent("vrp_skinshop:setMask",source,{ item,texture })
-- 			elseif action == "false" or action == "0" then
-- 				TriggerClientEvent("vrp_skinshop:setMask",source)
-- 			end
-- 		else
-- 			TriggerClientEvent("vrp_skinshop:setMask",source)
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chapeu",function(source,args)
	local user_id = vRP.getUserId(source)
	local action = args[1]
	if user_id then
		if action then
			if action == "true" or action == "1" then
				local item,texture = vCLIENT.getHat(source)
				TriggerClientEvent("vrp_skinshop:setHat",source,{ item,texture })
			elseif action == "false" or action == "0" then
				TriggerClientEvent("vrp_skinshop:setHat",source)
			end
		else
			TriggerClientEvent("vrp_skinshop:setHat",source)
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- OCULOS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("oculos",function(source,args)
-- 	local user_id = vRP.getUserId(source)
-- 	local action = args[1]
-- 	if user_id then
-- 		if action then
-- 			if action == "true" or action == "1" then
-- 				local item,texture = vCLIENT.getGlasses(source)
-- 				TriggerClientEvent("vrp_skinshop:setGlasses",source,{ item,texture })
-- 			elseif action == "false" or action == "0" then
-- 				TriggerClientEvent("vrp_skinshop:setGlasses",source)
-- 			end
-- 		else
-- 			TriggerClientEvent("vrp_skinshop:setGlasses",source)
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:REMOVEPROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("skinshop:removeProps")
AddEventHandler("skinshop:removeProps",function(mode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local otherPlayer = vRPclient.nearestPlayer(source,2)
		if otherPlayer then
			if vRP.getUsersByPermission("policia.permissao") then
				TriggerClientEvent("vrp_skinshop:set"..mode,otherPlayer)
			end
		end
	end
end)