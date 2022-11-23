-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
vCPLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("impound",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local impoundVehs = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND:CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("impound:Check")
AddEventHandler("impound:Check",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if impoundVehs[entity[2].."-"..entity[1]] == nil then
			return
		else
			impoundVehs[entity[2].."-"..entity[1]] = nil

			vRP.generateItem(user_id,"plastic",math.random(4,6),true)
			vRP.generateItem(user_id,"glass",math.random(4,6),true)
			vRP.generateItem(user_id,"rubber",math.random(4,6),true)
			vRP.generateItem(user_id,"aluminum",math.random(3,5),true)
			vRP.generateItem(user_id,"copper",math.random(3,5),true)

			TriggerClientEvent("garages:Delete",source,entity[3])
			vRP.upgradeStress(user_id,5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:impound")
AddEventHandler("police:impound",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasPermission(user_id, "policia.permissao") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			if impoundVehs[entity[2].."-"..entity[1]] == nil then
				impoundVehs[entity[2].."-"..entity[1]] = true
				TriggerEvent("towdriver:Call",source,entity[2],entity[1])
				vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"verde","Veículo <b>"..vehicleName(entity[2]).."</b> foi registrado.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Veículo <b>"..vehicleName(entity[2]).."</b> já está na lista.",3000)
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
-- POLICE:RUNPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:runPlate")
AddEventHandler("police:runPlate",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id  then
		if vRP.hasPermission(user_id, "policia.permissao") then
			runPlate(source,entity[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("placa",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, "policia.permissao") and args[1] then
			runPlate(source,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUNPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function runPlate(source,vehPlate)
	local userPlate = vRP.userPlate(vehPlate)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nameCompleting = identity['name'].." "..identity["name2"]
	if not userPlate then
		vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		TriggerClientEvent("Notify",source,"default","<b>Passaporte:</b> "..user_id.."<br><b>Nome:</b> "..nameCompleting.."<br><b>Nº:</b> "..vehPlate,10000)
	else
		TriggerClientEvent("Notify",source,"vermelho","Placa não encontrada",1000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNARREST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:runArrest")
AddEventHandler("police:runArrest",function()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		--print(user_id.."user id ok")
		if vRP.hasPermission(user_id, "policia.permissao") then

			if vRPC.getHealth(source) > 101 and not vCPLAYER.getHandcuff(source) then

				local vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,7)
				if vehicle then
					local plateUser = vRP.getVehiclePlate(vehPlate)
					local inVehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(plateUser), vehicle = vehName })
					if inVehicle[1] then
						if inVehicle[1].arrest <= 0 then
							local players = {}
							local answered = false

							players = vRP.getUsersByPermission("mecanico.permissao")
							local x,y,z = vRPC.getPositions(source)
							local identity = vRP.getUserIdentity(user_id)
							if not players then -- verificação se tem mecanico em serviço 
								TriggerClientEvent("Notify",source,"amarelo","Nenhum mecanico em serviço para rebocar o veiculo.",5000)
							end	
							local i = 0 -- variavel de contagem de requisições não aceitas 
							local MecsOn = 0 -- variavel de contagem de players que estão setados de mec
							for k,v in pairs(players) do --para cada mecanico
								
								local nuser_id = vRP.getUserId(v) --filtra id do mec
								local identitys = vRP.getUserIdentity(nuser_id) --filtra nome do mec
								MecsOn = MecsOn + 1 --contagem de quantos players que estão setados de mec
									async(function()
										TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Chamado", x = x, y = y, z = z, name = identity.name.." "..identity.name2, phone = identity.phone, rgba = {69,115,41} })
										local request = vRP.request(v,"Aceitar o chamado de REBOQUE <b>"..identity.name.." "..identity.name2.."</b>?",30)
										if request then
											if not answered then
												answered = true
												vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
												TriggerClientEvent("Notify",source,"amarelo","Chamado atendido por <b>"..identitys.name.." "..identitys.name2.."</b>, aguarde no local.",10000)
												vRP.execute("vRP/set_arrest",{ user_id = parseInt(plateUser), vehicle = vehName, arrest = 1, time = parseInt(os.time()) })
												TriggerClientEvent("Notify",source,"verde","Veículo <b>apreendido</b>.",3000)
											else
												TriggerClientEvent("Notify",v,"vermelho","Chamado já foi atendido por outra pessoa.",5000)
												vRPC.playSound(v,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
											end
										else
											i = i + 1 --variavel de contagem de requisições não aceitas 
											if i == MecsOn then -- se numero de rejeições var (i) for igual ao numero de players que estão setados de mec var (MecsOn)
												TriggerClientEvent("Notify",v,"vermelho","Chamado recusado.",5000)
											end	
										end
									end)
							end
							--TriggerClientEvent("Notify",plateUser,"aviso","Veículo <b>"..vRP.vehicleName(vehName).."</b> foi conduzido para o <b>DMV</b>.",7000)
						else
							--print("já estava preso")
							TriggerClientEvent("Notify",source,"amarelo","O veículo está no galpão da polícia.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","O veículo não tem registro.",5000)	
					end
				end
			end
		end
	end
end)