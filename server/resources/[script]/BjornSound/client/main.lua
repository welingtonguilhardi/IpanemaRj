local cacheSpeaker = {}
local placedSpeaker = {}
local placedSpeakerCoords = nil
local onSongPick = false
local currentId = nil


AddEventHandler("onResourceStop",function(resource)
if resource == GetCurrentResourceName() then
		SetNuiFocus(false, false)
	end
end
)



Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
	Wait(1000) 
	end
		TriggerServerEvent("BjornSound:joined")
end)



RegisterNUICallback("loadServer",function(data, cb)
	local plyrcoords, forward = GetEntityCoords(PlayerPedId()), GetEntityForwardVector(PlayerPedId())
	local spawncoords = (plyrcoords + forward * 1.0)

	local tempTable = {
		[1] = {id = data.id, coords = cacheSpeaker[currentId].coords, time = data.time, speaker = currentId, startTime = data.time, speakerid = cacheSpeaker[currentId].speakerid}
	}
		TriggerServerEvent("BjornSound:loadSpeaker", tempTable[1])
end)


RegisterNetEvent("BjornSound:loadSpeakerClient")
AddEventHandler("BjornSound:loadSpeakerClient", function(speaker)
	cacheSpeaker[speaker.speaker] = speaker
end)


RegisterNetEvent("BjornSound:joined")
AddEventHandler("BjornSound:joined", function(speaker)
	cacheSpeaker = speaker
end)

RegisterNetEvent("BjornSound:removeClient")
AddEventHandler("BjornSound:removeClient", function(speaker)
	cacheSpeaker[speaker] = nil
	SendNUIMessage({close = true})
end)

local speaker
local started = false
local playing
local onSwitch = false
local onVolChange = false
local volchange = 0
local videoStatus = "play"
local newTime = 0

RegisterNUICallback("switchVideo",function(data, cb)
	onSwitch = true
	videoStatus = data.videoStatus
	newTime = data.pausedTime
end)

RegisterNUICallback("changeVol",function(data, cb)
	onVolChange = true
	volchange = data.vol
end)

RegisterNetEvent("BjornSound:switchVideoClient")
AddEventHandler("BjornSound:switchVideoClient", function(id, videoStatus, time)
	cacheSpeaker[id].switch = true
	cacheSpeaker[id].videoStatus = videoStatus
	cacheSpeaker[id].time = time - cacheSpeaker[id].time
end)

RegisterNetEvent("BjornSound:changeVolClient")
AddEventHandler("BjornSound:changeVolClient", function(id, vol)
	cacheSpeaker[id].volval = vol
	cacheSpeaker[id].volchange = true
end)

local vol = 100

Citizen.CreateThread(function()
	while true do
		local wait = 1000
		local plyr = PlayerPedId()
		local plyrcoords = GetEntityCoords(plyr)

		if #cacheSpeaker > 0 then
			for k, v in pairs(cacheSpeaker) do
                local dist = #(v.coords - plyrcoords)
                
                if v.id ~= nil then
				if dist < 50.0 then	
					wait = 100
					if dist < 20.0 then
					
						vol = v.volval - (dist * 5)

						if not v.playing then

							v.playing = true

							playing = k

							SendNUIMessage({start = true, time = v.time, id = v.id, videoStatus = v.videoStatus, startTime = v.startTime})

							videoStatus = v.videoStatus

						elseif playing == k and onSwitch then

							TriggerServerEvent("BjornSound:switchVideo", k, videoStatus, newTime)

							onSwitch = false

						elseif playing == k and v.switch then

							v.switch = false

							SendNUIMessage({switch = true, videoStatus = v.videoStatus, time = v.time})

						elseif playing == k and onVolChange then

							TriggerServerEvent("BjornSound:changeVol", k, volchange)

							onVolChange = false

						elseif playing == k and v.volchange then

							v.volchange = false

						end

					elseif dist > 20.0 and playing == k and v.playing then

						SendNUIMessage({type = "reset"})

						v.playing = false

						SendNUIMessage({close = true})

					end

					

					if playing == k and v.playing then

						if IsPedInAnyVehicle(plyr, false) then

							vol = vol / 5

						end

						SendNUIMessage({volume = vol, setVol = true, volval = v.volval})

					end

				end

			end

		end
		end
		Wait(wait)

	end

end)



Citizen.CreateThread(function()

	while true do

		----Wait(1)
		local Sleep = 1000

		if #cacheSpeaker > 0 then
			Sleep = 1
			for k, v in pairs(cacheSpeaker) do



				if #(v.coords - GetEntityCoords(PlayerPedId())) < 2.0 then

					local fixedCoords = vector3(v.coords.x, v.coords.y, v.coords.z - 1.5)

					currentId = v.speaker

					HelpText(Config["traducoes"].pickUp, fixedCoords)



					if IsControlJustPressed(0, 38) then

						SetNuiFocus(true, true)

						SendNUIMessage({type = "openSpeaker"})

					end

					if IsControlJustPressed(0, 47) then

						TriggerServerEvent("BjornSound:removeSpeaker", currentId)

						SendNUIMessage({type = "reset"})

						--print(v.speakerid)

						DeleteEntity(v.speakerid)

						while DoesEntityExist(v.speakerid) do

							Wait(0)

							DeleteEntity(v.speakerid)

						end

						started = false

						placedSpeakerCoords = nil

					end

				end

			end

		end
	Wait(Sleep)
	end

end)



RegisterCommand(Config.Comando,function(source, args, rawCommand)
	if not IsPedInAnyVehicle(PlayerPedId(), true) and Config.EnableCommand then
		TriggerEvent("BjornSound:place")
	end
end)



RegisterNetEvent("BjornSound:place")
AddEventHandler("BjornSound:place", function()
	local plyrcoords, forward = GetEntityCoords(PlayerPedId()), GetEntityForwardVector(PlayerPedId())
	local spawncoords = (plyrcoords + forward * 1.0)
	tooClose = false
	if #cacheSpeaker > 0 then
		for k, v in pairs(cacheSpeaker) do
			if #(plyrcoords - v.coords) < 40.0 then
				tooClose = true
			end
		end
		if not tooClose then
			speaker = CreateObject(1729911864, spawncoords, true, true, true)
			FreezeEntityPosition(speaker, true)
			SetEntityAsMissionEntity(speaker)
			SetEntityCollision(speaker, false, true)
			PlaceObjectOnGroundProperly(speaker)
			TriggerServerEvent("BjornSound:placedSpeaker", spawncoords, speaker)
			SetEntityHeading(speaker, GetEntityHeading(PlayerPedId()))
		else
			TriggerEvent("Notify", "aviso", Config["traducoes"].tooClose)
		end
	else
		speaker = CreateObject(1729911864, spawncoords, true, true, true)
		FreezeEntityPosition(speaker, true)
		SetEntityAsMissionEntity(speaker)
		SetEntityCollision(speaker, false, true)
		PlaceObjectOnGroundProperly(speaker)
		TriggerServerEvent("BjornSound:placedSpeaker", spawncoords, speaker)
		SetEntityHeading(speaker, GetEntityHeading(PlayerPedId()))
	end
end)



RegisterNUICallback("escape",function(data, cb)
	SetNuiFocus(false, false)
end)



HelpText = function(msg, coords)
    if not coords or not Config.Enable3DText then
        AddTextEntry(GetCurrentResourceName(), msg)
        DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
    else
        DrawText3D(coords, string.gsub(msg, "~INPUT_CONTEXT~", "~r~[~w~E~r~]~w~"), 0.35)
    end
end



DrawText3D = function(coords, text, scale)
    coords = coords + vector3(0.0, 0.0, 1.2)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 41, 41, 125)
end

