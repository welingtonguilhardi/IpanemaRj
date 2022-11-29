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
Tunnel.bindInterface("tencode",cRP)
vSERVER = Tunnel.getInterface("tencode")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
local service = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tencode",function(source,args)
	if service then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "openSystem" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("tencode","Abrir o código dez","keyboard","f11")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendCode",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "closeSystem" })

	vSERVER.sendCode(data.code)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- tencode:STATUSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tencode:StatusService")
AddEventHandler("tencode:StatusService",function(status)
	service = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
local radar = {
	shown = false,
	freeze = false,
	info = "CARREGANDO...",
	info2 = "CARREGANDO..."
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRADAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsUsing(ped)
		local PoliceVehicle = IsVehiclePolice(veh)
		if PoliceVehicle or IsPedInAnyPoliceVehicle(ped) then
			 timeDistance = 500
			if IsControlJustPressed(1,306) then
				if vSERVER.IsPolice() then
					radar.shown = not radar.shown
				end 	
			end

			if IsControlJustPressed(1,301) then
				if vSERVER.IsPolice() then
					radar.freeze = not radar.freeze
				end
			end
			timeDistance = 15
			if radar.shown and IsPedInAnyVehicle(ped) then
				if not radar.freeze then
					local veh = GetVehiclePedIsUsing(ped)
					local coordA = GetOffsetFromEntityInWorldCoords(veh,0.0,1.0,1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(veh,0.0,105.0,0.0)
					local frontcar = StartShapeTestCapsule(coordA,coordB,3.0,10,veh,7)
					local a,b,c,d,e = GetShapeTestResult(frontcar)

					if IsEntityAVehicle(e) then
						local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
						local fvspeed = GetEntitySpeed(e) * 2.236936
						local fplate = GetVehicleNumberPlateText(e)
						radar.info = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",fplate,fmodel,math.ceil(fvspeed))
					end

					local bcoordB = GetOffsetFromEntityInWorldCoords(veh,0.0,-105.0,0.0)
					local rearcar = StartShapeTestCapsule(coordA,bcoordB,3.0,10,veh,7)
					local f,g,h,i,j = GetShapeTestResult(rearcar)

					if IsEntityAVehicle(j) then
						local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
						local bvspeed = GetEntitySpeed(j) * 2.236936
						local bplate = GetVehicleNumberPlateText(j)
						radar.info2 = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",bplate,bmodel,math.ceil(bvspeed))
					end
				end

				dwText(radar.info,0.905)
				dwText(radar.info2,0.93)
			end
		end

		if not IsPedInAnyVehicle(ped) and radar.shown then
			radar.shown = false
			radar.freeze = false
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(text,height)
	SetTextFont(4)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5,height)
end

---------------------------------------------------------------------
local VehiclePolice = { -- veiculos autorizados a usar o radar 
	"wrsfuria",
	"wrspolmav",
	"wrstailgater",
	"tigerrocam",
	"dusterpmerj",
	"av-amarok",
	"amarokbopefechada",
	"caveiraopmerj",
	"amarokbopeaberta"
}

function IsVehiclePolice(veh)
	local model = GetEntityModel(veh)
	for i = 1, #VehiclePolice, 1 do
		if model == GetHashKey(VehiclePolice[i]) then
			return true
		end
	end
	return false
end
local sprayTimers = GetGameTimer()
---------------------------------------------------------------------------------------------
-- ThreadDisparos notify
----------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local player = GetPlayerPed(-1)
		if IsPedArmed(ped,6) and GetGameTimer() >= sprayTimers then
			
			if IsPedShooting(player) then
				sprayTimers = GetGameTimer() + 60000
				if not vSERVER.IsPolice() then

					vSERVER.notifyDisparo()
				end 	
			end
		end		
		Citizen.Wait(10)
	end	
end)