-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("radio",src)
vSERVER = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("radio",function(source,args)
	if GetEntityHealth(PlayerPedId()) > 101 and vSERVER.checkRadio() and not vRP.isHandcuffed() then
		if args[1] == "s" then
			TriggerEvent("radio:outServers")
			TriggerEvent("Notify","aviso","Você saiu de todas as frequências.",8000)
		else
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOGGLENUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('radio:toggleNui')
AddEventHandler('radio:toggleNui',function(status)
	if status and not vRP.isHandcuffed() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOGGLENUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('radio:entrar')
AddEventHandler('radio:entrar',function()
	if not vRP.isHandcuffed() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("activeFrequency",function(data)
	if parseInt(data.freq) >= 1 and parseInt(data.freq) <= 999 then
		vSERVER.activeFrequency(data.freq)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inativeFrequency",function(data)
	TriggerEvent("radio:outServers")
	TriggerEvent("Notify","aviso","Você saiu de todas as frequências.",8000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startFrequency(frequency)
	TriggerEvent("radio:outServers")
	exports["pma-voice"]:setRadioChannel(frequency)
	exports["pma-voice"]:setVoiceProperty('radioEnabled',true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("radio:outServers")
-- AddEventHandler("radio:outServers",function()
-- 	exports["pma-voice"]:removePlayerFromRadio()
-- 	exports["pma-voice"]:setVoiceProperty('radioEnabled',false)
-- end)


RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
	exports["pma-voice"]:SetRadioChannel(0)
	exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
end)

local isBroadcasting = false

AddEventHandler('pma-voice:radioActive', function(broadCasting)
	isBroadcasting = broadCasting
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local broadcastDictionary = "random@arrests"
		local broadcastAnimation = "generic_radio_chatter"
		local isPlayingBroadcastAnim = IsEntityPlayingAnim(playerPed, broadcastDictionary, broadcastAnimation, 3)
		if isBroadcasting and not isPlayingBroadcastAnim then
			RequestAnimDict(broadcastDictionary)
			while not HasAnimDictLoaded(broadcastDictionary) do
				Citizen.Wait(150)
			end
			TaskPlayAnim(playerPed, broadcastDictionary, broadcastAnimation, 8.0, 0.0, -1, 49, 0, 0, 0, 0)                    
			local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,0.0,-5.0)
			object = CreateObject(GetHashKey('prop_cs_hand_radio'),coords.x,coords.y,coords.z,true,true,true)
			SetEntityCollision(object,false,false)
			AttachEntityToEntity(object,PlayerPedId(),GetPedBoneIndex(PlayerPedId(),60309),0.06,0.05,0.03,-90.0,30.0,0.0,false,false,false,false,2,true)
			SetTimeout(10000,function()
				DeleteObject(object)
			end)
		elseif not isBroadcasting and isPlayingBroadcastAnim then
			StopAnimTask(playerPed, broadcastDictionary, broadcastAnimation, -4.0)
			DeleteObject(object)
		end
	end
end)

AddEventHandler("onClientResourceStart", function(resName)
	if GetCurrentResourceName() ~= resName and "pma-voice" ~= resName then
		return
	end
	exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
end)


















RegisterCommand("volume",function(source,args)
    if tonumber(args[1]) <= 100 and tonumber(args[1]) >= 10 then
        local volume = tonumber(args[1])
        exports["pma-voice"]:setRadioVolume(volume/100)
        TriggerEvent("Notify","sucesso","<b>Volume:</b> "..volume.."%",5000)
    end
end)