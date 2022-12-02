

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
Tunnel.bindInterface("login",cRP)
vSERVER = Tunnel.getInterface("login")
local vCREATIVE = Tunnel.getInterface("creative")


-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = nil
local new = false
local weight = 270.0
local select = false
local x1,y1,z1 = nil,nil,nil

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
local config = {
	["armadillo"] = { -861.11, -1225.7, 6.22 },
	["duluoz"] = { 112.66, -878.76, 30.58 },
	["eclipse"] = { 216.62, -804.22, 30.79 },
	["grapeseed"] = { -361.48, -891.32, 31.08 },
	["greatocean"] = { 594.75, 2743.64, 42.03 },
	["hawick"] = { -139.26, 6354.61, 31.5},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("login:Spawn")
AddEventHandler("login:Spawn",function(status)
	local ped = PlayerPedId()
	if status then
		
		x1,y1,z1 = table.unpack(GetEntityCoords(ped))

		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",x1,y1,z1 + 200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(cam,true)

		RenderScriptCams(true,false,1,true,true)

		SetNuiFocus(true,true)
		SendNUIMessage({ display = true })
	else
		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)

		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam,false)
		DestroyCam(cam,true)
		cam = nil
	end

	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("spawn",function(data,cb)
	local ped = PlayerPedId()
	local soruce = soruce

	if data.choice == "spawn" then
		if select then
			SetNuiFocus(false)
			SendNUIMessage({ display = false })
			vCREATIVE.verificar(source)
			DoScreenFadeOut(1000)
			Citizen.Wait(1000)

			SetEntityVisible(ped,true,false)
			FreezeEntityPosition(ped,false)
			SetEntityInvincible(ped,false)

			RenderScriptCams(false,false,0,true,true)
			SetCamActive(cam,false)
			DestroyCam(cam,true)
			cam = nil

			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
			SetEntityCoords(ped,config[data.choice][1],config[data.choice][2],config[data.choice][3]+0.5)
		end
	elseif data.choice == 'ultimalocalizacao' then
		SetNuiFocus(false)
		SendNUIMessage({ display = false })
		vCREATIVE.verificar(source)
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)

		SetEntityVisible(ped,true,false)
		FreezeEntityPosition(ped,false)
		SetEntityInvincible(ped,false)

		RenderScriptCams(false,false,0,true,true)
		SetCamActive(cam,false)
		DestroyCam(cam,true)
		cam = nil

		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		--print(x1,y1,z1)
		SetEntityCoords(ped,x1,y1,z1)
		

	else
		select = true
    	new = false
		local speed = 0.7

		DoScreenFadeOut(500)
		Citizen.Wait(500)

		SetCamRot(cam,270.0)
		SetCamActive(cam,true)
		new = true
		weight = 270.0

		DoScreenFadeIn(500)

		SetEntityCoords(ped,config[data.choice][1],config[data.choice][2],config[data.choice][3]+0.5)
		local x,y,z = table.unpack(GetEntityCoords(ped))
		SetCamCoord(cam,x,y,z+200.0)
		local i = z + 200.0

		while i > config[data.choice][3] + 1.5 do
			Citizen.Wait(5)
			i = i - speed
			SetCamCoord(cam,config[data.choice][1],config[data.choice][2],i)

			if i <= config[data.choice][3] + 35.0 and weight < 360.0 then
				if speed - 0.0078 >= 0.05 then
					speed = speed - 0.0078
				end

				weight = weight + 0.75
				SetCamRot(cam,weight)
			end

			if not new then
				break
			end
		end
	end

	cb("ok")
end)