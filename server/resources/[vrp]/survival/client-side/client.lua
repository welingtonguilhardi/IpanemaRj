local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("survival")


cRP = {}
Tunnel.bindInterface("survival",cRP)

local deadPlayer = false
local coma = false
local noCops = false
local busted = false
local cop = false

Citizen.CreateThread(function()
    while true do
        local sleep = 100
            local ped = PlayerPedId()
            if GetEntityHealth(ped) <= 101 and not coma then
                coma = true

                if IsPedInAnyVehicle(ped) then
					TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
				end
                
                local x,y,z = table.unpack(GetEntityCoords(ped))
				NetworkResurrectLocalPlayer(x,y,z,true,true,false)

				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)
                
                TriggerEvent("radio:outServers")
                TriggerEvent("hudActived",false)

                SendNuiMessage(json.encode({ coma = true }))
                activeFunction()
            end
        Wait(sleep)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ISINCOMA ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function InComa()
	return coma
end


function cRP.finishDeath()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		deadPlayer = false
		TriggerEvent("hudActived",true)
		ClearPedBloodDamage(ped)
		SetEntityHealth(ped,200)
		SetEntityInvincible(ped,false)
	end
end

function cRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerEvent("hudActived",true)
	
	if deadPlayer then
		deadPlayer = false
		ClearPedTasks(PlayerPedId())
	end
end

local called = false

activeFunction = function()
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if GetEntityHealth(ped) > 101 and coma and not busted then
                coma = false
                SendNuiMessage(json.encode({ coma = false}))
                SendNuiMessage(json.encode({ action = "hide"}))
                called = false
            end

            if coma then
                SetPedToRagdoll(ped,2000,2000,0,0,0,0)
                SetEntityHealth(ped,101)
                BlockWeaponWheelThisFrame()

                DisableAllControlActions(true)
            end
            Citizen.Wait(4)
        end    
    end)
end

RegisterNUICallback("haveCops",function(data,cb)
    local bool = vSERVER.checkEmergency()
    if not bool then noCops = true end
    cb(bool)
end)

RegisterNUICallback("atualizeInfo",function()
    registerDeath()
end)

registerDeath = function()
    busted = true
    Citizen.CreateThread(function()
        while true do
            if GetEntityHealth(PlayerPedId()) <= 101 and coma then
                if IsDisabledControlJustPressed(0,47) then
                    revive(PlayerPedId())
                    vSERVER.ResetPedToHospital()
                    SendNuiMessage(json.encode({action = "hide"}))
                    return
                end
            end
            Citizen.Wait(1)
        end
    end)
end

RegisterNetEvent("cop:Action")
AddEventHandler("cop:Action",function(bool)
    cop = bool
end)

revive = function(ped)
    called = false
    busted = false
    coma = false
    noCops = false
    TriggerEvent("resetBleeding")
    TriggerEvent("resetDiagnostic")
    TriggerServerEvent("clearInventory")
    TriggerServerEvent("removerfinalizado")
    TriggerServerEvent("chest:playerDied")
    TriggerServerEvent("survival:playerNeeds")
    TriggerEvent("hudActived",true)
    ClearPedBloodDamage(ped)
    SetEntityInvincible(ped,false)
    DoScreenFadeOut(1000)
    SetEntityHealth(ped,400)
    SetPedArmour(ped,0)
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(),338.98+0.0001,-1394.36+0.0001,32.51+0.0001,1,0,0,1)
    FreezeEntityPosition(ped,true)
    SetTimeout(5000,function()
        FreezeEntityPosition(ped,false)
        TriggerServerEvent("chest:playerDied")
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end)
end

RegisterNetEvent("survival:resetPlayer")
AddEventHandler("survival:resetPlayer",function()
    called = false
    busted = false
    coma = false
    noCops = false
end)