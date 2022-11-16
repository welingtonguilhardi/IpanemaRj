-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
vPLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("hud",cRP)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local voice = 1
local showHud = false
local talking = false
local clientStress = 0
local showMovie = false
local radioDisplay = ""
local pauseBreak = false
local clientHunger = 100
local clientThirst = 100
local saltyScreen = false
local homeInterior = false
local playerActive = true
local flexDirection = "Norte"
local updateFoods = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltSpeed = 0
local beltLock = false
local beltVelocity = vector3(0,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local divingMask = nil
local divingTank = nil
local clientOxigen = 100
local divingTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOCKVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
-- local clockHours = 18
-- local clockMinutes = 0
-- local weatherSync = "CLEAR"
-- local timeDate = GetGameTimer()

local hour = nil
local minute = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp:playerActive")
AddEventHandler("vrp:playerActive",function(user_id)
	playerActive = true
end)-----------------------------------------------------------------------------------------------------------------------------------------
-- SALTYSCREEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaltyChat_PluginStateChanged",function(statusScreen)
	if statusScreen <= 1 then
		if not saltyScreen then
			saltyScreen = true
			SendNUIMessage({ screen = saltyScreen })
		end
	else
		if saltyScreen then
			saltyScreen = false
			SendNUIMessage({ screen = saltyScreen })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			if divingMask ~= nil then
				if GetGameTimer() >= divingTimers then
					divingTimers = GetGameTimer() + 35000
					clientOxigen = clientOxigen - 1
					vRPS.clientOxigen()

					if clientOxigen <= 0 then
						ApplyDamageToPed(PlayerPedId(),50,false)
					end
				end
			end
		end

		Citizen.Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			local ped = PlayerPedId()
			if GetGameTimer() >= updateFoods and GetEntityHealth(ped) > 101 then
				updateFoods = GetGameTimer() + 90000
				clientThirst = clientThirst - 1
				clientHunger = clientHunger - 1
				TriggerEvent("statusHunger",clientHunger)
				TriggerEvent("statusThirst",clientThirst)
				vRPS.clientFoods()
			end
		end

		Citizen.Wait(30000)
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADGLOBAL
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		-- if GetGameTimer() >= timeDate then
-- 		-- 	timeDate = GetGameTimer() + 10000
-- 		-- 	clockMinutes = clockMinutes + 1

-- 		-- 	if clockMinutes >= 60 then
-- 		-- 		clockHours = clockHours + 1
-- 		-- 		clockMinutes = 0

-- 		-- 		if clockHours >= 24 then
-- 		-- 			clockHours = 0
-- 		-- 		end
-- 		-- 	end
-- 		-- end

-- 		Citizen.Wait(5000)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DisplayRadar(false)

	RequestStreamedTextureDict("circlemap",false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Citizen.Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics","radarmasksm","circlemap","radarmasksm")

	SetMinimapClipType(1)

	SetMinimapComponentPosition("minimap","L","B",0.0,0.0,0.158,0.28)
	SetMinimapComponentPosition("minimap_mask","L","B",0.155,0.12,0.080,0.164)
	SetMinimapComponentPosition("minimap_blur","L","B",-0.005,0.021,0.240,0.302)

	Citizen.Wait(5000)

	SetBigmapActive(true,false)

	Citizen.Wait(100)

	SetBigmapActive(false,false)
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADTIMERS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if homeInterior then
-- 			SetWeatherTypeNow("CLEAR")
-- 			SetWeatherTypePersist("CLEAR")
-- 			SetWeatherTypeNowPersist("CLEAR")
-- 			NetworkOverrideClockTime(00,00,00)
-- 		else
-- 			SetWeatherTypeNow(weatherSync)
-- 			SetWeatherTypePersist(weatherSync)
-- 			SetWeatherTypeNowPersist(weatherSync)
-- 			NetworkOverrideClockTime(clockHours,clockMinutes,00)
-- 		end

-- 		if beltLock then
-- 			DisableControlAction(1,75,true)
-- 		end

-- 		Citizen.Wait(0)
-- 	end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if beltLock then
			DisableControlAction(1,75,true)
		end
		Citizen.Wait(0)
	end
end)



-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- USERTALKING
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- AddEventHandler("SaltyChat_TalkStateChanged",function(status)
-- 	talking = status
-- end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({ progress = true, progressTimer = progressTimer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		talking = NetworkIsPlayerTalking(PlayerId())
		if playerActive then
			if IsPauseMenuActive() then
				SendNUIMessage({ hud = false })
				pauseBreak = true
			else
				if pauseBreak and showHud then
					SendNUIMessage({ hud = true })
					pauseBreak = false
				end
			end

			if showHud then
				updateDisplayHud()
			end
		end

		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHATASSALTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		hours = GetClockHours()
		minutes = GetClockMinutes()
		if hours == 22 and hours >= 5 and minutes == 0 then
			TriggerEvent('chatMessage',"ASSALTOS",{255,70,50},"ON")
		elseif hours == 6 and minutes == 0 then
			TriggerEvent('chatMessage',"ASSALTOS",{255,70,50},"OFF")
		end	

		Citizen.Wait(2000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function updateDisplayHud()
	local ped = PlayerPedId()
	local armour = GetPedArmour(ped)
	local coords = GetEntityCoords(ped)
	local heading = GetEntityHeading(ped)
	local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords["x"],coords["y"],coords["z"]))

	if heading >= 315 or heading < 45 then
		flexDirection = "Norte"
	elseif heading >= 45 and heading < 135 then
		flexDirection = "Oeste"
	elseif heading >= 135 and heading < 225 then
		flexDirection = "Sul"
	elseif heading >= 225 and heading < 315 then
		flexDirection = "Leste"
	end
	hours = GetClockHours()
	minutes = GetClockMinutes()
	if hours <= 9 then
		hours = "0"..hours
	end

	if minutes <= 9 then
		minutes = "0"..minutes
	end
	local horario = hours..":"..minutes
	
	

	if IsPedInAnyVehicle(ped) then
		if not IsMinimapRendering() then
			DisplayRadar(true)
		end
		vPLAYER.updateStress()
		local vehicle = GetVehiclePedIsUsing(ped)
		local fuel = GetVehicleFuelLevel(vehicle)
		local speed = GetEntitySpeed(vehicle) * 3.6
		local plate = GetVehicleNumberPlateText(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)

		local showBelt = true
		if GetVehicleClass(vehicle) == 8 or (GetVehicleClass(vehicle) >= 13 and GetVehicleClass(vehicle) <= 16) or GetVehicleClass(vehicle) == 21 then
			showBelt = false
		end

		SendNUIMessage({ vehicle = true, talking = talking, rpm = GetVehicleCurrentRpm(vehicle), engine = engine , stress = clientStress, health = GetEntityHealth(ped) - 100, armour = armour, street = streetName, direction = flexDirection, radio = radioDisplay, voice = voice, oxigen = clientOxigen, suit = divingMask, fuel = fuel, speed = speed, showbelt = showBelt, seatbelt = beltLock, hunger = clientHunger, thirst = clientThirst,time = horario })
	else
		if IsMinimapRendering() then
			DisplayRadar(false)
		end

		SendNUIMessage({ vehicle = false, talking = talking, health = GetEntityHealth(ped) - 100, armour = armour, street = streetName, stress = clientStress, direction = flexDirection, radio = radioDisplay, voice = voice, oxigen = clientOxigen, suit = divingMask, hunger = clientHunger, thirst = clientThirst,time = horario })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args)
	if exports["chat"]:statusChat() then
		showHud = not showHud

		updateDisplayHud()
		SendNUIMessage({ hud = showHud })

		if IsMinimapRendering() and not showHud then
			DisplayRadar(false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie",function(source,args)
	if exports["chat"]:statusChat() then
		showMovie = not showMovie

		updateDisplayHud()
		SendNUIMessage({ movie = showMovie })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
	showHood = not showHood

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,1)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end

	SendNUIMessage({ hood = showHood })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REMOVEHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:removeHood")
AddEventHandler("hud:removeHood",function()
	if showHood then
		showHood = false
		SendNUIMessage({ hood = showHood })
		SetPedComponentVariation(PlayerPedId(),1,0,0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusHunger")
AddEventHandler("statusHunger",function(number)
	clientHunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSTHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusThirst")
AddEventHandler("statusThirst",function(number)
	clientThirst = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSSTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusStress")
AddEventHandler("statusStress",function(number)
	clientStress = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusOxigen")
AddEventHandler("statusOxigen",function(number)
	clientOxigen = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:rechargeOxigen")
AddEventHandler("hud:rechargeOxigen",function()
	TriggerEvent("Notify","verde","Reabastecimento concluído.",3000)
	vRPS.rechargeOxigen()
	clientOxigen = 100
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudActived")
AddEventHandler("hudActived",function(status)
	showHud = status

	updateDisplayHud()

	SendNUIMessage({ hud = showHud })
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- HUD:VOICEMODE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("SaltyChat_VoiceRangeChanged")
-- AddEventHandler("SaltyChat_VoiceRangeChanged",function(_,status)
-- 	voice = status
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIODISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:RadioDisplay")
AddEventHandler("hud:RadioDisplay",function(number)
	if parseInt(number) <= 0 then
		radioDisplay = ""
	else
		radioDisplay = parseInt(number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOWARDPED
-----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
					timeDistance = 1

					local vehicle = GetVehiclePedIsUsing(ped)
					local speed = GetEntitySpeed(vehicle) * 3.6
					if speed ~= beltSpeed then
						if (beltSpeed - speed) >= 40 and not beltLock then
							local fowardVeh = fowardPed(ped)
							local coords = GetEntityCoords(ped)
							SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
							SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
							ApplyDamageToPed(ped,50,false)

							Citizen.Wait(1)

							SetPedToRagdoll(ped,5000,5000,0,0,0,0)
						end

						beltVelocity = GetEntityVelocity(vehicle)
						beltSpeed = speed
					end
				end
			else
				if beltSpeed ~= 0 then
					beltSpeed = 0
				end

				if beltLock then
					beltLock = false
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt",function(source,args)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		if not IsPedOnAnyBike(ped) then
			if beltLock then
				TriggerEvent("sounds:source","unbelt",0.5)
				beltLock = false
			else
				TriggerEvent("sounds:source","belt",0.5)
				beltLock = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","g")
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- HUD:SYNCTIMERS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("hud:syncTimers")
-- AddEventHandler("hud:syncTimers",function(timer)
-- 	clockHours = parseInt(timer[2])
-- 	clockMinutes = parseInt(timer[1])
-- 	weatherSync = timer[3]
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES:HOURS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:Hours")
AddEventHandler("homes:Hours",function(status)
	homeInterior = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local foodTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= foodTimers and playerActive then
			foodTimers = GetGameTimer() + 10000

			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				if clientHunger >= 10 and clientHunger <= 20 then
					ApplyDamageToPed(ped,1,false)
					TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
				elseif clientHunger <= 9 then
					ApplyDamageToPed(ped,2,false)
					TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
				end

				if clientThirst >= 10 and clientThirst <= 20 then
					ApplyDamageToPed(ped,1,false)
					TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
				elseif clientThirst <= 9 then
					ApplyDamageToPed(ped,2,false)
					TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHAKESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if playerActive then
			local ped = PlayerPedId()
			local health = GetEntityHealth(ped)

			if health > 101 then
				if clientStress >= 99 then
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.75)
				elseif clientStress >= 80 and clientStress <= 98 then
					timeDistance = 9990
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.50)
				elseif clientStress >= 60 and clientStress <= 79 then
					timeDistance = 7500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.25)
				elseif clientStress >= 40 and clientStress <= 59 then
					timeDistance = 9990
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVESCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:removeScuba")
AddEventHandler("hud:removeScuba",function()
	local ped = PlayerPedId()
	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SETDIVING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:setDiving")
AddEventHandler("hud:setDiving",function()
	local ped = PlayerPedId()

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	else
		local coords = GetEntityCoords(ped)
		local maskModel = GetHashKey("p_s_scuba_mask_s")
		local tankModel = GetHashKey("p_s_scuba_tank_s")

		RequestModel(tankModel)
		while not HasModelLoaded(tankModel) do
			Citizen.Wait(1)
		end

		RequestModel(maskModel)
		while not HasModelLoaded(maskModel) do
			Citizen.Wait(1)
		end

		if HasModelLoaded(tankModel) then
			divingTank = CreateObject(tankModel,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(divingTank)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingTank,true,false)
			SetEntityInvincible(divingTank,true)

			AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(tankModel)
		end

		if HasModelLoaded(maskModel) then
			divingMask = CreateObject(maskModel,coords["x"],coords["y"],coords["z"],true,true,false)
			local netObjs = ObjToNet(divingMask)

			SetNetworkIdCanMigrate(netObjs,true)

			SetEntityAsMissionEntity(divingMask,true,false)
			SetEntityInvincible(divingMask,true)

			AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)

			SetModelAsNoLongerNeeded(maskModel)
		end

		SetEnableScuba(ped,true)
		SetPedMaxTimeUnderwater(ped,2000.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXAUSTS
-----------------------------------------------------------------------------------------------------------------------------------------
local exausts = {
	"exhaust","exhaust_2","exhaust_3","exhaust_4","exhaust_5","exhaust_6","exhaust_7","exhaust_8",
	"exhaust_9","exhaust_10","exhaust_11","exhaust_12","exhaust_13","exhaust_14","exhaust_15","exhaust_16"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIREEXAUST
-----------------------------------------------------------------------------------------------------------------------------------------
function fireExaust(vehicle)
	for k, v in ipairs(exausts) do
		local exaustNumber = GetEntityBoneIndexByName(vehicle,v)

		if exaustNumber > -1 then
			UseParticleFxAssetNextCall("core")
			local exaust = GetWorldPositionOfEntityBone(vehicle,exaustNumber)
			local exaustBone = GetOffsetFromEntityGivenWorldCoords(vehicle,exaust)
			StartParticleFxNonLoopedOnEntity("veh_backfire",vehicle,exaustBone,0.0,0.0,0.0,1.25,false,false,false)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENTOS
---------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("pma-voice:setTalkingMode")
RegisterNetEvent("pma-voice:setTalking")
AddEventHandler("pma-voice:setTalkingMode", function(_mode) voice = _mode end)
AddEventHandler("pma-voice:setTalking", function(_mode) talking = _mode end)