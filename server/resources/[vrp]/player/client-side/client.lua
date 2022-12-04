-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vGARAGE = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("player",cRP)
vSERVER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockCommands = false
RegisterNetEvent("player:blockCommands")
AddEventHandler("player:blockCommands",function(status)
	blockCommands = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKS
-----------------------------------------------------------------------------------------------------------------------------------------
function blocks()
	return blockCommands
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCOMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("blockCommands",blocks)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,0) == ped then
				if not GetIsTaskActive(ped,164) and GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,veh,0)
					SetPedConfigFlag(ped,184,true)
					SetVehicleCloseDoorDeferedAction(veh,0)
				end
			end
		end

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		SetPlayerHealthRechargeLimit(PlayerId(),0)

		if GetEntityMaxHealth(PlayerPedId()) ~= 200 then
			SetEntityMaxHealth(PlayerPedId(),200)
			SetPedMaxHealth(PlayerPedId(),200)
		end

		Citizen.Wait(100)
	end
end)
----------------------------------------------------------------------------------
--LIMITA VELOCIDADE DE TODOS VEICUOS
--------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local speed = GetEntitySpeed(vehicle)
            if ( ped ) then
                if math.floor(speed*3.6) == 299 then --Velocidade limitada em 250
                    cruise = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                    SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cruise)
                end
            end
        end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMADEATH
-----------------------------------------------------------------------------------------------------------------------------------------
local dX,dY,dZ = 294.78,-1351.17,24.54
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(dX,dY,dZ))
			if distance <= 2.5 then
				timeDistance = 4
				DrawText3D(dX,dY,dZ,"~r~E~w~  COMETER SUICÍDIO")
				DrawMarker(23,dX,dY,dZ-0.98,0,0,0,0,0,0,5.0,5.0,1.0,255,0,0,25,0,0,0,0)
				if IsControlJustPressed(1,38) then
					vSERVER.deleteChar()
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30*60000)
		TriggerServerEvent("player:salary")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent("cancelando")
AddEventHandler("cancelando",function(status)
	cancelando = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCANCELANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if cancelando then
			timeDistance = 4
			DisableControlAction(1,73,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,137,true)
			DisableControlAction(1,37,true)
			DisableControlAction(1,38,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSME
-----------------------------------------------------------------------------------------------------------------------------------------
local showMe = {}

RegisterNetEvent("player:showMe")
AddEventHandler("player:showMe",function(source,text)
	local pedSource = GetPlayerFromServerId(source)
	if pedSource ~= -1 then
		TriggerEvent("chatMessage","*Pensamento",{171,171,171},text.."*")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setDiving()
	local ped = PlayerPedId()
	if IsPedSwimming(ped) then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,8,15,0,1)
			SetPedPropIndex(ped,1,26,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,8,153,0,2)
			SetPedPropIndex(ped,1,28,0,2)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:REMOVEOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setRemoveoutfit()
	local ped = PlayerPedId()
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,1,-1,0,1)
			SetPedComponentVariation(ped,3,15,0,1)
			SetPedComponentVariation(ped,4,61,0,1)
			SetPedComponentVariation(ped,5,-1,0,1)
			SetPedComponentVariation(ped,6,34,0,1)
			SetPedComponentVariation(ped,7,-1,0,1)
			SetPedComponentVariation(ped,8,15,0,1)
			SetPedComponentVariation(ped,9,-1,0,1)
			SetPedComponentVariation(ped,10,-1,0,1)
			SetPedComponentVariation(ped,11,15,0,1)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,1,-1,0,1)
			SetPedComponentVariation(ped,3,15,0,1)
			SetPedComponentVariation(ped,4,17,0,1)
			SetPedComponentVariation(ped,5,-1,0,1)
			SetPedComponentVariation(ped,6,35,0,1)
			SetPedComponentVariation(ped,7,-1,0,1)
			SetPedComponentVariation(ped,8,7,0,1)
			SetPedComponentVariation(ped,9,-1,0,1)
			SetPedComponentVariation(ped,10,-1,0,1)
			SetPedComponentVariation(ped,11,18,0,1)
		end
end
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,0) == ped then
				if not GetIsTaskActive(ped,164) and GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,veh,0)
					SetPedConfigFlag(ped,184,true)
					SetVehicleCloseDoorDeferedAction(veh,0)
				end
			end
		end

		Citizen.Wait(100)
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- SETENERGETIC
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local energetic = 0
-- RegisterNetEvent("setEnergetic")
-- AddEventHandler("setEnergetic",function(timers,number)
-- 	energetic = energetic + timers
-- 	SetRunSprintMultiplierForPlayer(PlayerId(),number)
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if energetic > 0 then
-- 			RestorePlayerStamina(PlayerId(),1.0)
-- 		end

-- 		Citizen.Wait(1000)
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if energetic > 0 then
-- 			energetic = energetic - 1

-- 			if energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
-- 				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
-- 				energetic = 0
-- 			end
-- 		end

-- 		Citizen.Wait(1000)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETECSTASY
-----------------------------------------------------------------------------------------------------------------------------------------
local ecstasy = 0
RegisterNetEvent("setEcstasy")
AddEventHandler("setEcstasy",function()
	ecstasy = ecstasy + 10

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ecstasy > 0 then
			ecstasy = ecstasy - 1
			ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)

			if ecstasy <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ecstasy = 0

				TriggerServerEvent("upgradeStress",100)
				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMETH
-----------------------------------------------------------------------------------------------------------------------------------------
local methanfetamine = 0
RegisterNetEvent("setMeth")
AddEventHandler("setMeth",function()
	methanfetamine = methanfetamine + 30

	if not GetScreenEffectIsActive("DMT_flight") then
		StartScreenEffect("DMT_flight",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if methanfetamine > 0 then
			methanfetamine = methanfetamine - 1

			if methanfetamine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				methanfetamine = 0

				if GetScreenEffectIsActive("DMT_flight") then
					StopScreenEffect("DMT_flight")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
local cocaine = 0
RegisterNetEvent("setCocaine")
AddEventHandler("setCocaine",function()
	cocaine = cocaine + 30

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)

Citizen.CreateThread(function()
	while true do
		if cocaine > 0 then
			cocaine = cocaine - 1

			if cocaine <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				cocaine = 0

				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

-------------------- AGACHAR ----------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		
        local player = PlayerId()
        if agachar then 
            DisablePlayerFiring(player, true) ----------------- NÃO ATIRAR AGACHADO -------------------------
        end

        local ped = PlayerPedId()
        DisableControlAction(0,36,true)
		DisableControlAction(1,37,true) -- DESTIVA O TAB
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
        end
    end
end)

-- ----------------- NÃO ATIRAR AGACHADO -------------------------

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1)
--         local ped = PlayerPedId()
--         local player = PlayerId()
--         if agachar then 
--             DisablePlayerFiring(player, true)
--         end
--     end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleanEffectDrugs")
AddEventHandler("cleanEffectDrugs",function()
	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end

	if GetScreenEffectIsActive("DMT_flight") then
		StopScreenEffect("DMT_flight")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local drunkTime = 0
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime",function(timers)
	drunkTime = drunkTime + timers

	TriggerEvent("vrp:blockDrunk",true)
	RequestAnimSet("move_m@drunk@verydrunk")
	while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
		Citizen.Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",0.25)
end)

Citizen.CreateThread(function()
	while true do
		if drunkTime > 0 then
			drunkTime = drunkTime - 1

			if drunkTime <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ResetPedMovementClipset(PlayerPedId(),0.25)
				TriggerEvent("vrp:blockDrunk",false)
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOODOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncHoodOptions")
AddEventHandler("player:syncHoodOptions",function(vehIndex,options)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if options == "open" then
				SetVehicleDoorOpen(v,4,0,0)
			elseif options == "close" then
				SetVehicleDoorShut(v,4,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deleteVehicle")
AddEventHandler("player:deleteVehicle",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleNumberPlateText(v) == vehPlate then
			SetEntityAsMissionEntity(v,false,false)
			DeleteEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deleteObject")
AddEventHandler("player:deleteObject",function(entIndex)
	if NetworkDoesNetworkIdExist(entIndex) then
		local v = NetToEnt(entIndex)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,false,false)
			DeleteEntity(v)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORSOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoorsOptions")
AddEventHandler("player:syncDoorsOptions",function(vehIndex,options)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if options == "open" then
				SetVehicleDoorOpen(v,5,0,0)
			elseif options == "close" then
				SetVehicleDoorShut(v,5,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins",function(vehIndex,status)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			if status == "1" then
				RollUpWindow(v,0)
				RollUpWindow(v,1)
			else
				RollDownWindow(v,0)
				RollDownWindow(v,1)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(vehIndex,door)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) and GetVehicleDoorsLockedForPlayer(v,PlayerId()) ~= 1 then
			if door == "1" then
				if GetVehicleDoorAngleRatio(v,0) == 0 then
					SetVehicleDoorOpen(v,0,0,0)
				else
					SetVehicleDoorShut(v,0,0)
				end
			elseif door == "2" then
				if GetVehicleDoorAngleRatio(v,1) == 0 then
					SetVehicleDoorOpen(v,1,0,0)
				else
					SetVehicleDoorShut(v,1,0)
				end
			elseif door == "3" then
				if GetVehicleDoorAngleRatio(v,2) == 0 then
					SetVehicleDoorOpen(v,2,0,0)
				else
					SetVehicleDoorShut(v,2,0)
				end
			elseif door == "4" then
				if GetVehicleDoorAngleRatio(v,3) == 0 then
					SetVehicleDoorOpen(v,3,0,0)
				else
					SetVehicleDoorShut(v,3,0)
				end
			elseif door == "5" then
				if GetVehicleDoorAngleRatio(v,5) == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			elseif door == "6" then
				if GetVehicleDoorAngleRatio(v,4) == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
RegisterNetEvent("player:EnterTrunk")
AddEventHandler("player:EnterTrunk",function()
    local ped = PlayerPedId()

    if not inTrunk then
        local vehicle = vRP.vehList(11)
        if DoesEntityExist(vehicle) then
            local trunk = GetEntityBoneIndexByName(vehicle,"boot")
            if trunk ~= -1 then
                local coords = GetEntityCoords(ped)
                local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
                local distance = #(coords - coordsEnt)
                if distance <= 3.0 then
                    timeDistance = 4
                    if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
                        SetCarBootOpen(vehicle)
                        SetEntityVisible(ped,false,false)
                        Citizen.Wait(750)
                        AttachEntityToEntity(ped,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
                        inTrunk = true
                        Citizen.Wait(500)
                        SetVehicleDoorShut(vehicle,5)
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:CheckTrunk")
AddEventHandler("player:CheckTrunk",function()
    local ped = PlayerPedId()

        local vehicle = GetEntityAttachedTo(ped)
        if DoesEntityExist(vehicle) then
            SetCarBootOpen(vehicle)
            Citizen.Wait(750)
            inTrunk = false
            DetachEntity(ped,false,false)
            SetEntityVisible(ped,true,false)
            SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
            Citizen.Wait(500)
            SetVehicleDoorShut(vehicle,5)
        end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local ped = PlayerPedId()
        local timeDistance = 500

        if inTrunk then
            local ped = PlayerPedId()
            local vehicle = GetEntityAttachedTo(ped)
            if DoesEntityExist(vehicle) then
                timeDistance = 4

                DisableControlAction(1,73,true)
                DisableControlAction(1,29,true)
                DisableControlAction(1,47,true)
                DisableControlAction(1,187,true)
                DisableControlAction(1,189,true)
                DisableControlAction(1,190,true)
                DisableControlAction(1,188,true)
                DisableControlAction(1,311,true)
                DisableControlAction(1,245,true)
                DisableControlAction(1,257,true)
                --DisableControlAction(1,167,true)
                DisableControlAction(1,140,true)
                DisableControlAction(1,141,true)
                DisableControlAction(1,142,true)
                DisableControlAction(1,137,true)
                DisableControlAction(1,37,true)
                DisablePlayerFiring(ped,true)

                if IsEntityVisible(ped) then
                    SetEntityVisible(ped,false,false)
                end

                if IsControlJustPressed(1,167) then
                    SetCarBootOpen(vehicle)
                    Citizen.Wait(750)
                    inTrunk = false
                    DetachEntity(ped,false,false)
                    SetEntityVisible(ped,true,false)
                    SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
                    Citizen.Wait(500)
                    SetVehicleDoorShut(vehicle,5)
                end
            else
                inTrunk = false
                DetachEntity(ped,false,false)
                SetEntityVisible(ped,true,false)
                SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
	if args[1] == "on" then
		SetTimecycleModifier("cinema")
		TriggerEvent("Notify","amarelo","Gráficos otimizados.",3000)
	elseif args[1] == "off" then
		ClearTimecycleModifier()
		TriggerEvent("Notify","vermelho","Gráficos normalizados.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(vehIndex)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		if vehIndex == "0" then
			if IsVehicleSeatFree(vehicle,-1) then
				SetPedIntoVehicle(ped,vehicle,-1)
			end
		else
			if IsVehicleSeatFree(vehicle,parseInt(vehIndex - 1)) then
				SetPedIntoVehicle(ped,vehicle,parseInt(vehIndex - 1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local handcuff = false
function cRP.toggleHandcuff()
	if not handcuff then
		handcuff = true
		TriggerEvent("radio:outServers")
	else
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeHandcuff()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getHandcuff()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function handcuffs()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
exports("handCuff",handcuffs)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetHandcuff")
AddEventHandler("resetHandcuff",function()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindcuff",function(source,args)
	vSERVER.cuffToggle()
end)
RegisterKeyMapping("keybindcuff","Algemar o Cidadao","keyboard","g")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindcarry",function(source,args)
	vSERVER.carryToggle()
end)
RegisterKeyMapping("keybindcarry","Carregar o Cidadao","keyboard","h")
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEMENTCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.movementClip(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do
		Citizen.Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(),dict,0.25)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if handcuff then
			timeDistance = 4
			DisableControlAction(1,21,true)
			DisableControlAction(1,23,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,73,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,182,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,243,true)
			DisableControlAction(1,105,true)
			DisablePlayerFiring(PlayerPedId(),true)
			
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYROPE
-----------------------------------------------------------------------------------------------------------------------------------------
local startRope = false
RegisterNetEvent("player:applyRope")
AddEventHandler("player:applyRope",function(status)
	startRope = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if handcuff and GetEntityHealth(ped) > 101 and not startRope then
			if not IsEntityPlayingAnim(ped,"mp_arresting","idle",3) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Citizen.Wait(1)
				end

				TaskPlayAnim(ped,"mp_arresting","idle",3.0,3.0,-1,49,0,0,0,0)
				timeDistance = 4
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- SHOTDISTANCE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local losSantos = PolyZone:Create({
-- 	vector2(-2153.08,-3131.33),
-- 	vector2(-1581.58,-2092.38),
-- 	vector2(-3271.05,275.85),
-- 	vector2(-3460.83,967.42),
-- 	vector2(-3202.39,1555.39),
-- 	vector2(-1642.50,993.32),
-- 	vector2(312.95,1054.66),
-- 	vector2(1313.70,341.94),
-- 	vector2(1739.01,-1280.58),
-- 	vector2(1427.42,-3440.38),
-- 	vector2(-737.90,-3773.97)
-- },{ name="santos" })

-- local sandyShores = PolyZone:Create({
-- 	vector2(-375.38,2910.14),
-- 	vector2(307.66,3664.47),
-- 	vector2(2329.64,4128.52),
-- 	vector2(2349.93,4578.50),
-- 	vector2(1680.57,4462.48),
-- 	vector2(1570.01,4961.27),
-- 	vector2(1967.55,5203.67),
-- 	vector2(2387.14,5273.98),
-- 	vector2(2735.26,4392.21),
-- 	vector2(2512.33,3711.16),
-- 	vector2(1681.79,3387.82),
-- 	vector2(258.85,2920.16)
-- },{ name="sandy" })

-- local paletoBay = PolyZone:Create({
-- 	vector2(-529.40,5755.14),
-- 	vector2(-234.39,5978.46),
-- 	vector2(278.16,6381.84),
-- 	vector2(672.67,6434.39),
-- 	vector2(699.56,6877.77),
-- 	vector2(256.59,7058.49),
-- 	vector2(17.64,7054.53),
-- 	vector2(-489.45,6449.50),
-- 	vector2(-717.59,6030.94)
-- },{ name="paleto" })
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADSHOTSFIRED
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local coolTimers = 0
-- local residual = false
-- local policeService = false
-- local sprayTimers = GetGameTimer()
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADSHOT
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		local timeDistance = 500
-- 		local ped = PlayerPedId()
-- 		if IsPedArmed(ped,6) and GetGameTimer() >= (sprayTimers + 60000) and GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_MUSKET") then
-- 			timeDistance = 4

-- 			if IsPedShooting(ped) then
-- 				sprayTimers = GetGameTimer()
-- 				residual = true
-- 				coolTimers = 3

-- 				local coords = GetEntityCoords(ped)
-- 				if (losSantos:isPointInside(coords) or sandyShores:isPointInside(coords) or paletoBay:isPointInside(coords)) and not policeService then
-- 					vSERVER.shotsFired()
-- 				end
-- 			end
-- 		end

-- 		Citizen.Wait(timeDistance)
-- 	end
-- end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADDISABLECTRL
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		local timeDistance = 500
-- 		if coolTimers > 0 then
-- 			timeDistance = 4
-- 			DisableControlAction(1,36,true)
-- 		end

-- 		Citizen.Wait(timeDistance)
-- 	end
-- end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- COOLTIMERS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		if coolTimers > 0 then
-- 			coolTimers = coolTimers - 1
-- 		end

-- 		Citizen.Wait(1000)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKESHOTTING
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and IsPedArmed(ped,6) then
			timeDistance = 4

			if IsPedShooting(ped) then
				ShakeGameplayCam("SMALL_EXPLOSION_SHAKE",0.10)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYGSR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:applyGsr")
AddEventHandler("player:applyGsr",function()
	residual = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.gsrCheck()
	return residual
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkSoap()
	local ped = PlayerPedId()
	if IsEntityInWater(ped) and residual then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANRESIDUAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.cleanResidual()
	residual = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function cRP.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeVehicle()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		if iCarry then
			iCarry = false
			DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
		end

		TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),4160)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:SPAWNSEAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:spawnSeat")
AddEventHandler("player:spawnSeat",function(vehIndex)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			SetPedIntoVehicle(PlayerPedId(),v,-1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putVehicle(vehIndex)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local v = NetToEnt(vehIndex)
		if DoesEntityExist(v) then
			local vehSeats = 5
			local ped = PlayerPedId()

			repeat
				vehSeats = vehSeats - 1

				if IsVehicleSeatFree(v,vehSeats) then
					ClearPedTasks(ped)
					ClearPedSecondaryTask(ped)
					SetPedIntoVehicle(ped,v,vehSeats)

					if iCarry then
						iCarry = false
						DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
					end

					vehSeats = true
				end
			until vehSeats == true or vehSeats == 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleLivery(number)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		SetVehicleLivery(GetVehiclePedIsUsing(ped),number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blackWeapons = {
	"WEAPON_UNARMED",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_STUNGUN",
	"GADGET_PARACHUTE",
	"WEAPON_PETROLCAN",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_BAT",
	"WEAPON_BATTLEAXE",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_DAGGER",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_MACHETE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_SWITCHBLADE",
	"WEAPON_WRENCH",
	"WEAPON_KNUCKLE"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local shotDistance = {
	{ -186.1,-893.5,29.3,2500 },
	{ 1389.7,3237.2,37.6,1300 },
	{ -137.4,6228.4,31.2,1000 }
}

function cRP.shotDistance(x,y,z)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(shotDistance) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= v[4] then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function cRP.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end	
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRYCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local sCarry = nil
local eCarry = false
local bCarry = false
function cRP.CarryCuff(source)
	sCarry = source
	eCarry = not eCarry

	local ped = PlayerPedId()
	if eCarry and sCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(sCarry)),4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		bCarry = true
	else
		if bCarry then
			DetachEntity(ped,false,false)
			bCarry = false
		end
	end	
end








-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		iCarry = false
		DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
		TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),4160)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.extraVehicle(data)
	local vehicle = vRP.getNearVehicle(11)
	if data == "1" then
		if DoesExtraExist(vehicle,1) then
			if IsVehicleExtraTurnedOn(vehicle,1) then
				SetVehicleExtra(vehicle,1,true)
			else
				SetVehicleExtra(vehicle,1,false)
			end
		end
	elseif data == "2" then
		if DoesExtraExist(vehicle,2) then
			if IsVehicleExtraTurnedOn(vehicle,2) then
				SetVehicleExtra(vehicle,2,true)
			else
				SetVehicleExtra(vehicle,2,false)
			end
		end
	elseif data == "3" then
		if DoesExtraExist(vehicle,3) then
			if IsVehicleExtraTurnedOn(vehicle,3) then
				SetVehicleExtra(vehicle,3,true)
			else
				SetVehicleExtra(vehicle,3,false)
			end
		end
	elseif data == "4" then
		if DoesExtraExist(vehicle,4) then
			if IsVehicleExtraTurnedOn(vehicle,4) then
				SetVehicleExtra(vehicle,4,true)
			else
				SetVehicleExtra(vehicle,4,false)
			end
		end
	elseif data == "5" then
		if DoesExtraExist(vehicle,5) then
			if IsVehicleExtraTurnedOn(vehicle,5) then
				SetVehicleExtra(vehicle,5,true)
			else
				SetVehicleExtra(vehicle,5,false)
			end
		end
	elseif data == "6" then
		if DoesExtraExist(vehicle,6) then
			if IsVehicleExtraTurnedOn(vehicle,6) then
				SetVehicleExtra(vehicle,6,true)
			else
				SetVehicleExtra(vehicle,6,false)
			end
		end
	elseif data == "7" then
		if DoesExtraExist(vehicle,7) then
			if IsVehicleExtraTurnedOn(vehicle,7) then
				SetVehicleExtra(vehicle,7,true)
			else
				SetVehicleExtra(vehicle,7,false)
			end
		end
	elseif data == "8" then
		if DoesExtraExist(vehicle,8) then
			if IsVehicleExtraTurnedOn(vehicle,8) then
				SetVehicleExtra(vehicle,8,true)
			else
				SetVehicleExtra(vehicle,8,false)
			end
		end
	elseif data == "9" then
		if DoesExtraExist(vehicle,9) then
			if IsVehicleExtraTurnedOn(vehicle,9) then
				SetVehicleExtra(vehicle,9,true)
			else
				SetVehicleExtra(vehicle,9,false)
			end
		end
	elseif data == "10" then
		if DoesExtraExist(vehicle,10) then
			if IsVehicleExtraTurnedOn(vehicle,10) then
				SetVehicleExtra(vehicle,10,true)
			else
				SetVehicleExtra(vehicle,10,false)
			end
		end
	elseif data == "11" then
		if DoesExtraExist(vehicle,11) then
			if IsVehicleExtraTurnedOn(vehicle,11) then
				SetVehicleExtra(vehicle,11,true)
			else
				SetVehicleExtra(vehicle,11,false)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putVehicle(seat)
	local veh = vRP.getNearVehicle(11)
	if IsEntityAVehicle(veh) then
		if parseInt(seat) <= 1 or seat == nil then
			seat = -1
		elseif parseInt(seat) == 2 then
			seat = 0
		elseif parseInt(seat) == 3 then
			seat = 1
		elseif parseInt(seat) == 4 then
			seat = 2
		elseif parseInt(seat) == 5 then
			seat = 3
		elseif parseInt(seat) == 6 then
			seat = 4
		elseif parseInt(seat) == 7 then
			seat = 5
		elseif parseInt(seat) >= 8 then
			seat = 6
		end

		local ped = PlayerPedId()
		if IsVehicleSeatFree(veh,seat) then
			ClearPedTasks(ped)
			ClearPedSecondaryTask(ped)
			SetPedIntoVehicle(ped,veh,seat)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOLSTER
-----------------------------------------------------------------------------------------------------------------------------------------
local weapons = {
	"WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB",  
    "WEAPON_CROWBAR", "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50",  
    "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE",  
    "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN",  
    "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE",  
    "WEAPON_HEAVYSNIPER", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN",  
    "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV",  
    "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_FLARE", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE",  
    "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL",  
    "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE",  
    "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_RAILGUN", "WEAPON_COMBATPDW",  
    "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_FLASHLIGHT", "WEAPON_MACHETE", "WEAPON_MACHINEPISTOL",  
    "WEAPON_SWITCHBLADE", "WEAPON_REVOLVER", "WEAPON_COMPACTRIFLE", "WEAPON_DBSHOTGUN", "WEAPON_FLAREGUN",  
    "WEAPON_AUTOSHOTGUN", "WEAPON_BATTLEAXE", "WEAPON_COMPACTLAUNCHER", "WEAPON_MINISMG", "WEAPON_PIPEBOMB",  
	"WEAPON_POOLCUE", "WEAPON_SWEEPER", "WEAPON_WRENCH", "WEAPON_PISTOL_MK2", "WEAPON_SNSPISTOL_MK2", 
	"WEAPON_REVOLVER_MK2", "WEAPON_SMG_MK2", "WEAPON_PUMPSHOTGUN_MK2", "WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE_MK2", "WEAPON_SPECIALCARBINE_MK2", "WEAPON_BULLPUPRIFLE_MK2", "WEAPON_COMBATMG_MK2",
	"WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE_MK2"
}

local holster = false
local holsterWeapon = nil
Citizen.CreateThread(function()
	while true do
		local timeDistance = 200
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetEntityHealth(ped) > 101 and GetVehiclePedIsTryingToEnter(ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
				local checkWeapon,lastWeapon = CheckWeapon(ped)

				if lastWeapon ~= nil then
					holsterWeapon = lastWeapon
				end

				if checkWeapon then
					if not holster then
						timeDistance = 4

						if not IsEntityPlayingAnim(ped,"rcmjosh4","josh_leadout_cop2",3) then
							SetPedCurrentWeaponVisible(ped,0,0,1,1)
							loadAnimDict("rcmjosh4")
							TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)
							Citizen.Wait(200)
							SetPedCurrentWeaponVisible(ped, 1, 0, 1, 1)
							Citizen.Wait(300)
							ClearPedTasks(ped)
						end
						holster = true
					end
				elseif not checkWeapon then
					if holster then
						timeDistance = 4

						if not IsEntityPlayingAnim(ped,"weapons@pistol@","aim_2_holster",3) then
							loadAnimDict("weapons@pistol@")
							SetCurrentPedWeapon(ped,GetHashKey(holsterWeapon),true)
							TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)
							Citizen.Wait(450)
							SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
							ClearPedTasks(ped)
						end
						holster = false
					end
				end
			end
		end

		if GetEntityHealth(ped) <= 101 and holster then
			holster = false
			SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
		end

		Citizen.Wait(timeDistance)
	end
end)

function CheckWeapon(ped)
	for i = 1,#weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true,weapons[i]
		end
	end
	return false,nil
end


function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,args)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped and not IsEntityInAir(veh) then
				local speed = GetEntitySpeed(veh) * 2.236936

				if speed >= 0 then
					if args[1] == nil then
						SetEntityMaxSpeed(veh,GetVehicleEstimatedMaxSpeed(veh))
						TriggerEvent("Notify","amarelo","Controle de cruzeiro desativado.",3000)
					else
						if parseInt(args[1]) > 0 then
							SetEntityMaxSpeed(veh,0.45*args[1])
							TriggerEvent("Notify","verde","Controle de cruzeiro ativado.",3000)
						end
					end
				end
			end
		end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
local disService = {
	{ 1146.9,-1542.8,35.39,"Paramedic" },
	{ -198.22,-1317.91,31.09,"Mechanic" },
	{ -920.39,-2034.7,9.41,138.57,"Police" }, -- Centro
	{ 1852.95,3686.46,34.23,"Police" } -- Norte
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISTANCESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.distanceService()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(disService) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 15 then
			return true,v[4]
		end
	end
	return false,nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.weColors(number)
	local ped = PlayerPedId()
	local weapon = GetSelectedPedWeapon(ped)
	SetPedWeaponTintIndex(ped,weapon,parseInt(number))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
local wLux = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_PISTOL_VARMOD_LUXE"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_APPISTOL_VARMOD_LUXE"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_HEAVYPISTOL_VARMOD_LUXE"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_MICROSMG_VARMOD_LUXE"
	},
	["WEAPON_SNSPISTOL"] = {
		"COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_PISTOL50_VARMOD_LUXE"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_CARBINERIFLE_VARMOD_LUXE"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		"COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_SMG_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.weLux()
	local ped = PlayerPedId()
	for k,v in pairs(wLux) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAM
-----------------------------------------------------------------------------------------------------------------------------------------
local inCamera = false
local camSelect = nil
local coords = nil
local cameras = {
	["1"] = { 433.72,-978.4,34.71,112.67 },
	["2"] = { 424.59,-996.6,34.72,119.06 },
	["3"] = { 438.16,-999.32,33.72,192.76 },
	["4"] = { 148.99,-1036.29,32.34,306.15 },
	["5"] = { 1171.59,-1499.12,40.85,138.9 },
	["6"] = { 1145.03,-1529.39,37.38,144.57 },
	["7"] = { 73.09,-964.68,35.35,133.23 }
}

RegisterNetEvent("player:serviceCamera")
AddEventHandler("player:serviceCamera",function(num)
	local ped = PlayerPedId()

	if not IsPedInAnyVehicle(ped) then
		if inCamera then
			ClearTimecycleModifier()
			DestroyCam(camSelect,false)
			SetEntityInvincible(ped,false)
			SetEntityVisible(ped,true,false)
			SetEntityCoords(ped,coords,1,0,0,0)
			FreezeEntityPosition(ped,false)
			TriggerEvent("hudActived",true)
			RenderScriptCams(false,false,0,1,0)
			PlaySoundFrontend(-1,"HACKING_SUCCESS",false)

			inCamera = false
			camSelect = nil
		else
			if cameras[num] then
				inCamera = true
				coords = GetEntityCoords(ped)
				SetEntityInvincible(ped,true)
				SetEntityVisible(ped,false,false)
				SetEntityCoords(ped,cameras[num][1],cameras[num][2],cameras[num][3],1,0,0,0)
				FreezeEntityPosition(ped,true)
				TriggerEvent("hudActived",false)
				SetTimecycleModifier("heliGunCam")
				PlaySoundFrontend(-1,"HACKING_SUCCESS",false)
				camSelect = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
				SetCamCoord(camSelect,cameras[num][1],cameras[num][2],cameras[num][3])
				SetCamRot(camSelect,-20.0,0.0,cameras[num][4])
				RenderScriptCams(true,false,0,1,0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
	if name == "CEventNetworkEntityDamage" then
		if (GetEntityHealth(args[1]) <= 101 and PlayerPedId() == args[2] and IsPedAPlayer(args[1])) then
			local index = NetworkGetPlayerIndexFromPed(args[1])
			local source = GetPlayerServerId(index)
			TriggerServerEvent("player:deathLogs",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:toggleExtras")
AddEventHandler("player:toggleExtras",function(index,extra)
	if NetworkDoesNetworkIdExist(index) then
		local vehicle = NetToEnt(index)
		if DoesEntityExist(vehicle) then
			local engine = GetVehicleEngineHealth(vehicle)
			local body = GetVehicleBodyHealth(vehicle)
			local fuel = GetVehicleFuelLevel(vehicle)
			local vehWindows = {}
			local vehTyres = {}
			local vehDoors = {}

			for i = 0,7 do
				local tyre_state = 2
				if IsVehicleTyreBurst(vehicle,i,true) then
					tyre_state = 1
				elseif IsVehicleTyreBurst(vehicle,i,false) then
					tyre_state = 0
				end
				vehTyres[i] = tyre_state
			end

			for i = 0,5 do
				vehDoors[i] = IsVehicleDoorDamaged(vehicle,i)
			end

			for i = 0,5 do
				vehWindows[i] = IsVehicleWindowIntact(vehicle,i)
			end

			if extra == "on" then
				for i = 0,12 do
					if DoesExtraExist(vehicle,i) then
						SetVehicleExtra(vehicle,i,false)
					end
				end
			elseif extra == "off" then
				for i = 0,12 do
					if DoesExtraExist(vehicle,i) then
						SetVehicleExtra(vehicle,i,true)
					end
				end
			else
				if IsVehicleExtraTurnedOn(vehicle,parseInt(extra)) then
					SetVehicleExtra(vehicle,parseInt(extra),true)
				else
					SetVehicleExtra(vehicle,parseInt(extra),false)
				end
			end

			SetVehicleEngineHealth(vehicle,engine)
			SetVehicleBodyHealth(vehicle,body)
			SetVehicleFuelLevel(vehicle,fuel)

			for k,v in pairs(vehTyres) do
				if v < 2 then
					SetVehicleTyreBurst(vehicle,k,(v == 1),1000.0)
				end
			end

			for k,v in pairs(vehWindows) do
				if not v then
					SmashVehicleWindow(vehicle,k)
				end
			end

			for k,v in pairs(vehDoors) do
				if v then
					SetVehicleDoorBroken(vehicle,k,v)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MERCOSULPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
imageUrl = "nui://player/web-side/images/mercosul.png"

local textureDic = CreateRuntimeTxd('duiTxd')
local object = CreateDui(imageUrl, 540, 300)
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex", handle)
AddReplaceTexture('vehshare', 'plate01', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate02', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate03', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate04', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate05', 'duiTxd', 'duiTex')


local object = CreateDui('nui://player/web-side/images/plate.png', 540, 300)
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex2", handle)
AddReplaceTexture('vehshare', 'plate01_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate02_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate03_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate04_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate05_n', 'duiTxd', 'duiTex2')

------------------------------------------------------------------------------
	-- DANO POR OSSO + RECOIL CONFIG
	------------------------------------------------------------------------------
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(500)
			
			-- if IsPedShooting(PlayerPedId()) then
			-- 	local wep = GetSelectedPedWeapon(PlayerPedId())
			-- 	if recoil[wep] and recoil[wep] ~= 0 then
			-- 		Wait(0)
			-- 		p = GetGameplayCamRelativePitch()
			-- 		if not IsPedInAnyHeli(PlayerPedId()) then
			-- 			SetGameplayCamRelativePitch(p+recoil[wep], 1.2)
			-- 		end
			-- 	end
			-- end
			local headshotFive = HasPedBeenDamagedByWeapon(PlayerPedId(), -1075685676, 0) -- Pistol
			local headshotGlock = HasPedBeenDamagedByWeapon(PlayerPedId(), 1593441988, 0) -- Pistol
			local headshotFajuta = HasPedBeenDamagedByWeapon(PlayerPedId(), -1076751822, 0) -- Pistol
			local headshotPesada = HasPedBeenDamagedByWeapon(PlayerPedId(), 3523564046, 0) -- Pistol

			local headshotTec = HasPedBeenDamagedByWeapon(PlayerPedId(), -619010992, 0) -- SMG
			local headshotSmg = HasPedBeenDamagedByWeapon(PlayerPedId(), 736523883, 0) -- SMG
			local headshotSmg2 = HasPedBeenDamagedByWeapon(PlayerPedId(), 2024373456, 0) -- SMG
			local headshotMtar = HasPedBeenDamagedByWeapon(PlayerPedId(), 3675956304, 0) -- SMG
			local headshotSig = HasPedBeenDamagedByWeapon(PlayerPedId(), 171789620, 0) -- SMG

			local headshotAK = HasPedBeenDamagedByWeapon(PlayerPedId(), 3220176749, 0) -- Fuzil
			local headshotAK2 = HasPedBeenDamagedByWeapon(PlayerPedId(), 961495388, 0) -- Fuzil
			local headshotM4 = HasPedBeenDamagedByWeapon(PlayerPedId(), -2084633992, 0) -- Fuzil
			local headshotMPX = HasPedBeenDamagedByWeapon(PlayerPedId(), -86904375, 0) -- Fuzil
			local headshotG3 = HasPedBeenDamagedByWeapon(PlayerPedId(), -1063057011, 0) -- Fuzil
			local headshotG32 = HasPedBeenDamagedByWeapon(PlayerPedId(), -1768145561, 0) -- Fuzil

			local headshot12 = HasPedBeenDamagedByWeapon(PlayerPedId(), 487013001, 0) -- 12
			local headshotMini12 = HasPedBeenDamagedByWeapon(PlayerPedId(), 2017895192, 0) -- 12
			local a, b = GetPedLastDamageBone(PlayerPedId())
			if a and b == 31086 then
				if headshotFive or headshotGlock or headshotFajuta or headshotPesada or headshotSmg or headshotSmg2 or headshotMtar or headshotSig or headshotTec then
					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 101)
				elseif headshotAK or headshotAK2 or headshotM4 or headshotMPX or headshotG3 or headshotG32 or headshot12 or headshotMini12 then
					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 101)
				end
				a, b, headshotFive, headshotGlock, headshotFajuta, headshotPesada, headshotTec, headshotSmg, headshotSmg2, headshotMtar, headshotSig, headshotAK, headshotAK2, headshotM4, headshotMPX, headshotG3, headshotG32, headshot12, headshotMini12 = nil, nil, nil, nil, nil, nil
			end
			--Citizen.Wait(1000)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			local sleep = 100
			if IsPedArmed(PlayerPedId(),6) then
				sleep = 4
				DisableControlAction(1,140,true)
				DisableControlAction(1,141,true)
				DisableControlAction(1,142,true)
			end
			Citizen.Wait(sleep)
		end
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AIM REMOVE PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local bool,hash = GetCurrentPedWeapon(ped,1)
		local weapongroup = GetWeapontypeGroup(hash)
		if bool and weapongroup ~= -728555052 then
			SetPlayerLockon(PlayerId(),false)
		else
			SetPlayerLockon(PlayerId(),true)
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	AddTextEntry("FE_THDR_GTAO","XAMA INFINITY")
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("PoliceScannerDisabled",true)
	SetTimecycleModifier('downtown_FIB_cascades_opt')
	while true do
		N_0xf4f2c0d4ee209e20()
		SetPlayerTargetingMode(3)
		-- HideHudComponentThisFrame(1)
		-- HideHudComponentThisFrame(2)
		-- HideHudComponentThisFrame(3)
		-- HideHudComponentThisFrame(4)
		-- HideHudComponentThisFrame(5)
		-- HideHudComponentThisFrame(6)
		-- HideHudComponentThisFrame(7)
		-- HideHudComponentThisFrame(8)
		-- HideHudComponentThisFrame(9)
		-- HideHudComponentThisFrame(11)
		-- HideHudComponentThisFrame(12)
		-- HideHudComponentThisFrame(13)
		-- HideHudComponentThisFrame(20)

		SetRandomBoats(false)
		SetGarbageTrucks(false)
		ForceAmbientSiren(false)
		SetCreateRandomCops(false)
		DisableVehicleDistantlights(true)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		SetPedHelmet(PlayerPedId(),false)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedSuffersCriticalHits(PlayerPedId(),true)
		SetPedInfiniteAmmo(PlayerPedId(),true,"WEAPON_FIREEXTINGUISHER")

		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"),0.1) -- DANO DO SOCO
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"),0.3) -- DANO Da faca
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"),0.0) -- DANO Da faca

		Citizen.Wait(50)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
------COR ARMA
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('changeWeaponColor')
AddEventHandler('changeWeaponColor', function(cor)
    local tinta = tonumber(cor)
    local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
    if tinta >= 0 then
        SetPedWeaponTintIndex(ped,arma,tinta)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmascara')
AddEventHandler('setmascara',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if modelo == nil then
			vRP._playAnim(true,{"missfbi4","takeoff_mask"},false)
			Wait(1100)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setblusa')
AddEventHandler('setblusa',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,15,0,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcolete')
AddEventHandler('setcolete',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setjaqueta')
AddEventHandler('setjaqueta',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaos')
AddEventHandler('setmaos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingshirt","try_shirt_positive_d"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCALCA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcalca')
AddEventHandler('setcalca',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
				Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,15,0,2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACESSORIOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setacessorios')
AddEventHandler('setacessorios',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			SetPedComponentVariation(ped,7,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setsapatos')
AddEventHandler('setsapatos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() and not IsPedInAnyVehicle(ped) then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,34,0,2)
				Wait(500)
				ClearPedTasks(ped)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,35,0,2)
				Wait(500)
				ClearPedTasks(ped)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{"clothingshoes","try_shoes_positive_d"},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setchapeu')
AddEventHandler('setchapeu',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"veh@common@fp_helmet@","take_off_helmet_stand"},false)
			Wait(700)
			ClearPedProp(ped,0)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") and parseInt(modelo) ~= 39 then
			vRP._playAnim(true,{"veh@common@fp_helmet@","put_on_helmet"},false)
			Wait(1700)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") and parseInt(modelo) ~= 38 then
			vRP._playAnim(true,{"veh@common@fp_helmet@","put_on_helmet"},false)
			Wait(1700)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setoculos')
AddEventHandler('setoculos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
		if not modelo then
			vRP._playAnim(true,{"mini@ears_defenders","takeoff_earsdefenders_idle"},false)
			Wait(500)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{"misscommon@van_put_on_masks","put_on_mask_ps"},false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmochila')
AddEventHandler('setmochila',function(modelo,cor)
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 and vSERVER.checkRoupas() then
        if not modelo then
            vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
            Wait(2500)
            ClearPedTasks(ped)
            SetPedComponentVariation(ped,5,15,0,2)
            return
        end
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
            Wait(2500)
            ClearPedTasks(ped)
            SetPedComponentVariation(ped,5,parseInt(modelo),parseInt(cor),2)
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
            vRP._playAnim(true,{"missmic4","michael_tux_fidget"},false)
            Wait(2500)
            ClearPedTasks(ped)
            SetPedComponentVariation(ped,5,parseInt(modelo),parseInt(cor),2)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic",function(timers,number)

	energetico = true
	SetTimeout(5000,function()
	energetico = false	
	
	end)

end)
-----------------------------------------------------------------------------------------------------------------------------------------
  -- STAMINA INFINITA --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do
    Citizen.Wait(0)
        RestorePlayerStamina(PlayerId(), 1.0)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Cansar ao correr 
-----------------------------------------------------------------------------------------------------------------------------------------
local isSprinting, isSwimming, isUnderwater = false, false, false

Citizen.CreateThread(function()
	while true do
		local lPed = GetPlayerPed(-1)
		isSprinting = IsPedSprinting(lPed)
		isSwimming = IsPedSwimming(lPed)
		isUnderwater = IsPedSwimmingUnderWater(lPed)
		local sleep = 1500
		Citizen.Wait(sleep)	
	end
end)	

Citizen.CreateThread(function()	
	local stamina =	10.0
	while true do
		if energetico then
			stamina = 15.0
		end
		--print(stamina)	
		while isSprinting == 1 do
			Citizen.Wait(3000)
			if isSprinting == false then
				Citizen.Wait(3000)
				stamina = 10.0
				--print(isSprinting)
			else	
				stamina = stamina -1
				sleep = 5
				if stamina < 1.0 then
					if not isSwimming and not isUnderwater then
						RequestAnimDict("re@construction")
						while not HasAnimDictLoaded("re@construction") do
						Citizen.Wait(100)
						end			
						TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 8.0, 8.0,-1, 32, 0, false, false, false)
						Citizen.Wait(2000)
						TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 8.0, 8.0,-1, 32, 0, false, false, false)

					end
				end				
			Citizen.Wait(sleep)
			end
			--print(stamina)
		end
		Citizen.Wait(1000)
	end	
end)

----------------------------------------------------------------------------------------------
-- Anti VDM
----------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        N_0x4757f00bc6323cfe(-1553120962, 0.0) 
        Wait(0)
    end
end)
--------------------------------------------------------------------------
--[ NÃO ATIRAR FALANDO NO RÁDIO ]
--------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local player = PlayerId() 
        if IsEntityPlayingAnim(ped, "random@arrests","generic_radio_chatter", 3) then
            DisablePlayerFiring(player, true)
        end
    end
end)
------------------------------------------------------------------------
-- ANTI VDM
-------------------------------------------------------------------------
-- local oldSpeed = 0
-- local batida = 0
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1000)
--         local vehicle = GetVehiclePedIsIn(PlayerPedId())
--         if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
--             local currentSpeed = GetEntitySpeed(vehicle)*10.236936
--             if currentSpeed ~= oldSpeed then
--                 if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
-- 					batida = batida + 1
-- 					SetTimeout(10000,function()
-- 						batida = 0
-- 					end)	
--                 end
--                 oldSpeed = currentSpeed
--             end
--         else
--             if oldSpeed ~= 0 then
--                 oldSpeed = 0
--             end
--         end
-- 		if batida > 3 then
-- 			vGARAGE.deleteVehicle(source,vehicle)
-- 			TriggerServerEvent("dellvehicle",source)
-- 		end	
--     end
-- end)






-------------------------------------------------------------------------------------------
--TOOGLE
-------------------------------------------------------------------------------------------


---------------------------------------PMERJ------------------------------------------------
-- function cRP.tooglePMERJ(source)
-- 	local zones = {
-- 		{ ['x'] = 624.9, ['y'] = -6.34, ['z'] = 82.73}, -- 624.9, -6.34, 82.73 PMERJ

-- 	}
-- 			local playerPed = GetPlayerPed(-1)
-- 			local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
-- 			local minDistance = 100000
-- 			for i = 1, #zones, 1 do
-- 				dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
-- 				if dist < minDistance then
-- 					minDistance = dist
-- 					closestZone = i
-- 				end
-- 			end
-- 	local player = GetPlayerPed(-1)
-- 	local x,y,z = table.unpack(GetEntityCoords(player, true))
-- 	local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)

-- 	if dist <= 2.0 then
-- 		--TriggerEvent("Notify","amarelo","Voce esta na base.",3000)
-- 		return true
-- 	else
-- 		TriggerEvent("Notify","amarelo","Voce esta longe da base.",3000)
-- 		return false	
-- 	end
-- end

-----------------------------------------------MEC------------------------------------------------------------
function cRP.toogleMEC(source)
	local zones = {
		{ ['x'] = -761.45, ['y'] = -1465.07, ['z'] = 5.1}, -- -761.45, -1465.07, 5.1 MEC

	}
			local playerPed = GetPlayerPed(-1)
			local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			local minDistance = 100000
			for i = 1, #zones, 1 do
				dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
				if dist < minDistance then
					minDistance = dist
					closestZone = i
				end
			end
	local player = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(player, true))
	local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)

	if dist <= 2.0 then
		--TriggerEvent("Notify","amarelo","Voce esta na base.",3000)
		return true
	else
		TriggerEvent("Notify","amarelo","Voce esta longe da base.",3000)
		return false	
	end
end

-----------------------------------------------MED------------------------------------------------------------
function cRP.toogleMED(source)
	local zones = {
		{ ['x'] = -817.45, ['y'] = -1245.08, ['z'] = 7.34}, -- -817.45, -1245.08, 7.34 MED

	}
			local playerPed = GetPlayerPed(-1)
			local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			local minDistance = 100000
			for i = 1, #zones, 1 do
				dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
				if dist < minDistance then
					minDistance = dist
					closestZone = i
				end
			end
	local player = GetPlayerPed(-1)
	local x,y,z = table.unpack(GetEntityCoords(player, true))
	local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)

	if dist <= 2.0 then
		--TriggerEvent("Notify","amarelo","Voce esta na base.",3000)
		return true
	else
		TriggerEvent("Notify","amarelo","Voce esta longe da base.",3000)
		return false	
	end
end

function cRP.checkcuff(nplayer)
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) or IsEntityPlayingAnim(ped,"mp_arresting","idle",3) then
		return true
	end	
end	





-----------------------------------------------------------------------------------------------------------------------------------------
-- Safe
-----------------------------------------------------------------------------------------------------------------------------------------

local zones = {
	{ ['x'] = 168.40252685547, ['y'] = -996.16967773438, ['z'] = 29.35410118103}, -- 168.40252685547,-996.16967773438,29.35410118103 --praça
	{['x'] = 167.95, ['y'] = -965.58, ['z'] = 30.46}, --praça
	{['x'] = 189.41, ['y'] = -942.83, ['z'] = 30.1}, --praça
	{['x'] = 217.32, ['y'] = -903.97, ['z'] = 30.7}, --praça
	{['x'] = 238.2, ['y'] = -863.98, ['z'] = 29.77}, --praça
	{['x'] = 144.63, ['y'] = -907.24, ['z'] = 30.33}, --praça 144.63, -907.24, 30.33
	{['x'] = 188.41, ['y'] = -851.11, ['z'] = 30.93}, --praça 188.41, -851.11, 30.93
	{['x'] = 112.99, ['y'] = -844.63, ['z'] = 29.46}, --praça 112.99, -844.63, 29.46
	{['x'] = 61.41, ['y'] = -913.33, ['z'] = 30.03}, --praça 61.41, -913.33, 30.03
	{['x'] = 150.53, ['y'] = -952.23, ['z'] = 29.83}, --praça 150.53, -952.23, 29.83

	{['x'] = -711.06, ['y'] = -1410.37, ['z'] = 5.06}, --mec -711.06, -1410.37, 5.06
	{['x'] = -746.09, ['y'] = -1467.46, ['z'] = 5.1}, --mec -746.09, -1467.46, 5.1

	{['x'] = 825.33, ['y'] = -965.09, ['z'] = 26.49}, --mec 825.33, -965.09, 26.49

	{ ['x'] = -841.53, ['y'] = -1206.29, ['z'] = 6.44 }, --   -841.53, -1206.29, 6.44 hp
}

local notifIn = false
local notifOut = false
local closestZone = 1



--------------------------------------------------------------------------------------------------------------
------------   Obtendo sua distância de qualquer um dos locais                                  --------------
--------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)


--------------------------------------------------------------------------------------------------------------
---------   Ativando e desativando fogo amigo, desativando suas armas e enviando pNoty       -----------------
--------------------------------------------------------------------------------------------------------------
local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"PISTOL":"0x1B06D571","PISTOL_MK2":"0xBFE256D4","COMBATPISTOL":"0x5EF9FEC4","APPISTOL":"0x22D8FE39","STUNGUN":"0x3656C8C1","PISTOL50":"0x99AEEB3B","SNSPISTOL":"0xBFD21232","SNSPISTOL_MK2":"0x88374054","HEAVYPISTOL":"0xD205520E","VINTAGEPISTOL":"0x83839C4","FLAREGUN":"0x47757124","MARKSMANPISTOL":"0xDC4DB296","REVOLVER":"0xC1B3C3D1","REVOLVER_MK2":"0xCB96392F","DOUBLEACTION":"0x97EA20B8","RAYPISTOL":"0xAF3696A1"},"smg":{"MICROSMG":"0x13532244","SMG":"0x2BE6766B","SMG_MK2":"0x78A97CD0","ASSAULTSMG":"0xEFE7E2DF","COMBATPDW":"0xA3D4D34","MACHINEPISTOL":"0xDB1AA450","MINISMG":"0xBD248B55","RAYCARBINE":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"ASSAULTRIFLE":"0xBFEFFF6D","ASSAULTRIFLE_MK2":"0x394F415C","CARBINERIFLE":"0x83BF0278","CARBINERIFLE_MK2":"0xFAD1F1C9","ADVANCEDRIFLE":"0xAF113F99","SPECIALCARBINE":"0xC0A3098D","SPECIALCARBINE_MK2":"0x969C3D67","BULLPUPRIFLE":"0x7F229F94","BULLPUPRIFLE_MK2":"0x84D6FAFD","COMPACTRIFLE":"0x624FE830"},"MACHINE_GUNS":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}')

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(0)
		
		
		local ped = PlayerPedId()
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
		if dist <= 50.0 then
			if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
				--print('armado')
				DisableControlAction(2, 37, true)-- desabilitar roda de arma (Tab)
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				TriggerEvent("Notify","amarelo","Você está em uma SafeZone.",8000)
			end	
		end	
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
------VAPE
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {
		-- Key used to take a hit of the vape (51)"E" by default.
	DragControl = 51,


	CancelControl = 168,

		-- Key used to reset to the resting vape position (58)"G" by default.
	RestingAnim = 58,

		-- The amount of time in (ms) you will need to hold the button in order to commit to the action. (250) by default.
	ButtonHoldTime = 250,

		-- Size of the vape clouds. (0.5) by default.
	SmokeSize = 0.5,

		-- the Odds of your Mod exploding in your face. (10594) by default. lower the number to increase the chance you have to explode.
	FailureOdds = 10594, -- 10594 = 0.0001% chance

		-- The amount of time in (ms) the player has to wait before the can hit the vape again. (4000) by default.
	VapeCoolDownTime = 4000,

		-- The amount of time in (ms) the smoke from the vape will linger. (2800) by default.
	VapeHangTime = 2800,

		-- Whether or not you want ace permissions to be enabled, False = Everyone Can vape, 
	VapePermission = false,

		-- Ace permissions group to allow access. **REQUIRED IF YOU HAVE PERMISSIONS ENABLED**
	PermissionsGroup = "ADD_ACE_GROUP_HERE",

		-- If permissions are enabled you can set the denied access message here. **REQUIRED IF YOU HAVE PERMISSIONS ENABLED**
	InsufficientMessage = "^3You do not have permission to do this.",

		-- This will Enable and disable the debug commands. 
	Debug = false,

		-- The Transparency of the help text when it starts. (0) by default. Just leave this alone...
	HelpTextStartingAlpha = 0,

		-- Hold long in (ms) will the help message appear for. (8000) by default.
	HelpTextLength = 8000,
}


local IsPlayerAbleToVape = false
local FadeIn = false
local FadeOut = false



RegisterNetEvent("Vape:StartVaping")
RegisterNetEvent("Vape:VapeAnimFix")
RegisterNetEvent("Vape:StopVaping")
RegisterNetEvent("Vape:Drag")

AddEventHandler("Vape:StartVaping", function(source)
local ped = GetPlayerPed(-1)
if DoesEntityExist(ped) and not IsEntityDead(ped) then
	if IsPedOnFoot(ped) then
		if IsPlayerAbleToVape == false then
			PlayerIsAbleToVape()
			TriggerEvent("Vape:HelpFadeIn", 0)
			TriggerClientEvent("Notify",source,"aviso","Voçê começou usar seu vape..",5000)
			Wait(Config.HelpTextLength)
			TriggerEvent("Vape:HelpFadeOut", 0)
		else
			TriggerClientEvent("Notify",source,"aviso","Você já está segurando seu vape.",5000)
		end
	else
		TriggerClientEvent("Notify",source,"aviso","Você não pode fazer isso em um veículo.",5000)
	end
else
	TriggerClientEvent("Notify",source,"aviso","Você não pode fazer isso se estiver morto.",5000)
end
end)
AddEventHandler("Vape:VapeAnimFix", function(source)
local ped = GetPlayerPed(-1)
local ad = "anim@heists@humane_labs@finale@keycards"
local anim = "ped_a_enter_loop"
while (not HasAnimDictLoaded(ad)) do
	RequestAnimDict(ad)
  Wait(1)
end
TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
end)
AddEventHandler("Vape:StopVaping", function(source)
if IsPlayerAbleToVape == true then
	PlayerIsUnableToVape()
	TriggerClientEvent("Notify",source,"aviso","Você parou de usar seu vape.",5000)
else
	TriggerClientEvent("Notify",source,"aviso","Você não está segurando seu vape.",5000)
end
end)
AddEventHandler("Vape:Drag", function()
if IsPlayerAbleToVape then
	local ped = GetPlayerPed(-1)
	local PedPos = GetEntityCoords(ped)
	local ad = "mp_player_inteat@burger"
	local anim = "mp_player_int_eat_burger"
	if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
		while (not HasAnimDictLoaded(ad)) do
			RequestAnimDict(ad)
		  Wait(1)
		end
		local VapeFailure = math.random(1,Config.FailureOdds)
		if VapeFailure == 1 then
			TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
			PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
				Wait(250)
			AddExplosion(PedPos.x, PedPos.y, PedPos.z+1.00, 34, 0.00, true, false, 1.00)
			ApplyDamageToPed(ped, 200, false)
			TriggerServerEvent("Vape:Failure", 0)
		else
			TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
			PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
				  Wait(950)
			TriggerServerEvent("eff_smokes", PedToNet(ped))
				  Wait(Config.VapeHangTime-1000)
			TriggerEvent("Vape:VapeAnimFix", 0)
		end
	end
else
	TriggerClientEvent("Notify",source,"aviso","Você deve estar segurando seu vape para fazer isso.",5000)
end
end)
AddEventHandler("Vape:HelpFadeIn", function()
if FadeIn == false then
	FadeIn = true
	DisplayText = true
	while FadeIn == true do
		if Config.HelpTextStartingAlpha <= 255 then
			Config.HelpTextStartingAlpha = Config.HelpTextStartingAlpha+5
			if Config.HelpTextStartingAlpha >= 255 then
				FadeIn = false
				break
			end
		end
	  Wait(1)
	end
end
end)
AddEventHandler("Vape:HelpFadeOut", function()
if FadeOut == false then
	FadeOut = true
	while FadeOut == true do
		if Config.HelpTextStartingAlpha >= 1 then
			Config.HelpTextStartingAlpha = Config.HelpTextStartingAlpha-5
			if Config.HelpTextStartingAlpha <= 0 then
				FadeOut = false
				DisplayText = false
				break
			end
		end
	  Wait(1)
	end
end
end)

p_smoke_location = {
20279,
}
p_smoke_particle = "exp_grd_bzgas_smoke"
p_smoke_particle_asset = "core"
RegisterNetEvent("c_eff_smokes")
AddEventHandler("c_eff_smokes", function(c_ped)
for _,bones in pairs(p_smoke_location) do
	if DoesEntityExist(NetToPed(c_ped)) and not IsEntityDead(NetToPed(c_ped)) then
		createdSmoke = UseParticleFxAssetNextCall(p_smoke_particle_asset)
		createdPart = StartParticleFxLoopedOnEntityBone(p_smoke_particle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), bones), Config.SmokeSize, 0.0, 0.0, 0.0)
		Wait(Config.VapeHangTime)
		--Wait(250)
		while DoesParticleFxLoopedExist(createdSmoke) do
			StopParticleFxLooped(createdSmoke, 1)
		  Wait(0)
		end
		while DoesParticleFxLoopedExist(createdPart) do
			StopParticleFxLooped(createdPart, 1)
		  Wait(0)
		end
		while DoesParticleFxLoopedExist(p_smoke_particle) do
			StopParticleFxLooped(p_smoke_particle, 1)
		  Wait(0)
		end
		while DoesParticleFxLoopedExist(p_smoke_particle_asset) do
			StopParticleFxLooped(p_smoke_particle_asset, 1)
		  Wait(0)
		end
		Wait(Config.VapeHangTime*3)
		RemoveParticleFxFromEntity(NetToPed(c_ped))
		break
	end
end
end)

Citizen.CreateThread(function()
while true do
	local ped = GetPlayerPed(-1)
	if IsPedInAnyVehicle(ped, true) then
		PlayerIsEnteringVehicle()
	end
	if IsPlayerAbleToVape then
		if IsControlPressed(0, Config.DragControl) then
		  Wait(Config.ButtonHoldTime)
			if IsControlPressed(0, Config.DragControl) then
				TriggerEvent("Vape:Drag", 0)
				--local user_id = vRP.getUserId(source)
				TriggerServerEvent("Vape:Stress")
				--vRP.varyStress(user_id,-50)
			end
		  Wait(Config.VapeCoolDownTime)
		end
		if IsControlPressed(0, Config.CancelControl) then
			Wait(Config.ButtonHoldTime)
			TriggerEvent("Vape:StopVaping", source, 0)
		end
		if IsControlPressed(0, Config.RestingAnim) then
		  Wait(Config.ButtonHoldTime)
			if IsControlPressed(0, Config.RestingAnim) then
				TriggerEvent("Vape:VapeAnimFix", 0)
			end
		  Wait(1000)
		end
	end
  Wait(1)
end
end)
Citizen.CreateThread(function()
while true do
	if IsPlayerAbleToVape then
		if DisplayText then
			local ped = GetPlayerPed(-1)
			local pedPos = GetEntityCoords(ped)
			DrawText3d(pedPos.x, pedPos.y, pedPos.z+1.20, "~c~Pressione ~b~\"E\"~c~ para fumar.")
			DrawText3d(pedPos.x, pedPos.y, pedPos.z+1.08, "~c~Pressione ~b~\"G\"~c~ para desbugar o vape.")
			DrawText3d(pedPos.x, pedPos.y, pedPos.z+0.96, "~c~Pressione ~b~\"F7\"~c~ para cancelar.")
		end
	end
  Wait(1)
end
end)

function PlayerIsAbleToVape()
IsPlayerAbleToVape = true
local ped = GetPlayerPed(-1)
local ad = "anim@heists@humane_labs@finale@keycards"
local anim = "ped_a_enter_loop"

while (not HasAnimDictLoaded(ad)) do
	RequestAnimDict(ad)
  Wait(1)
end
TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)

local x,y,z = table.unpack(GetEntityCoords(ped))
local prop_name = "ba_prop_battle_vape_01"
VapeMod = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
AttachEntityToEntity(VapeMod, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.00, 0.03, -150.0, 90.0, -10.0, true, true, false, true, 1, true)
end
function PlayerIsEnteringVehicle()
IsPlayerAbleToVape = false
local ped = GetPlayerPed(-1)
local ad = "anim@heists@humane_labs@finale@keycards"
DeleteObject(VapeMod)
TaskPlayAnim(ped, ad, "exit", 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
end
function PlayerIsUnableToVape()
IsPlayerAbleToVape = false
local ped = GetPlayerPed(-1)
DeleteObject(VapeMod)
ClearPedTasksImmediately(ped)
ClearPedSecondaryTask(ped)
end
-- function ShowNotification( text )
--     SetNotificationTextEntry( "STRING" )
--     AddTextComponentString( text )
--     DrawNotification( false, false )
-- end
function DrawText3d(x, y, z, text)
local onScreen,_x,_y=World3dToScreen2d(x,y,z)
local px,py,pz=table.unpack(GetGameplayCamCoords())
if onScreen then
	SetTextScale(0.3, 0.3)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, Config.HelpTextStartingAlpha)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end
end

-- if Config.Debug then
-- 	RegisterCommand("vapesound", function(source, rawCommand)
-- 		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
-- 		ShowNotification("Play sound???")
-- 	end)
-- 	RegisterCommand("vapexp", function(source, rawCommand)
-- 		local ped = GetPlayerPed(-1)
-- 		local PedPos = GetEntityCoords(ped)
-- 		AddExplosion(PedPos.x, PedPos.y, PedPos.z+1.00, 34, 0.00, true, false, 1.00)
-- 		ShowNotification("Play explosion???")
-- 	end)
-- end





Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if IsPlayerAbleToVape then
			timeDistance = 4
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tratamento')
AddEventHandler('tratamento',function()
	print("chamada")
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(600)
	until GetEntityHealth(PlayerPedId()) >= 200 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)