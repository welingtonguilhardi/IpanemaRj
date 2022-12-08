-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vPLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("dynamic",cRP)
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
local policeService = false
local paramedicService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAL
-----------------------------------------------------------------------------------------------------------------------------------------
local animalHahs = nil
local animalFollow = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("paramedic:updateService")
AddEventHandler("paramedic:updateService",function(status)
	paramedicService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SetNuiFocus(true,true)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,menuid)
	SetNuiFocus(true,true)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = menuid })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(data,cb)
	if data["server"] == "true" then
		TriggerServerEvent(data["trigger"],data["param"])
	else
		TriggerEvent(data["trigger"],data["param"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data,cb)
	SetNuiFocus(false,false)
	menuOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	if menuOpen then
		SendNUIMessage({ close = true })
		SetNuiFocus(false,false)
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function(source,args)
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			menuOpen = true
			exports["dynamic"]:AddButton("Salvar","Salvar a roupa atual.","player:premiumfit","salvar","outfit",true)
			exports["dynamic"]:AddButton("Aplicar","Aplicar a roupa salva.","player:premiumfit","","outfit",true)
			exports["dynamic"]:AddButton("Remover","Remover a roupa atual.","player:outfitFunctions","remover","outfit",true)

			exports["dynamic"]:AddButton("Informações","Todas as informações de sua identidade.","player:identityFunctions","","others",true)
			exports["dynamic"]:AddButton("Desbugar","Desbugar o personagem.","skinshop:debugar","","others",true)

			if not IsPedInAnyVehicle(ped) then
				exports["dynamic"]:AddButton("Rebocar","Colocar veículo na prancha do reboque.","towdriver:syncTow","tow","others",true)

				exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","otherPlayers",true)
				exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","otherPlayers",true)
				exports["dynamic"]:AddButton("Checar Porta-Malas","Vericar pessoa dentro do mesmo.","splayer:CheckTrunk","","otherPlayers",true)

				exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","otherPlayers")
			else
				exports["dynamic"]:AddButton("Banco Dianteiro Esquerdo","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
				exports["dynamic"]:AddButton("Banco Dianteiro Direito","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Esquerdo","Sentar no banco do passageiro.","player:seatPlayer","2","vehicle",false)
				exports["dynamic"]:AddButton("Banco Traseiro Direito","Sentar no banco do passageiro.","player:seatPlayer","3","vehicle",false)
				exports["dynamic"]:AddButton("Levantar Vidros","Levantar todos os vidros.","player:winsFunctions","1","vehicle",true)
				exports["dynamic"]:AddButton("Abaixar Vidros","Abaixar todos os vidros.","player:winsFunctions","0","vehicle",true)

				exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")
			end

			exports["dynamic"]:AddButton("Propriedades","Ativa/Desativa as propriedades no mapa.","homes:togglePropertys","","propertys",false)
			exports["dynamic"]:AddButton("Verificar","Consultar casas em seu nome.","homes:lista","","propertys",true)
			exports["dynamic"]:AddButton("Consultar","Consultar permissões da sua casa.","homes:checkar","","propertys",true)
			exports["dynamic"]:AddButton("Entrar/Comprar","Entra ou compra casa proxima.","homes:entrar","","propertys",false)
			exports["dynamic"]:AddButton("Visitar","Visitar casa proxima.","homes:visitar","","propertys",false)
			exports["dynamic"]:AddButton("Vender","Vender casas.","homes:vender","","propertys",true)
			exports["dynamic"]:AddButton("Trancar/Destrancar","Tranca ou Destranca casa proxima.","homes:porta","","propertys",false)
			exports["dynamic"]:AddButton("Add Morador","Adicionar morador.","homes:morador","","propertys",true)
			exports["dynamic"]:AddButton("Transferir","Tranferir casa para outro player.","homes:transfer","","propertys",true)
			exports["dynamic"]:AddButton("Bau","Comprar mais kg pro bau.","homes:vault","","propertys",true)
			exports["dynamic"]:AddButton("Dell morador","Deletar permissão de algum morador.","homes:dellmorador","","propertys",true)

			exports["dynamic"]:SubMenu("Roupas","Mudança de roupas rápidas.","outfit")
			
			exports["dynamic"]:SubMenu("Propriedades","Todas as funções das propriedades.","propertys")

			exports["dynamic"]:SubMenu("Outros","Todas as funções do personagem.","others")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions",function(source,args)
	if vPLAYER.checkMed() or vPLAYER.checkPolicia() then
		if not exports["player"]:blockCommands() and not exports["player"]:handCuff() and not menuOpen then
			print("chamado bind")

			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				menuOpen = true

				exports["dynamic"]:AddButton("Serviço","Verificar companheiros em serviço.","player:servicoFunctions","","utilitys",true)

				if not IsPedInAnyVehicle(ped) then
					exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","player",true)
					exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","player",true)

					exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","player")
				end

				if vPLAYER.checkPolicia() then
					exports["dynamic"]:AddButton("Invadir","Invadir a residência.","homes:invadeSystem","","utilitys",true)

					exports["dynamic"]:AddButton("Remover Chapéu","Remover da pessoa mais próxima.","skinshop:removeProps","Hat","player",true)
					exports["dynamic"]:AddButton("Remover Máscara","Remover da pessoa mais próxima.","skinshop:removeProps","Mask","player",true)
					exports["dynamic"]:AddButton("Defusar","Desativar bomba do veículo.","races:defuseBomb","","player",true)

					exports["dynamic"]:AddButton("RP Praça","Fardamento de oficial.","player:presetFunctions","1","prePolice",true)
					exports["dynamic"]:AddButton("RP Oficial","Fardamento de oficial.","player:presetFunctions","2","prePolice",true)
					exports["dynamic"]:AddButton("Bope","Fardamento de oficial.","player:presetFunctions","3","prePolice",true)
					exports["dynamic"]:AddButton("GAM","Fardamento Grupamento Aeromóvel.","player:presetFunctions","4","prePolice",true)
					exports["dynamic"]:AddButton("GTM","Fardamento GTM.","player:presetFunctions","5","prePolice",true)


					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos policiais.","prePolice")
					exports["dynamic"]:SubMenu("Utilidades","Todas as funções dos policiais.","utilitys")
				elseif vPLAYER.checkMed() then
					exports["dynamic"]:AddButton("Paramedico/Enfermeiro","Fardamento de Enfermeiro/Paramedico.","player:presetFunctions","9","preMedic",true)
					exports["dynamic"]:AddButton("Medico","Fardamento de Medico.","player:presetFunctions","10","preMedic",true)

					

					exports["dynamic"]:SubMenu("Fardamentos","Todos os fardamentos médicos.","preMedic")
					exports["dynamic"]:SubMenu("Utilidades","Todas as funções dos paramédicos.","utilitys")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emergência.","keyboard","INSERT")