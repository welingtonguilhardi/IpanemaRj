-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("player",cRP)
vCLIENT = Tunnel.getInterface("player")
vTASKBAR = Tunnel.getInterface("taskbar")
vSKINSHOP = Tunnel.getInterface("vrp_skinshop")

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


webhookquit = 'https://discord.com/api/webhooks/1009461247424593991/8NrwJwasJhmFuRKjdKOY-4VWct_P-Y_mf6EAAjKMLMAh2GbMoELCVsA1e6533LW7732R'
AddEventHandler('playerDropped', function(Reason)
	local source = source
	local user_id = vRP.getUserId(source)
	local crds = GetEntityCoords(GetPlayerPed(source))
	if user_id then
		SendWebhookMessage(webhookquit,"```prolog\n[ID]: "..user_id.."\n[cds]:"..crds.."\n[motivo]:"..Reason..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Teste
-----------------------------------------------------------------------------------------------------------------------------------------



RegisterCommand("polvora",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local polvora = vRP.fireReturn(user_id)
	vRPclient._playAnim(source,true,{"anim@amb@clubhouse@bar@drink@idle_a","idle_a_bartender"},true)
	if polvora == 0 then
		TriggerClientEvent("Notify",source,"amarelo","Você não possui <b>polvora</b> nas mãos.",5000)
	else
		TriggerClientEvent("Notify",source,"amarelo","Você possui <b>polvora</b> nas mãos.",5000)
	end
	Wait(5000)
	vRPclient._stopAnim(source,false)		
end)
















-----------------------------------------------------------------------------------------------------------------------------------------
-- updatestress carro
-----------------------------------------------------------------------------------------------------------------------------------------


function cRP.updateStress()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.upgradeStress(user_id,0.0125)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK POLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPolicia()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "policia.permissao") then
		return true
	end	
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK SAMU
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkMed()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "paramedico.permissao") then
		return true
	end	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK SAMU
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkMec()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "mecanico.permissao") then
		return true
	end	
end







-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1  then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas Secundárias</b> na mochila.") 
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/pegarveiculo","SELECT * FROM vrp_vehicles WHERE user_id = @user_id and vehicle = @vehicle")
RegisterCommand("carpremium",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local rows2 = vRP.query("vRP/get_vehicle",{ user_id = user_id })
    if #rows2 then 
		for k,v in pairs(rows2) do
			if v.vehicle == args[1] then
				--print(v.premiumtime+24*v.predays*60*60)

				if os.time() >= (v.premiumtime+24*v.predays*60*60) then
					--print(v.premiumtime+24*v.predays*60*60-os.time())
					TriggerClientEvent("Notify",source,"importante","ESSE VEICULO NÃO É VIP OU ESTÁ VENCIDO",5000)
					--TriggerClientEvent("Notify",source,"importante","Você ainda tem "..vRP.getTimers(parseInt(86400*v.predays-(os.time()-v.premiumtime))).." de aluguel no veiculo: "..v.vehicle.."",5000)
					
				else
					TriggerClientEvent("Notify",source,"importante","Você ainda tem "..vRP.getTimers(parseInt(86400*v.predays-(os.time()-v.premiumtime))).." de aluguel no veiculo: "..v.vehicle.."",5000)
				end

			

			end
		end		
	end	
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] then
			TriggerClientEvent("player:showMe",-1,source,rawCommand)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHMENU:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehmenu:doors")
AddEventHandler("vehmenu:doors",function(doors)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
            local vehicle,vehNet = vRPclient.vehList(source,7)
            if vehicle then
                TriggerClientEvent("player:syncDoors",-1,vehNet,doors)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(winsFunctions)
 	local user_id = vRP.getUserId(source)
 	if user_id then
 		if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
 			local vehicle,vehNet = vRPclient.vehList(source,7)
 			if vehicle then
 				TriggerClientEvent("player:syncWins",-1,vehNet,winsFunctions)
 			end
 		end
 	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFITFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions",function(outfitFunctions)
	local user_id = vRP.getUserId(source)
	if user_id then
	    if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
			vCLIENT.setRemoveoutfit(source)
	    end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:IDENTITYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:identityFunctions")
AddEventHandler("player:identityFunctions",function(identityFunctions)
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
		local infos = vRP.query("vRP/get_vrp_infos",{ steam = identity.steam })		
			TriggerClientEvent("Notify",source,"default","<b>Passaporte:</b> "..vRP.format(parseInt(identity.id)).."<br><b>RG:</b> "..identity.registration.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>Idade:</b> "..identity.age.."<br><b>Máximo de Veículos:</b> "..identity.garage.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Premium:</b> "..infos[1].predays.." Dias",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WECOLOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wecolor",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[1]) >= 0 and parseInt(args[1]) <= 7 then
			if vRP.getPremium(user_id) then
				vCLIENT.weColors(source,parseInt(args[1]))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("welux",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getPremium(user_id) then
			vCLIENT.weLux(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vCLIENT.getHandcuff(source) then
			if args[2] == "friend" then
				local identity = vRP.getUserIdentity(user_id)
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					if vRPclient.getHealth(nplayer) > 101 and not vCLIENT.getHandcuff(nplayer) then
						local request = vRP.request(nplayer,"Você aceita o pedido de <b>"..identity.name.." da animação <b>"..args[1].."</b>?",30)
						if request then
							TriggerClientEvent("emotes",nplayer,args[1])
							TriggerClientEvent("emotes",source,args[1])
						end
					end
				end
			else
				TriggerClientEvent("emotes",source,args[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					TriggerClientEvent("emotes",nplayer,args[1])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("premium",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			local consult = vRP.getInfos(identity.steam)
			if consult[1] and parseInt(os.time()) <= parseInt(consult[1].premium+24*consult[1].predays*60*60) then
				TriggerClientEvent("Notify",source,"importante","Você ainda tem "..vRP.getTimers(parseInt(86400*consult[1].predays-(os.time()-consult[1].premium))).." de benefícios <b>Premium</b>.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 then
			local vehicle,vehNet = vRPclient.vehList(source,7)
			if vehicle then
				TriggerClientEvent("player:syncHood",-1,vehNet)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:salary")
AddEventHandler("player:salary",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getPremium(parseInt(user_id)) then
			vRP.setSalary(parseInt(user_id),875)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$875 dólares</b> de benefício.",5000)
		end

		if vRP.hasPermission(parseInt(user_id),"policia.permissao") then
			vRP.setSalary(parseInt(user_id),1655)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$1655 dólares</b> de salário.",5000)
		end

		if vRP.hasPermission(parseInt(user_id),"mecanico.permissao") then
			vRP.setSalary(parseInt(user_id),1125)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$1125 dólares</b> de salário.",5000)
		end

		if vRP.hasPermission(parseInt(user_id),"paramedico.permissao") then
			vRP.setSalary(parseInt(user_id),1845)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$1845 dólares</b> de salário.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETECHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deleteChar()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("vRP/remove_characters",{ id = parseInt(user_id) })
		Citizen.Wait(1000)
		vRP.rejoinServer(source)
		Citizen.Wait(1000)
		TriggerClientEvent("spawn:setupChars",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("call",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vCLIENT.getHandcuff(source) then
			local service = vRP.prompt(source,"911: Polícia     |     112: Paramédico     |     443: Mecânico","")
			if service == "" or (parseInt(service) ~= 911 and parseInt(service) ~= 112 and parseInt(service) ~= 443) then
				return
			end

			local description = vRP.prompt(source,"Descrição do ocorrido:","")
			if description == "" then
				return
			end

			local players = {}
			local answered = false
			if parseInt(service) == 911 then
				players = vRP.getUsersByPermission("policia.permissao")
			elseif parseInt(service) == 112 then
				players = vRP.numPermission("Paramedic")
			elseif parseInt(service) == 443 then
				players = vRP.numPermission("Mechanic")
			end

			TriggerClientEvent("Notify",source,"sucesso","Chamado efetuado com sucesso, aguarde no local.",5000)

			local x,y,z = vRPclient.getPositions(source)
			local identity = vRP.getUserIdentity(user_id)

			for k,v in pairs(players) do
				local nuser_id = vRP.getUserId(v)
				local identitys = vRP.getUserIdentity(nuser_id)
				if v and v ~= source then
					async(function()
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Chamado", x = x, y = y, z = z, name = identity.name.." "..identity.name2, phone = identity.phone, rgba = {69,115,41} })
						local request = vRP.request(v,"Aceitar o chamado de <b>"..identity.name.." "..identity.name2.."</b>?",30)
						if request then
							if not answered then
								answered = true
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identitys.name.." "..identitys.name2.."</b>, aguarde no local.",10000)
							else
								TriggerClientEvent("Notify",v,"negado","Chamado já foi atendido por outra pessoa.",5000)
								vRPclient.playSound(v,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pr",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id, "policia.permissao") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local identity = vRP.getUserIdentity(user_id)
				local police = vRP.getUsersByPermission("policia.permissao")
				for k,v in pairs(police) do
					async(function()
						TriggerClientEvent("chatMessage",v,identity.name.." "..identity.name2,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hr",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local identity = vRP.getUserIdentity(user_id)
				local police = vRP.numPermission("Paramedic")
				for k,v in pairs(police) do
					async(function()
						TriggerClientEvent("chatMessage",v,identity.name.." "..identity.name2,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("extras",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id, "policia.permissao") and vRP.hasPermission("Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				vCLIENT.extraVehicle(args[1],source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATENAME
-----------------------------------------------------------------------------------------------------------------------------------------
local plateName = { "James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio","Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local plateName2 = { "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }
local plateSave = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("placa",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") then
			if vRPclient.getHealth(source) > 101 then
				if args[1] then
					local plateUser = vRP.getVehiclePlate(tostring(args[1]))
					if plateUser then
						local identity = vRP.getUserIdentity(plateUser)
						if identity then
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							TriggerClientEvent("Notify",source,"roxo","<b>Passaporte:</b> "..identity.id.."<br><b>RG:</b> "..identity.registration.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>Telefone:</b> "..identity.phone,25000)
						end
					else
						if not plateSave[string.upper(args[1])] then
							plateSave[string.upper(args[1])] = { math.random(5000,9999),plateName[math.random(#plateName)].." "..plateName2[math.random(#plateName2)],vRP.generatePhoneNumber() }
						end

						vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
						TriggerClientEvent("Notify",source,"roxo","<b>Passaporte:</b> "..plateSave[args[1]][1].."<br><b>RG:</b> "..string.upper(args[1]).."<br><b>Nome:</b> "..plateSave[args[1]][2].."<br><b>Telefone:</b> "..plateSave[args[1]][3],25000)
					end
				else
					local vehicle,vehNet,vehPlate = vRPclient.vehList(source,7)
					if vehicle then
						local plateUser = vRP.getVehiclePlate(vehPlate)
						if plateUser then
							local identity = vRP.getUserIdentity(plateUser)
							if identity then
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								TriggerClientEvent("Notify",source,"roxo","<b>Passaporte:</b> "..identity.id.."<br><b>RG:</b> "..identity.registration.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>Telefone:</b> "..identity.phone,25000)
							end
						else
							if not plateSave[vehPlate] then
								plateSave[vehPlate] = { math.random(5000,9999),plateName[math.random(#plateName)].." "..plateName2[math.random(#plateName2)],vRP.generatePhoneNumber() }
							end

							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							TriggerClientEvent("Notify",source,"roxo","<b>Passaporte:</b> "..plateSave[vehPlate][1].."<br><b>RG:</b> "..vehPlate.."<br><b>Nome:</b> "..plateSave[vehPlate][2].."<br><b>Telefone:</b> "..plateSave[vehPlate][3],25000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("detido",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,7)
				if vehicle then
					local plateUser = vRP.getVehiclePlate(vehPlate)
					local inVehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(plateUser), vehicle = vehName })
					if inVehicle[1] then
						if inVehicle[1].arrest <= 0 then
							vRP.execute("vRP/set_arrest",{ user_id = parseInt(plateUser), vehicle = vehName, arrest = 1, time = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"aviso","Veículo <b>apreendido</b>.",3000)
							TriggerClientEvent("Notify",plateUser,"aviso","Veículo <b>"..vRP.vehicleName(vehName).."</b> foi conduzido para o <b>DMV</b>.",7000)
						else
							TriggerClientEvent("Notify",source,"importante","O veículo está no galpão da polícia.",5000)
						end
					end
				end
			end
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- SERVICE:POLICE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("player:servicePolice")
-- AddEventHandler("player:servicePolice",function()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)

-- 	if vRP.hasPermission(user_id, "policiaCabo.permissao") then
-- 		vRP.removePermission(source,"policiaCabo.permissao")
-- 		TriggerClientEvent("Notify",source,"verde","Você saiu de serviço.",5000)
-- 		TriggerEvent("blipsystem:serviceExit",source)
-- 		TriggerClientEvent("tencode:StatusService",source,false)
-- 		TriggerClientEvent("police:updateService",source,false)
-- 		vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "policiaCabo.permissao", newpermiss = "paisanaCabo.permissao" })
-- 	elseif vRP.hasPermission(user_id,"paisanaCabo.permissao") then
-- 		vRP.insertPermission(source,"policiaCabo.permissao")
-- 		TriggerClientEvent("tencode:StatusService",source,true)
-- 		TriggerClientEvent("police:updateService",source,true)
-- 		TriggerEvent("blipsystem:serviceEnter",source,"policiaCabo.permissao",77)
-- 		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
-- 		vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "paisanaCabo.permissao", newpermiss = "policiaCabo.permissao" })
-- 	else
-- 		TriggerClientEvent("Notify",source,"amarelo","Você não trabalha neste local.",5000)
-- 	end
-- end)

local _weapons = {
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_APPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_REVOLVER",
	"WEAPON_COMBATPISTOL",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GUSENBERG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_CARBINERIFLE",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_RPG",
	"WEAPON_PETROLCAN",
}
function removeWeapon(source)
	local user_id = vRP.getUserId(source)
	local inv = vRP.getInventory(user_id)
	
	for k,v in pairs(inv) do
		for w,i in pairs(_weapons) do
			vitem = json.encode(v["item"])
			kqntd = json.encode(v["amount"])
			iItem = json.encode(i)
			--print("item: "..i.." outro item: "..vitem)
			if vitem == tostring(iItem) then
					print(user_id,tostring(iItem),parseInt(kqntd))
				if vRP.tryGetInventoryItem(user_id,i,kqntd) then

					if i == "WEAPON_COMBATPISTOL" then
						vRP.giveInventoryItem(user_id,"dollars",2500,true)
					elseif i == "WEAPON_CARBINERIFLE" then	
						vRP.giveInventoryItem(user_id,"dollars",12000,true)
					elseif i == "WEAPON_SMG" then	
						vRP.giveInventoryItem(user_id,"dollars",7000,true)	
					end	
					
				end	
	 		end	
		end	
	end	

end	



--------------------------------------------------
-- POLICIA
--------------------------------------------------
local webhooktoogle = 'https://discord.com/api/webhooks/1012873467344978001/iIBm88l9UxAqHG4M4tz1Pieni3_xm0kryzFb7db447W2rpenmoJkTe6-RI1aLY2u9Lu0'

-----------------------------------------------------------------------------------------------------------------------------------------
-- /toggle
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:servicePolice")
AddEventHandler("player:servicePolice",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local player = vRP.getUserSource(user_id)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) then
		return
	end

	-- if not vCLIENT.tooglePMERJ(source) then
	-- 	return
	-- end	
	--------------------------------
	-- Comandante
	--------------------------------
	if vRP.hasPermission(user_id,"policiaComando.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaComandante")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.",5000)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerEvent('eblips:remove',player)
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaComandante.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Comandante")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Soldado
	--------------------------------
	if vRP.hasPermission(user_id,"Soldado.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaSoldado")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.",5000)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerEvent('eblips:remove',player)
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaSoldado.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Soldado")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Cabo
	--------------------------------
	if vRP.hasPermission(user_id,"Cabo.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaCabo")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
		TriggerEvent('eblips:remove',player)
	elseif vRP.hasPermission(user_id,"paisanaCabo.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Cabo")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Sargento
	--------------------------------
	if vRP.hasPermission(user_id,"Sargento.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaSargento")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaSargento.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Sargento")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- SubTenente
	--------------------------------
	if vRP.hasPermission(user_id,"SubTenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaSubTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaSubTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SubTenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Aspirante
	--------------------------------
	if vRP.hasPermission(user_id,"Aspirante.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaAspirante")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaAspirante.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Aspirante")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Tenente
	--------------------------------
	if vRP.hasPermission(user_id,"Tenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Tenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Capitao
	--------------------------------
	if vRP.hasPermission(user_id,"Capitao.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaCapitao")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaCapitao.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Capitao")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Major
	--------------------------------
	if vRP.hasPermission(user_id,"Major.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMajor")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaMajor.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Major")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- TenenteCoronel
	--------------------------------
	if vRP.hasPermission(user_id,"TenenteCoronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"TenenteCoronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"TenenteCoronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"TenenteCoronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Coronel
	--------------------------------
	if vRP.hasPermission(user_id,"Coronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"Coronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"Coronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Coronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end


---------------------------------------BOPE-------------------------------------------------------------------------------------------


	--------------------------------
	-- Soldado
	--------------------------------
	
	if vRP.hasPermission(user_id,"bopeSoldado.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaSoldado")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.",5000)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerEvent('eblips:remove',player)
		removeWeapon(source)
	elseif vRP.hasPermission(user_id,"BopepaisanaSoldado.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeSoldado")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

	end
	--------------------------------
	-- Cabo
	--------------------------------
	if vRP.hasPermission(user_id,"bopeCabo.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaCabo")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"BopepaisanaCabo.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeCabo")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Sargento
	--------------------------------
	if vRP.hasPermission(user_id,"bopeSargento.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaSargento")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"BopepaisanaSargento.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeSargento")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- SubTenente
	--------------------------------
	if vRP.hasPermission(user_id,"bopeSubTenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaSubTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"BopepaisanaSubTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeSubTenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Aspirante
	--------------------------------
	if vRP.hasPermission(user_id,"bopeAspirante.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaAspirante")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"BopepaisanaAspirante.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeAspirante")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Tenente
	--------------------------------
	if vRP.hasPermission(user_id,"bopeTenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"paisanaTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeTenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Capitao
	--------------------------------
	if vRP.hasPermission(user_id,"bopeCapitao.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaCapitao")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"BopepaisanaCapitao.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeCapitao")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Major
	--------------------------------
	if vRP.hasPermission(user_id,"bopeMajor.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"BopePaisanaMajor")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"BopepaisanaMajor.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeMajor")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- TenenteCoronel
	--------------------------------
	if vRP.hasPermission(user_id,"bopeTenenteCoronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"TenenteCoronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"TenenteCoronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeTenenteCoronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Coronel
	--------------------------------
	if vRP.hasPermission(user_id,"bopeCoronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"Coronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"Coronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"BopeCoronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
----------------------------------------------------------------SPEED------------------------------------------------------------------------------------------------------------	

	--------------------------------
	-- Soldado
	--------------------------------
	if vRP.hasPermission(user_id,"speedSoldado.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaSoldado")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaSoldado.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedSoldado")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Cabo
	--------------------------------
	if vRP.hasPermission(user_id,"speedCabo.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaCabo")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaCabo.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedCabo")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Sargento
	--------------------------------
	if vRP.hasPermission(user_id,"speedSargento.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaSargento")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaSargento.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedSargento")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- SubTenente
	--------------------------------
	if vRP.hasPermission(user_id,"speedSubTenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaSubTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaSubTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedSubTenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Aspirante
	--------------------------------
	if vRP.hasPermission(user_id,"speedAspirante.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaAspirante")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaAspirante.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedAspirante")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Tenente
	--------------------------------
	if vRP.hasPermission(user_id,"speedTenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedTenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Capitao
	--------------------------------
	if vRP.hasPermission(user_id,"speedCapitao.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaCapitao")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaCapitao.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedCapitao")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Major
	--------------------------------
	if vRP.hasPermission(user_id,"speedMajor.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaMajor")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedpaisanaMajor.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedMajor")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- TenenteCoronel
	--------------------------------
	if vRP.hasPermission(user_id,"speedTenenteCoronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaTenenteCoronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedTenenteCoronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedTenenteCoronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Coronel
	--------------------------------
	if vRP.hasPermission(user_id,"speedCoronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"SpeedPaisanaCoronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"SpeedCoronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SpeedCoronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end

-----------------------------------------------------GAM----------------------------------------------------------------------

	--------------------------------
	-- Soldado
	--------------------------------
	if vRP.hasPermission(user_id,"gamSoldado.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaSoldado")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaSoldado.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamSoldado")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Cabo
	--------------------------------
	if vRP.hasPermission(user_id,"gamCabo.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaCabo")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaCabo.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamCabo")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Sargento
	--------------------------------
	if vRP.hasPermission(user_id,"gamSargento.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaSargento")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaSargento.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamSargento")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- SubTenente
	--------------------------------
	if vRP.hasPermission(user_id,"gamSubTenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaSubTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaSubTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamSubTenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Aspirante
	--------------------------------
	if vRP.hasPermission(user_id,"gamAspirante.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaAspirante")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaAspirante.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamAspirante")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Tenente
	--------------------------------
	if vRP.hasPermission(user_id,"gamTenente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaTenente")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaTenente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamTenente")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Capitao
	--------------------------------
	if vRP.hasPermission(user_id,"gamCapitao.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaCapitao")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaCapitao.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamCapitao")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Major
	--------------------------------
	if vRP.hasPermission(user_id,"gamMajor.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamPaisanaMajor")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaMajor.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamMajor")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- TenenteCoronel
	--------------------------------
	if vRP.hasPermission(user_id,"gamTenenteCoronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamTenenteCoronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaTenenteCoronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamTenenteCoronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Coronel
	--------------------------------
	if vRP.hasPermission(user_id,"gamCoronel.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"GamCoronel")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		TriggerEvent('eblips:remove',player)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		removeWeapon(source)
		
	elseif vRP.hasPermission(user_id,"GampaisanaCoronel.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"Policial em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"GamCoronel")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
end)

local webhookMec = 'https://discord.com/api/webhooks/1023671923072319518/EP-GBblmrPHaH2ws_X9PpTgMXMNz3WF2A56ALWVlskwTQeBZCIn9GNxzVGUfWDu9EEwO'	
RegisterCommand('mecanico',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) then
		return
	end
	if not vCLIENT.toogleMEC(source) then
		return
	end	
	

	--------------------------------
	-- Aprendiz
	--------------------------------
	if vRP.hasPermission(user_id,"mecanicoA.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMecanicoA")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanamecanicoA.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MECANICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"MecanicoA")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end

	--------------------------------
	-- Contratado
	--------------------------------
	if vRP.hasPermission(user_id,"mecanicoC.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMecanicoC")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanamecanicoC.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MECANICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"MecanicoC")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Gerente
	--------------------------------
	if vRP.hasPermission(user_id,"mecanicoG.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMecanicoG")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanamecanicoG.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MECANICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"MecanicoG")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Gerente Geral 
	--------------------------------
	if vRP.hasPermission(user_id,"mecanicoGG.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMecanicoGG")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanamecanicoGG.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MECANICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"MecanicoGG")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Lider
	--------------------------------
	if vRP.hasPermission(user_id,"mecanicoL.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMecanicoL")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanamecanicoL.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MECANICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"MecanicoL")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMec,"```prolog\n[MECANICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end

end)




local webhookMed = 'https://discord.com/api/webhooks/1023683712103227452/j_tw73apVQO12Y6GnFgcOJrO8RkB_EJjgFCWERH7kTZzq89ni_vTNr8NNgXc3k8XBSNs'	
RegisterCommand('medico',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRPclient.getHealth(source) <= 101 or vRPclient.isHandcuffed(source) then
		return
	end
	if not vCLIENT.toogleMED(source) then
		return
	end

	--------------------------------
	-- Paramedico
	--------------------------------
	if vRP.hasPermission(user_id,"paramedicoj.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaParamedico")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanaparamedico.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MEDICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Paramedico")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Enfermeiro
	--------------------------------
	if vRP.hasPermission(user_id,"residente.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaEnfermaria")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanaresidente.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MEDICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Enfermaria")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Medico
	--------------------------------
	if vRP.hasPermission(user_id,"medico.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMedico")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanamedico.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MEDICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Medico")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Medico Supervisor
	--------------------------------
	if vRP.hasPermission(user_id,"medicochefe.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaMedicoSupervisor")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanamedicochefe.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MEDICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"MedicoSupervisor")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Cirurgião
	--------------------------------
	if vRP.hasPermission(user_id,"supervisaoala.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaCirurgiao")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanasupervisaoala.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MEDICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Cirurgiao")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end

	--------------------------------
	-- Sub Diretor
	--------------------------------
	if vRP.hasPermission(user_id,"subdiretora.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaSubChefe")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanasubchefe.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MEDICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"SubDiretoria")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
	--------------------------------
	-- Diretor
	--------------------------------
	if vRP.hasPermission(user_id,"diretora.permissao") then
		TriggerEvent("vrp_sysblips:ExitService",source)
		TriggerClientEvent("tencode:StatusService",source,false)
		vRP.addUserGroup(user_id,"PaisanaDiretoria")
		
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"vermelho","Você saiu de serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	elseif vRP.hasPermission(user_id,"paisanadiretora.permissao") then
		TriggerClientEvent("vrp_sysblips:ToggleService",source,"MEDICO em Serviço",47)
		TriggerClientEvent("tencode:StatusService",source,true)
		vRP.addUserGroup(user_id,"Diretoria")
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		SendWebhookMessage(webhookMed,"```prolog\n[MEDICO]: "..user_id.." "..identity["name"].." "..identity["name2"].." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		
	end
end)		























































-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:PARAMEDIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:serviceParamedic")
AddEventHandler("player:serviceParamedic",function()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,"Paramedic") then
		vRP.removePermission(source,"Paramedic")
		TriggerClientEvent("Notify",source,"verde","Você saiu de serviço.",5000)
		TriggerEvent("blipsystem:serviceExit",source)
		TriggerClientEvent("paramedic:updateService",source,false)
		vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "Paramedic", newpermiss = "waitParamedic" })
	elseif vRP.hasPermission(user_id,"waitParamedic") then
		vRP.insertPermission(source,"Paramedic")
		TriggerClientEvent("paramedic:updateService",source,true)
		TriggerEvent("blipsystem:serviceEnter",source,"Paramedic",83)
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "waitParamedic", newpermiss = "Paramedic" })
	else
		TriggerClientEvent("Notify",source,"amarelo","Você não trabalha neste local.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:MECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:serviceMechanic")
AddEventHandler("player:serviceMechanic",function()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id,"Mechanic") then
		vRP.removePermission(source,"Mechanic")
		TriggerClientEvent("Notify",source,"verde","Você saiu de serviço.",5000)
		TriggerEvent("blipsystem:serviceExit",source)
		-- TriggerClientEvent("tencode:StatusService",source,false)
		vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "Mechanic", newpermiss = "waitMechanic" })
	elseif vRP.hasPermission(user_id,"waitMechanic") then
		vRP.insertPermission(source,"Mechanic")
		-- TriggerClientEvent("tencode:StatusService",source,true)
		TriggerEvent("blipsystem:serviceEnter",source,"Mechanic",77)
		TriggerClientEvent("Notify",source,"verde","Você entrou em serviço.",5000)
		vRP.execute("vRP/upd_group",{ user_id = user_id, permiss = "waitMechanic", newpermiss = "Mechanic" })
	else
		TriggerClientEvent("Notify",source,"amarelo","Você não trabalha neste local.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local poCuff = {}
function cRP.cuffToggle()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if  vRP.getInventoryItemAmount(user_id,"handcuff") >= 1 then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) and poCuff[user_id] == nil then
				if not vRPclient.inVehicle(source) then
					local nplayer = vRPclient.nearestPlayer(source,2)
					if nplayer then
						if vCLIENT.checkcuff(nplayer) then -- checkar se o player está rendido ou está algemado
							
							

							if vCLIENT.getHandcuff(nplayer) then
								vCLIENT.CarryCuff(nplayer,source)
								vRPclient._playAnim(source,false,{"mp_arresting","a_uncuff"},false)--animação do player desalgemando
								Citizen.Wait(4000)
								vCLIENT.toggleHandcuff(nplayer)
								vCLIENT.CarryCuff(nplayer,source)
								vRPclient._stopAnim(nplayer,false)
								TriggerClientEvent("sounds:source",source,"uncuff",0.5)
								TriggerClientEvent("sounds:source",nplayer,"uncuff",0.5)
							else
								poCuff[user_id] = true
								local taskResult = vTASKBAR.taskHandcuff(nplayer)
								if not taskResult then
									vCLIENT.CarryCuff(nplayer,source)
									vRPclient._playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)--animação do player algemando
									vRPclient._playAnim(nplayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
									Citizen.Wait(4000)
									vCLIENT.toggleHandcuff(nplayer)
									TriggerClientEvent("sounds:source",source,"cuff",0.5)
									TriggerClientEvent("sounds:source",nplayer,"cuff",0.5)
									
									--vRPclient._playAnim(nplayer,true,{"mp_arresting","idle"},true)--animação do player 2 algemado
									
									vCLIENT.CarryCuff(nplayer,source)
								end
								poCuff[user_id] = nil
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Jogador proximo deve estar com as mãos para cima.",5000)
						end		
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local shotFired = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(shotFired) do
			if shotFired[k] > 0 then
				shotFired[k] = v - 10
				if shotFired[k] <= 0 then
					shotFired[k] = nil
				end
			end
		end
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
-- function cRP.shotsFired()
-- 	print("chamado")
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if shotFired[user_id] == nil then
-- 			if not vRP.hasPermission(user_id, "policia.permissao") then
-- 				 local distance = vCLIENT.shotDistance(source)

-- 				if distance then
-- 					shotFired[user_id] = 30
-- 					local x,y,z = vRPclient.getPositions(source)
-- 					local comAmount = vRP.getUsersByPermission("policia.permissao")
-- 					for k,v in pairs(comAmount) do
-- 						async(function()
-- 							TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 10, title = "Confronto em andamento", x = x, y = y, z = z, criminal = "Disparos de arma de fogo", rgba = {105,52,136} })
-- 						end)
-- 					end
-- 				 end
-- 			end
-- 		end
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.carryToggle()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					vCLIENT.toggleCarry(nplayer,source)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("carregar2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id,"Paramedic") then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					TriggerClientEvent("rope:toggleRope",source,nplayer)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id,"Paramedic") or vRP.getInventoryItemAmount(user_id,"rope") >= 1 then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) and not vRPclient.inVehicle(source) then
				local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
				if vehicle then
					if vehLock ~= 1 then
						local nplayer = vRPclient.nearestPlayer(source,11)
						if nplayer then
							vCLIENT.removeVehicle(nplayer)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(mode)
	local source = source
	local distance = 1.1

	if mode == "rv" then
		distance = 10.0
	end

	local otherPlayer = vRPC.nearestPlayer(source,distance)
	if otherPlayer then
		local user_id = vRP.getUserId(source)
		local consultItem = vRP.getInventoryItemAmount(user_id,"rope")
		if vRP.getInventoryItemAmount(user_id,"rope") >= 1 then
			local vehicle,vehNet = vRPclient.vehList(source,5)
			if vehicle then
				local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
				local doorStatus = GetVehicleDoorLockStatus(idNetwork)
			
				if parseInt(doorStatus) <= 1 then
					if mode == "rv" then
						vCLIENT.removeVehicle(otherPlayer)
					elseif mode == "cv" then
						vCLIENT.putVehicle(otherPlayer,vehNet)
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.getInventoryItemAmount(user_id,"rope") >= 1 then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) and not vRPclient.inVehicle(source) then
				local vehicle,vehNet,vehPlate,vehName,vehLock = vRPclient.vehList(source,11)
				if vehicle then
					if vehLock ~= 1 then
						local nplayer = vRPclient.nearestPlayer(source,2)
						if nplayer then
							vCLIENT.putVehicle(nplayer,args[1])
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("check",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id,"Admin") then
			if parseInt(args[1]) > 0 then
				local nuser_id = parseInt(args[1])
				local identity = vRP.getUserIdentity(nuser_id)
				if identity then
					local fines = 0
					local consult = vRP.getFines(nuser_id)
					for k,v in pairs(consult) do
						fines = parseInt(fines) + parseInt(v.price)
					end

					TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..identity.id.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(fines)),20000)
				end
			else
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						local identity = vRP.getUserIdentity(nuser_id)
						if identity then
							local fines = 0
							local consult = vRP.getFines(nuser_id)
							for k,v in pairs(consult) do
								fines = parseInt(fines) + parseInt(v.price)
							end

							TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..identity.id.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(fines)),20000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	--policia
		["1"] = {
			-------  Praça ---------
			["homem"] = {
				["hat"] = { item = -1, texture = 1, defaultItem = -1, defaultTexture = 0 }, --chapéu     
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 98, texture = 0, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --chapéu
				["arms"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 90, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- calca
				["vest"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },--colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 },--camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },--jaqueta
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },--braços
				["glass"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["2"] = {
			-------  Ofical ---------
			["homem"] = {
				["hat"] = { item = -1, texture = 1, defaultItem = -1, defaultTexture = 0 }, --chapéu     -------  ALUNO ---------
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 98, texture = 1, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --chapéu
				["arms"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 90, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- calca
				["vest"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },--colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 },--camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 31, texture = 1, defaultItem = 0, defaultTexture = 0 },--jaqueta
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },--braços
				["glass"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["3"] = {
			["homem"] = {
				-------  BOPE ---------
				["hat"] = { item = 28, texture = 1, defaultItem = -1, defaultTexture = 0 }, --chapéu   ----------- ROMIC ----------
				["pants"] = { item = 130, texture = 1, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 16, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = 169, texture = 0, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 49, texture = 0, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --chapéu
				["arms"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 90, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- calca
				["vest"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },--colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 35, texture = 0, defaultItem = 0, defaultTexture = 0 },-- mascara
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 },--camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 42, texture = 0, defaultItem = 0, defaultTexture = 0 },--jaqueta
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 9, texture = 0, defaultItem = 0, defaultTexture = 0 },--braços
				["glass"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["4"] = {
			------ GAM ----------
			["homem"] = {
				["hat"] = { item = 19, texture = 0, defaultItem = -1, defaultTexture = 0 }, --chapéu --------- GAIC --------
				["pants"] = { item = 87, texture = 0, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 8, texture = 0, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = 6, texture = 1, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 220, texture = 4, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --RELOGIO
				["arms"] = { item = 17, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 5, texture = 2, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = 38, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 90, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- calca
				["vest"] = { item = 14, texture = 0, defaultItem = 0, defaultTexture = 0 },--colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 169, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 },--camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 31, texture = 1, defaultItem = 0, defaultTexture = 0 },--jaqueta
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },--braços
				["glass"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["5"] = {
			------ GTM ----------
			["homem"] = {
				["hat"] = { item = 19, texture = 0, defaultItem = -1, defaultTexture = 0 }, --chapéu --------- GAIC --------
				["pants"] = { item = 87, texture = 0, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 8, texture = 0, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = 52, texture = 0, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = 6, texture = 1, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 220, texture = 4, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --RELOGIO
				["arms"] = { item = 17, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 5, texture = 2, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = 91, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 90, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- calca
				["vest"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },--colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = -1, texture = 0, defaultItem = 1, defaultTexture = 0 },--camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 31, texture = 1, defaultItem = 0, defaultTexture = 0 },--jaqueta
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },--braços
				["glass"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["6"] = {
			["homem"] = {
				["hat"] = { item = 0, texture = 0, defaultItem = -1, defaultTexture = 0 }, --chapéu --------- SPEED --------
				["pants"] = { item = 87, texture = 0, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = 16, texture = 0, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 220, texture = 1, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --RELOGIO
				["arms"] = { item = 17, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 5, texture = 2, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 61, texture = 9, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 9, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 266, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 70, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 11, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["7"] = {
			["homem"] = {
				["hat"] = { item = 0, texture = 0, defaultItem = -1, defaultTexture = 0 }, --chapéu --------- GOTIC --------
				["pants"] = { item = 87, texture = 0, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 6, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 8, texture = 0, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = 103, texture = 20, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = 54, texture = 0, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 220, texture = 0, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --RELOGIO
				["arms"] = { item = 17, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 15, texture = 0, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 61, texture = 9, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 6, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 107, texture = 13, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 7, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 230, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 34, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 9, texture = 5, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["8"] = {
			["homem"] = {
				["hat"] = { item = 106, texture = 20, defaultItem = -1, defaultTexture = 0 }, --chapéu --------- coronel --------
				["pants"] = { item = 87, texture = 0, defaultItem = 0, defaultTexture = 0 },  --calça
				["vest"] = { item = 2, texture = 0, defaultItem = 0, defaultTexture = 0 }, --colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 8, texture = 3, defaultItem = 0, defaultTexture = 0 }, --adesivo
				["mask"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --mascarar
				["shoes"] = { item = 25, texture = 0, defaultItem = 1, defaultTexture = 0 }, --sapatos
				["t-shirt"] = { item = 55, texture = 0, defaultItem = 1, defaultTexture = 0 }, --camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --sacola mochila
				["torso2"] = { item = 53, texture = 0, defaultItem = 0, defaultTexture = 0 }, --tronco
				["accessory"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, --acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --RELOGIO
				["arms"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --braços
				["glass"] = { item = 18, texture = 2, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 } --orelha
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 30, texture = 2, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 7, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 103, texture = 13, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 230, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 212, texture = 9, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
	},
--PARAMEDICO/ENFERMEIRO
		["9"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },--chapéu 
				["pants"] = { item = 38, texture = 1, defaultItem = 0, defaultTexture = 0 },--calca
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },--colete
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, --pulseira
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },--adesivo
				["mask"] = { item = -1, texture = 0, defaultItem = 0, defaultTexture = 0 },--mascarar
				["shoes"] = { item = 26, texture = 2, defaultItem = 1, defaultTexture = 0 },--sapatos
				["t-shirt"] = { item = 15, texture = 0, defaultItem = 1, defaultTexture = 0 }, -- camiseta
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },--sacola mochila
				["torso2"] = { item = 65, texture = 1, defaultItem = 0, defaultTexture = 0 }, -- jaqueta
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },--acessorios
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },--RELOGIO
				["arms"] = { item = 1, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- maos
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 }, --vidro
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }  --orelha
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 99, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 81, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 6, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 258, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["10"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 42, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 76, texture = 6, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 23, texture = 3, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 126, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 88, texture = 1, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 50, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 81, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 78, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 57, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 92, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["11"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 20, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 42, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 27, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 24, texture = 12, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 30, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 88, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 23, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 81, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 101, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 58, texture = 7, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 96, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 92, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
		},
		["12"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 10, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 10, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 33, texture = 2, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 29, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 127, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 4, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 6, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 6, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 40, texture = 2, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 57, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 97, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 3, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
	},
--mecanico
		["13"] = {
			["homem"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["pants"] = { item = 4, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 81, texture = 2, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 90, texture = 1, defaultItem = 1, defaultTexture = 0 },
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 18, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = 10, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["arms"] = { item = 19, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["glass"] = { item = 5, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			},
			["mulher"] = {
				["hat"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }, -- chapeu
				["pants"] = { item = 4, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- calca
				["vest"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["bracelet"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 },
				["decals"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["mask"] = { item = 121, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["shoes"] = { item = 24, texture = 0, defaultItem = 1, defaultTexture = 0 },
				["t-shirt"] = { item = 54, texture = 0, defaultItem = 1, defaultTexture = 0 }, -- camisa
				["bag"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["torso2"] = { item = 73, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- jaqueta
				["accessory"] = { item = 0, texture = 0, defaultItem = 0, defaultTexture = 0 },
				["watch"] = { item = 5, texture = 3, defaultItem = -1, defaultTexture = 0 }, -- relogio
				["arms"] = { item = 31, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- maos
				["glass"] = { item = 12, texture = 0, defaultItem = 0, defaultTexture = 0 }, -- oculos
				["ear"] = { item = -1, texture = 0, defaultItem = -1, defaultTexture = 0 }
			}
	}	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("preset",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[1]) > 0 then
			if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
				local model = vRPclient.getModelPlayer(source)
				if vRP.hasPermission(user_id,"Paramedic") and preset["Paramedic"][tostring(args[1])] then
					if model == "mp_m_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Paramedic"][tostring(args[1])]["homem"])
					elseif model == "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Paramedic"][tostring(args[1])]["mulher"])
					end
				elseif vRP.hasPermission(user_id,"Mechanic") and preset["Mechanic"][tostring(args[1])] then
					if model == "mp_m_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Mechanic"][tostring(args[1])]["homem"])
					elseif model == "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Mechanic"][tostring(args[1])]["mulher"])
					end
				elseif vRP.hasPermission(user_id, "policia.permissao") and preset["Police"][tostring(args[1])] then
					if model == "mp_m_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Police"][tostring(args[1])]["homem"])
					elseif model == "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,preset["Police"][tostring(args[1])]["mulher"])
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("outfit",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			if args[1] then
				if args[1] == "save" then
					local custom = vSKINSHOP.getCustomization(source)
					if custom then
						vRP.setSData("saveClothes:"..parseInt(user_id),json.encode(custom))
						TriggerClientEvent("Notify",source,"sucesso","Outfit salvo com sucesso.",3000)
					end
				end
			else
				local consult = vRP.getSData("saveClothes:"..parseInt(user_id))
				local result = json.decode(consult)
				if result then
					TriggerClientEvent("updateRoupas",source,result)
					TriggerClientEvent("Notify",source,"sucesso","Outfit aplicado com sucesso.",3000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUMFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("premiumfit",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) and vRP.getPremium(user_id) then
			if args[1] then
				if args[1] == "save" then
					local custom = vSKINSHOP.getCustomization(source)
					if custom then
						vRP.setSData("premClothes:"..parseInt(user_id),json.encode(custom))
						TriggerClientEvent("Notify",source,"sucesso","Premiumfit salvo com sucesso.",3000)
					end
				end
			else
				local consult = vRP.getSData("premClothes:"..parseInt(user_id))
				local result = json.decode(consult)
				if result then
					TriggerClientEvent("updateRoupas",source,result)
					TriggerClientEvent("Notify",source,"sucesso","Premiumfit aplicado com sucesso.",3000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETREPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setrepouso",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Paramedic") then
		local nplayer = vRPclient.nearestPlayer(source,2)
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local identity = vRP.getUserIdentity(parseInt(nuser_id))
				if vRP.request(source,"Deseja aplicar <b>"..parseInt(args[1]).." minutos</b>.",30) then
					vRP.reposeTimer(nuser_id,parseInt(args[1]))
					TriggerClientEvent("Notify",source,"sucesso","Você aplicou <b>"..parseInt(args[1]).." minutos</b> de repouso.",10000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALKING
-----------------------------------------------------------------------------------------------------------------------------------------
local walking = {
	{ "move_m@alien" },
	{ "anim_group_move_ballistic" },
	{ "move_f@arrogant@a" },
	{ "move_m@brave" },
	{ "move_m@casual@a" },
	{ "move_m@casual@b" },
	{ "move_m@casual@c" },
	{ "move_m@casual@d" },
	{ "move_m@casual@e" },
	{ "move_m@casual@f" },
	{ "move_f@chichi" },
	{ "move_m@confident" },
	{ "move_m@business@a" },
	{ "move_m@business@b" },
	{ "move_m@business@c" },
	{ "move_m@drunk@a" },
	{ "move_m@drunk@slightlydrunk" },
	{ "move_m@buzzed" },
	{ "move_m@drunk@verydrunk" },
	{ "move_f@femme@" },
	{ "move_characters@franklin@fire" },
	{ "move_characters@michael@fire" },
	{ "move_m@fire" },
	{ "move_f@flee@a" },
	{ "move_p_m_one" },
	{ "move_m@gangster@generic" },
	{ "move_m@gangster@ng" },
	{ "move_m@gangster@var_e" },
	{ "move_m@gangster@var_f" },
	{ "move_m@gangster@var_i" },
	{ "anim@move_m@grooving@" },
	{ "move_f@heels@c" },
	{ "move_m@hipster@a" },
	{ "move_m@hobo@a" },
	{ "move_f@hurry@a" },
	{ "move_p_m_zero_janitor" },
	{ "move_p_m_zero_slow" },
	{ "move_m@jog@" },
	{ "anim_group_move_lemar_alley" },
	{ "move_heist_lester" },
	{ "move_f@maneater" },
	{ "move_m@money" },
	{ "move_m@posh@" },
	{ "move_f@posh@" },
	{ "move_m@quick" },
	{ "female_fast_runner" },
	{ "move_m@sad@a" },
	{ "move_m@sassy" },
	{ "move_f@sassy" },
	{ "move_f@scared" },
	{ "move_f@sexy@a" },
	{ "move_m@shadyped@a" },
	{ "move_characters@jimmy@slow@" },
	{ "move_m@swagger" },
	{ "move_m@tough_guy@" },
	{ "move_f@tough_guy@" },
	{ "move_p_m_two" },
	{ "move_m@bag" },
	{ "move_m@injured" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("andar",function(source,args,rawCommand)
	if args[1] then
		if not vCLIENT.getHandcuff(source) then
			vCLIENT.movementClip(source,walking[parseInt(args[1])][1])
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- FATURAS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("faturas",function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		local nuser_id = vRP.prompt(source,"Passaporte:","")
-- 		if nuser_id == "" or parseInt(nuser_id) <= 0 then
-- 			return
-- 		end

-- 		local price = vRP.prompt(source,"Valor da fatura:","")
-- 		if price == "" or parseInt(price) <= 0 then
-- 			return
-- 		end

-- 		local reason = vRP.prompt(source,"Descrição da fatura:","")
-- 		if reason == "" then
-- 			return
-- 		end

-- 		local nplayer = vRP.getUserSource(parseInt(nuser_id))
-- 		if nplayer then
-- 			local identity = vRP.getUserIdentity(user_id)
-- 			local answered = vRP.request(nplayer,"Deseja aceitar a fatura no valor de <b>$"..vRP.format(parseInt(price)).." dólares</b>?",60)
-- 			if answered then
-- 				vRP.setInvoice(parseInt(nuser_id),parseInt(price),parseInt(user_id),tostring(reason))
-- 				TriggerClientEvent("Notify",source,"verde","A sua fatura foi aceita.",5000)
-- 			else
-- 				TriggerClientEvent("Notify",source,"vermelho","A sua fatura foi rejeitada.",5000)
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("extras",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id,"Paramedic")) and parseInt(args[1]) > 0 then
			vCLIENT.toggleLivery(source,parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("add",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[2]) > 0 then
			if args[1] == "Police" then
				if vRP.hasPermission(user_id,"PolMaster") then
					vRP.execute("vRP/cle_group",{ user_id = parseInt(args[2]) })
					vRP.execute("vRP/add_group",{ user_id = parseInt(args[2]), permiss = tostring("waitPolice") })
					vRP.insertPermission(parseInt(args[2]),tostring("waitPolice"))
					TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
				end
			end

			if args[1] == "Paramedic" then
				if vRP.hasPermission(user_id,"ParMaster") then
					vRP.execute("vRP/cle_group",{ user_id = parseInt(args[2]) })
					vRP.execute("vRP/add_group",{ user_id = parseInt(args[2]), permiss = tostring("waitParamedic") })
					vRP.insertPermission(parseInt(args[2]),tostring("waitParamedic"))
					TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
				end
			end

			if args[1] == "Mechanic" then
				if vRP.hasPermission(user_id,"MecMaster") then
					vRP.execute("vRP/cle_group",{ user_id = parseInt(args[2]) })
					vRP.execute("vRP/add_group",{ user_id = parseInt(args[2]), permiss = tostring("waitMechanic") })
					vRP.insertPermission(parseInt(args[2]),tostring("waitMechanic"))
					TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[1]) > 0 then
			if vRP.hasPermission(user_id,"PolMaster") or vRP.hasPermission(user_id,"MecMaster") or vRP.hasPermission(user_id,"ParMaster") then
				vRP.execute("vRP/cle_group",{ user_id = parseInt(args[1]) })
				TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[1])).."</b> removido com sucesso.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKIN
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("trunkin",function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
-- 			TriggerClientEvent("player:EnterTrunk",source)
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("splayer:CheckTrunk")
AddEventHandler("splayer:CheckTrunk",function()
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRPclient.getHealth(source) > 101 and not vRPclient.isInVehicle(source) and not vRPclient.isHandcuffed(source) then
            local nplayer = vRPclient.nearestPlayer(source,2)
            if nplayer then
                TriggerClientEvent("player:CheckTrunk",-1,source,nplayer)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEAT
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("p",function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
-- 			TriggerClientEvent("player:SeatPlayer",source,args[1])
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONDUTY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("onduty",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
			if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Mechanic") then
				local onDuty = ""
				local service = {}

				if vRP.hasPermission(user_id, "policia.permissao") then
					service = vRP.getUsersByPermission("policia.permissao")
				elseif vRP.hasPermission(user_id,"Paramedic") then
					service = vRP.numPermission("Paramedic")
				elseif vRP.hasPermission(user_id,"Mechanic") then
					service = vRP.numPermission("Mechanic")
				end

				for k,v in pairs(service) do
					local nuser_id = vRP.getUserId(v)
					local identity = vRP.getUserIdentity(nuser_id)

					onDuty = onDuty.."<b>Passaporte:</b> "..vRP.format(parseInt(nuser_id)).."   -   <b>Nome:</b> "..identity.name.." "..identity.name2.."<br>"
				end

				TriggerClientEvent("Notify",source,"importante",onDuty,30000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cam",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id, "policia.permissao") then
			TriggerClientEvent("player:serviceCamera",source,tostring(args[1]))
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
------COR ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cor', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'dono.permissao') then
        TriggerClientEvent('changeWeaponColor', source, args[1])
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["mask"]["item"] = -1
					end	
					TriggerClientEvent("setmascara",source,args[1],args[2])
					if args[1] then
						custom["mask"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["mask"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: MASCARA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					local custom = vSKINSHOP.getCustomization(source)

					
					if args[1] == nil then
						custom["t-shirt"]["item"] = -1
					end	
					TriggerClientEvent("setblusa",source,args[1],args[2])
					if args[1] then
						custom["t-shirt"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["t-shirt"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,json.encode(custom))
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: BLUSA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["vest"]["item"] = -1
					end	
					TriggerClientEvent("setcolete",source,args[1],args[2])
					if args[1] then
						custom["vest"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["vest"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: COLETE "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["torso2"]["item"] = -1
					end	
					TriggerClientEvent("setjaqueta",source,args[1],args[2])
					
					if args[1] then
						custom["torso2"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["torso2"]["texture"] = tonumber(args[2])
					end	

					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: JAQUETA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						return
					end	
					TriggerClientEvent("setmaos",source,args[1],args[2])
					
					if args[1] then	
						custom["arms"]["item"] = args[1]
					end	
					if args[2] then
						custom["arms"]["texture"] = args[2]
					end	

					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: MAOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["pants"]["item"] = 0
					end	
					TriggerClientEvent("setcalca",source,args[1],args[2])

					if args[1] then
						custom["pants"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["pants"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: CALÇA "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["accessory"]["item"] = -1
					end	

					TriggerClientEvent("setacessorios",source,args[1],args[2])
					if args[1] then
						custom["accessory"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["accessory"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: ACESSORIOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["shoes"]["item"] = -1
					end	
					TriggerClientEvent("setsapatos",source,args[1],args[2])

					
					if args[1] then
						custom["shoes"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["shoes"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: SAPATOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["hat"]["item"] = -1
					end	
					TriggerClientEvent("setchapeu",source,args[1],args[2])
					if args[1] then
						custom["hat"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["hat"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: CHAPEU "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)	
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["glass"]["item"] = -1
					end	
					TriggerClientEvent("setoculos",source,args[1],args[2])
					if args[1] then
						custom["glass"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["glass"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
					SendWebhookMessage(webhookvidaroupas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[UTILIZOU COMANDO]: OCULOS "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mochila',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRPclient.getHealth(source) > 101 then
        if not vRPclient.isHandcuffed(source) then
            if not vRP.searchReturn(source,user_id) then
                if user_id then
                    
					local custom = vSKINSHOP.getCustomization(source)
					if args[1] == nil then
						custom["bag"]["item"] = -1
					end	
					TriggerClientEvent("setmochila",source,args[1],args[2])
					if args[1] then
						custom["bag"]["item"] = tonumber(args[1])
					end	
					if args[2] then
						custom["bag"]["texture"] = tonumber(args[2])
					end	
					local model = vRPclient.getModelPlayer(source)
					if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
						TriggerClientEvent("updateRoupas",source,custom)
					end
				end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [BVIDA - desbugar animacao ---- /bvida --- colocar em vrp_player/server.lua]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida',function(source,rawCommand)
	local descricao1 = vRP.prompt(source,"Deseja utilizar o comando bvida?  DIGITE: sim","")
    if descricao1 == "sim" or descricao1 == "Sim" or descricao1 == "SIM" then
    if not use then
		use = true
		TriggerClientEvent('Notify',source,"sucesso","voce usou o comando bvida.")
    local user_id = vRP.getUserId(source)
        vRPclient._setCustomization(source,vRPclient.getCustomization(source))
	else -- ou então, pula para a linha abaixo (opcional)
		TriggerClientEvent('Notify',source,"negado","espere 1 minuto para executar esse comando novamente.") -- (opcional)
		Wait(60000) -- espera 5 segundos
        use = false -- redefine a informação que o player usou o comando
        TriggerClientEvent('Notify',source,"negado","comando bvida liberado novamente.") 
	end
end
end)
RegisterCommand('bonusfarm',function(source,rawCommand)
	local user_id = vRP.getUserId(source)
	local myBonus = vRP.bonusDelivery(user_id)
	TriggerClientEvent('Notify',source,"verde","você tem "..myBonus.." de Bonus",5000) 
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:presetFunctions")
AddEventHandler("player:presetFunctions",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local model = vRPclient.getModelPlayer(source)
		if model == "mp_m_freemode_01" then
			model = 'homem'
		else	
			model = 'mulher'
		end	

		if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
			TriggerClientEvent("updateRoupas",source,preset[number][model])
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
------VAPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Vape:Stress")
AddEventHandler("Vape:Stress", function()
	local user_id = vRP.getUserId(source)
	vRP.downgradeStress(user_id,2)
end)

RegisterNetEvent("Vape:Failure")
AddEventHandler("Vape:Failure", function()
	_s = source
	Player = GetPlayerName(_s)
	TriggerClientEvent("chatMessage", -1, " ^3>>> ^2Well, it seems that ^4@"..Player.."^2's vape has exploded in their face, The odds of that are ^31 ^2in ^310,594")
end)

RegisterServerEvent("eff_smokes")
AddEventHandler("eff_smokes", function(entity)
	TriggerClientEvent("c_eff_smokes", -1, entity)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tratar',function(source,args,rawCommand)
	
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.nearestPlayer(source,12)
		if nplayer then
			TriggerClientEvent('tratamento',nplayer)
			TriggerClientEvent("resetBleeding",nplayer)
			TriggerClientEvent("resetDiagnostic",nplayer)
			TriggerClientEvent("Notify",source,"verde","Tratamento iniciado",5000)
			TriggerClientEvent("Notify",nplayer,"verde","Tratamento iniciado",5000)

		end
	end
end)