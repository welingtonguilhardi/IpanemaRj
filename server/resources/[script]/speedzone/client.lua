-- Leaked by Luxury Leaks
-- discord.gg/luxury-leaks
local ZonelimitN = false
local ZonelimitO = false
local closestZone = 1

--[[Citizen.CreateThread(function()
	for i = 1, #Config.zones, 1 do
	local blip = AddBlipForRadius(Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, Config.radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 11)
	SetBlipAlpha (blip, 128)
    local blip1 = AddBlipForCoord(x, y, z)
	SetBlipSprite (blip1, sprite)
	SetBlipDisplay(blip1, true)
	SetBlipScale  (blip1, 0.9)
	SetBlipColour (blip1, 11)
    SetBlipAsShortRange(blip1, true)
	end
end)--]]

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		Citizen.Wait(10000)
		for i = 1, #Config.zones, 1 do
			dist = Vdist(Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local player = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(Config.zones[closestZone].x, Config.zones[closestZone].y, Config.zones[closestZone].z, x, y, z)
		local vehicle = GetVehiclePedIsIn(player, false)
		local speed = GetEntitySpeed(vehicle)
		if dist <= Config.radius then
			if not ZonelimitN then
				ZonelimitN = true
				ZonelimitO = false
			end
		else
			if not ZonelimitO then
				if Config.speedlimitador then
				SetVehicleMaxSpeed(vehicle, 1000.00)
				end
				ZonelimitO = true
				ZonelimitN = false
			end
			Citizen.Wait(200)
		end
	if ZonelimitN then
		Citizen.Wait(10)
		if Config.speedlimitador then
		mphs = 2.237
		maxspeed = Config.speedlimitador/mphs
		SetVehicleMaxSpeed(vehicle, maxspeed)
		end

	end
end
end)

