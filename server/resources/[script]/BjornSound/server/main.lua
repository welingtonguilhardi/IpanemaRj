local speakers = {}

local coords = {}

RegisterServerEvent('BjornSound:loadSpeaker')
AddEventHandler('BjornSound:loadSpeaker', function(speaker)
    speakers[speaker.speaker] = speaker
    speakers[speaker.speaker].switch = false
    speakers[speaker.speaker].volchange = false
    speakers[speaker.speaker].volval = 100
    speaker.switch = false
    speaker.volchange = false
    speaker.volval = 100
    TriggerClientEvent('BjornSound:loadSpeakerClient', -1, speaker)
end)

local id = 0

RegisterServerEvent('BjornSound:removeSpeaker')
AddEventHandler('BjornSound:removeSpeaker', function(speaker)
    id = id - 1
    TriggerClientEvent("BjornSound:removeClient", -1, speaker)
end)


RegisterServerEvent('BjornSound:placedSpeaker')
AddEventHandler('BjornSound:placedSpeaker', function(spawncoords, speakerid)
    id = id + 1
    local speaker = {}
    speaker.speakerid = speakerid
    speaker.coords = spawncoords
    speaker.speaker = id
    table.insert(speakers, speaker)
    TriggerClientEvent('BjornSound:loadSpeakerClient', -1, speaker)
end)

RegisterServerEvent('BjornSound:joined')
AddEventHandler('BjornSound:joined', function()
    local src = source
    for i=1, #speakers do
        --print(speakers[i].coords)
        --print(speakers[i].speaker)
        --print(speakers[i].volchange)
        --print(speakers[i].videoStatus)
        --print(speakers[i].time)
    end
    TriggerClientEvent("BjornSound:joined", src, speakers)
end)



RegisterServerEvent('BjornSound:switchVideo')
AddEventHandler('BjornSound:switchVideo', function(id, videoStatus, time)
    local src = source
    TriggerClientEvent("BjornSound:switchVideoClient", -1, id, videoStatus, time)
    speakers[id].switch = true
    speakers[id].videoStatus = videoStatus
    speakers[id].time = time - speakers[id].time
end)



RegisterServerEvent('BjornSound:changeVol')
AddEventHandler('BjornSound:changeVol', function(id, vol)
    local src = source
    speakers[id].volval = vol
    TriggerClientEvent("BjornSound:changeVolClient", -1, id, vol)
end)