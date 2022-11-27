-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("inventory",func)
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local currentWeapon = nil
local currentWeaponModel = nil
local takingWeapon = false
local pneunamao = false
local pneu = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEWEAPONN
-----------------------------------------------------------------------------------------------------------------------------------------
local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"PISTOL":"0x1B06D571","PISTOL_MK2":"0xBFE256D4","COMBATPISTOL":"0x5EF9FEC4","APPISTOL":"0x22D8FE39","STUNGUN":"0x3656C8C1","PISTOL50":"0x99AEEB3B","SNSPISTOL":"0xBFD21232","SNSPISTOL_MK2":"0x88374054","HEAVYPISTOL":"0xD205520E","VINTAGEPISTOL":"0x83839C4","FLAREGUN":"0x47757124","MARKSMANPISTOL":"0xDC4DB296","REVOLVER":"0xC1B3C3D1","REVOLVER_MK2":"0xCB96392F","DOUBLEACTION":"0x97EA20B8","RAYPISTOL":"0xAF3696A1"},"smg":{"MICROSMG":"0x13532244","SMG":"0x2BE6766B","SMG_MK2":"0x78A97CD0","ASSAULTSMG":"0xEFE7E2DF","COMBATPDW":"0xA3D4D34","MACHINEPISTOL":"0xDB1AA450","MINISMG":"0xBD248B55","RAYCARBINE":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"ASSAULTRIFLE":"0xBFEFFF6D","ASSAULTRIFLE_MK2":"0x394F415C","CARBINERIFLE":"0x83BF0278","CARBINERIFLE_MK2":"0xFAD1F1C9","ADVANCEDRIFLE":"0xAF113F99","SPECIALCARBINE":"0xC0A3098D","SPECIALCARBINE_MK2":"0x969C3D67","BULLPUPRIFLE":"0x7F229F94","BULLPUPRIFLE_MK2":"0x84D6FAFD","COMPACTRIFLE":"0x624FE830"},"MACHINE_GUNS":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}')

Citizen.CreateThread(function()
	while true do
		local slyphe = 500
		local ped = PlayerPedId()
		local player = GetPlayerPed(-1)
		local status = {}
		if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
			slyphe = 1
			if IsPedShooting(player) then
				vSERVER.fireStress()
				vSERVER.fire()
				local weapon = GetSelectedPedWeapon(player)
				local ammoTotal = GetAmmoInPedWeapon(player,weapon)

				for key,value in pairs(AllWeapons) do
					for keyTwo,valueTwo in pairs(AllWeapons[key]) do
						if weapon == GetHashKey('weapon_'..keyTwo) then
							vSERVER.updateWeaponAmmo("WEAPON_"..keyTwo,ammoTotal)
						end
					end
				end
			end
		end
		Citizen.Wait(slyphe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data,cb)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
	vRP._removeObjects(source)
	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.closeInventory()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
	vRP._removeObjects(source)
	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	vRP._removeObjects(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("inventory:moc",function(source,args)
	if not IsPlayerFreeAiming(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 101 then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "showMenu" })
		TriggerEvent("sounds:source","chest",0.7)
		vRP._createObjects("amb@world_human_stand_mobile@female@text@base","base","p_michael_backpack_s",49,28422)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("inventory:moc","Abrir a mochila","keyboard","oem_3")
-- oem_3
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
		-- RemoveAllPedWeapons(ped, false)
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerServerEvent("inventory:dropItem",data.item,data.amount,true)
	else
		TriggerServerEvent("inventory:dropItem",data.item,data.amount,true)
	end
end)
-- RegisterCommand('a', function(source) 
-- 	RemoveAllPedWeapons(PlayerPedId(), true)
-- end)
function func.dropItem(item,amount)
	TriggerServerEvent("inventory:dropItem",item,amount,false)
end
function func.getItem(source)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_WRENCH") then
		return true
	else
		return false
	end	
end
function func.weaponItem(itemName)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey(itemName) then  
		-- GiveWeaponToPed(ped, GetHashKey("WEAPON_UNARMED"), true, false)
		-- SetPedAmmo(ped, GetHashKey("WEAPON_UNARMED"))
		--TriggerEvent("Notify","vermelho","Arma desequipada",5000)
		vSERVER.notifyarma(itemName,'Guardou')
		SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
	else
		GiveWeaponToPed(ped, GetHashKey(itemName), false, false)
		--TriggerEvent("Notify","verde","Arma equipada",5000)
		vSERVER.notifyarma(itemName,'Equipou')
		-- SetPedAmmo(ped, GetHashKey(itemName))
		SetCurrentPedWeapon(ped, GetHashKey(itemName), true)
	end	
end
function func.setUNARMED()
	local ped = PlayerPedId()
	SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
	RemoveAllPedWeapons(ped, true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem",function(data)
	if data.amount > 0 then
		TriggerServerEvent("itemdrop:Pickup",data.id,data.target,data.amount)
	else
		TriggerEvent("Notify","vermelho","Não é possível pegar um valor negativo.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local droplist = {}
local cooldown = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Remove")
AddEventHandler("itemdrop:Remove",function(id)
	if droplist[id] ~= nil then
		droplist[id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Players")
AddEventHandler("itemdrop:Players",function(id,marker)
	droplist[id] = marker
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDROP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itemdrop:Update")
AddEventHandler("itemdrop:Update",function(status)
	droplist = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(droplist) do
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
            local distance = #(coords - vector3(v.x,v.y,cdz))
            if distance <= 50 then
               timeDistance = 4
			   DrawMarker(23,v.x,v.y,cdz + 0.05,0.0,0.0,0.0,0.0,180.0,0.0,0.15,0.15,0.0,255,255,255,50,0,0,0,0)
			   DrawMarker(21,v.x,v.y,cdz + 0.25,0.0,0.0,0.0,0.0,180.0,0.0,0.20,0.20,0.20,42,137,255,125,0,0,0,1)
			end
        end

        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	TriggerServerEvent("inventory:useItem",data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped,1) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
		-- RemoveAllPedWeapons(ped, false)
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerServerEvent("inventory:sendItem",data.item,data.amount)
	else
		TriggerServerEvent("inventory:sendItem",data.item,data.amount)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped) or IsPedArmed(ped,2) or IsPedArmed(ped,4) then
		-- RemoveAllPedWeapons(ped, false)
		currentWeapon = nil
		currentWeaponModel = nil
		TriggerServerEvent("inventory:updateSlot",data.item,data.slot,data.target,data.amount)
	else
		TriggerServerEvent("inventory:updateSlot",data.item,data.slot,data.target,data.amount)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local dropItems = {}
	for k,v in pairs(droplist) do
		local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
--		print("A")
		if GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true) <= 1.5 then
--			print("B")
--			print(v.desc)
			table.insert(dropItems,{economy = v.economy, unity = v.unity, tipo = v.tipo, desc = v.desc, name = v.name, key = v.name, durability = v.durability, amount = v.count, index = v.index, peso = v.peso, desc = v.desc, id = k })
		end
	end

	local inventario,peso,maxpeso,infos = vSERVER.Mochila()
	if inventario then
		cb({ inventario = inventario, drop = dropItems, peso = peso, maxpeso = maxpeso, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- inventory:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local plateX = -1133.31
local plateY = 2694.2
local plateZ = 18.81
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(plateX,plateY,plateZ))
			if distance <= 50.0 then
				timeDistance = 4
				DrawMarker(23,plateX,plateY,plateZ-0.98,0,0,0,0,0,0,5.0,5.0,1.0,255,0,0,50,0,0,0,0)
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function func.plateDistance()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(plateX,plateY,plateZ))
			if distance <= 3.0 then
				FreezeEntityPosition(vehicle,true)
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - COLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.plateApply(plate)
    local ped = PlayerPedId()
    local vehicle = GetPlayersLastVehicle()
    if IsEntityAVehicle(vehicle) then
        SetVehicleNumberPlateText(vehicle,plate)
        FreezeEntityPosition(vehicle,false)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRES - CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkBurstTyres(index)
    if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			local tires_burst = false
			for i=0,8 do
				local burst = IsVehicleTyreBurst(v,i,false)
				if burst then tires_burst = true return end
			end

			if not tires_burst then
				return true
			else
				-- TriggerEvent("Notify","vermelho","Você precisa arrumar os pneus primeiro.")
				return false
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle",function(index,status)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			local fuel = GetVehicleFuelLevel(v)
			if status then
				SetVehicleFixed(v)
				SetVehicleDeformationFixed(v)
			end
			SetVehicleBodyHealth(v,1000.0)
			SetVehicleEngineHealth(v,1000.0)
			SetVehiclePetrolTankHealth(v,1000.0)
			SetVehicleFuelLevel(v,fuel)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRTIRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTires")
AddEventHandler("inventory:repairTires",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			for i = 0,8 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCKPICKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:lockpickVehicle")
AddEventHandler("inventory:lockpickVehicle",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,true,true)
			if GetVehicleDoorsLockedForPlayer(v,PlayerId()) == 1 then
				SetVehicleDoorsLocked(v,false)
				SetVehicleDoorsLockedForAllPlayers(v,false)
			else
				SetVehicleDoorsLocked(v,true)
				SetVehicleDoorsLockedForAllPlayers(v,true)
			end
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
			Wait(200)
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockButtons = false
function func.blockButtons(status)
	blockButtons = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if blockButtons then
			timeDistance = 4
			DisableControlAction(1,73,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,105,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,288,true)
		  --DisableControlAction(1,37,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(timeDistance)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local timeDistance = 4
-- 		DisableControlAction(1,37,true)	
-- 		Citizen.Wait(timeDistance)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.parachuteColors()
	GiveWeaponToPed(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
	SetPedParachuteTintIndex(PlayerPedId(),math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKFOUNTAIN
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkFountain()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler"),true) or DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler_dark"),true) then
		return true,"fountain"
	end

	if IsEntityInWater(ped) then
		return true,"floor"
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASHREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
local registerCoords = {}
function func.cashRegister()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(registerCoords) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 1 then
			return false,v[1],v[2],v[3]
		end
	end

	local object = GetClosestObjectOfType(coords,0.4,GetHashKey("prop_till_01"),0,0,0)
	if DoesEntityExist(object) then
		SetEntityHeading(ped,GetEntityHeading(object)-360.0)
		local coords = GetEntityCoords(object)
		return true,coords.x,coords.y,coords.z
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateRegister")
AddEventHandler("inventory:updateRegister",function(status)
	registerCoords = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.fishingStatus()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(-1859.83, -1242.39, 8.62))
	if distance <= 20 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function func.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WCOMPONENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local wComponents = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_PISTOL_MK2"] = {
		"COMPONENT_AT_PI_RAIL",
		"COMPONENT_AT_PI_FLSH_02",
		"COMPONENT_AT_PI_COMP"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_AT_SCOPE_MACRO"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02",
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_SUPP_02"
	},
	["WEAPON_COMBATPDW"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_AR_AFGRIP",
		"COMPONENT_AT_SCOPE_SMALL"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_AT_AR_FLSH"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_MACHINEPISTOL"] = {
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_AT_AR_AFGRIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		"COMPONENT_AT_PI_FLSH_03",
		"COMPONENT_AT_PI_RAIL_02",
		"COMPONENT_AT_PI_COMP_02"
	},
	["WEAPON_SMG_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_SMALL",
		"COMPONENT_AT_AR_SUPP"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_SPECIALCARBINE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	for k,v in pairs(wComponents) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tb-inventory:client:takingWeapon')
AddEventHandler('tb-inventory:client:takingWeapon', function(bool)
    takingWeapon = bool
end)

-- function func.putWeaponHands(weapon)
-- 	local ped = GetPlayerPed(-1)
-- 	local wep = GetHashKey(weapon)
-- 	if not HasPedGotWeapon(ped, GetHashKey(currentWeaponModel), false) then
-- 		currentWeapon = wep
-- 		currentWeaponModel = weapon
-- 		GiveWeaponToPed(ped, wep, 0, false, true)
-- 		-- Citizen.Wait(1000)
-- 	else
-- 		-- RemoveAllPedWeapons(ped, true)
-- 		-- currentWeapon = nil
-- 		-- currentWeaponModel = nil
-- 	end
-- end

-- function func.removeWeaponInHand()
-- 	local ped = GetPlayerPed(-1)
-- 	if HasPedGotWeapon(ped, GetHashKey(currentWeaponModel), false) then
-- 		RemoveWeaponFromPed(ped, GetHashKey(currentWeaponModel))
-- 		currentWeapon = nil
-- 		currentWeaponModel = nil
-- 		-- TriggerEvent('inventory:takingWeapon', false)		
-- 	end
-- end

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON_AMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_ammos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_COMPACTRIFLE",
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_ASSAULTSMG",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_CARBINERIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_SAWNOFFSHOTGUN"
	},
-- START OTHERS
    ["WEAPON_RPG_AMMO"] = {
		"WEAPON_RPG"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
-- END OTHERS
}
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- RECHARGEWEAPON
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function func.rechargeCheck(ammoType)
-- 	local ped = PlayerPedId()
-- 	if weapon_ammos[ammoType] then
-- 		for k,v in pairs(weapon_ammos[ammoType]) do
-- 			if HasPedGotWeapon(ped,v) then
-- 				return true
-- 			end
-- 		end
-- 	end
-- 	return false
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- RECHARGEWEAPON
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function func.rechargeWeapon(ammoType,ammoAmount)
-- 	local ped = PlayerPedId()
-- 	if weapon_ammos[ammoType] then
-- 		for k,v in pairs(weapon_ammos[ammoType]) do
-- 			if HasPedGotWeapon(ped,v) then
-- 				SetPedAmmo(ped, v, ammoAmount) -- deleting ammo from clip.
-- 				return true
-- 			end
-- 		end
-- 	end
-- 	return false
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- RECHARGEWEAPON
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function func.rechargeWeapon2(ammoType,ammoAmount)
-- 	local ped = PlayerPedId()
-- 	local targetWeapon = GetSelectedPedWeapon(ped) -- getting target weapon.
-- 	local targetWeaponAmmo = GetAmmoInPedWeapon(ped, targetWeapon) -- getting target weapon ammo.
-- 	local currentAmmo = targetWeaponAmmo -- variable that will keep our target weapon current ammo.
-- 	local ped = PlayerPedId()
-- 	SetPedAmmo(ped, targetWeapon, ammoAmount) -- deleting ammo from clip.
-- 	return true
-- end




-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function func.verifyAmmoType(ammoType)
	local ped = PlayerPedId()
	if weapon_ammos[ammoType] then
		return weapon_ammos[ammoType]
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function func.rechargeCheck(ammoType)
	local ped = PlayerPedId()
	--print(GetSelectedPedWeapon(ped))
	--print(GetHashKey(weapon_ammos[ammoType][1]))
	for k,v in pairs(weapon_ammos[ammoType]) do
		 if GetHashKey(v) == GetSelectedPedWeapon(ped) then
			for k,v in pairs(weapon_ammos[ammoType]) do
				if HasPedGotWeapon(ped,v) then
					return true
				end
			end
			return false
		 end	
	end	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function func.rechargeWeapon(ammoType,ammoAmount)
	local ped = PlayerPedId()
	if weapon_ammos[ammoType] then
		for k,v in pairs(weapon_ammos[ammoType]) do
			if HasPedGotWeapon(ped,v) then
				AddAmmoToPed(ped,v,parseInt(ammoAmount))
				return true
			end
		end
	end
	return false
end















-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINEDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local adrenalineCds = {
	{ 1978.76,5171.11,47.64 },
	{ 707.86,4183.95,40.71 },
	{ 436.64,6462.23,28.75 },
	{ -2173.5,4291.73,49.04 }
}

function func.adrenalineDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(adrenalineCds) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 5 then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local firecracker = nil
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker",function()
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			RequestNamedPtfxAsset("scr_indep_fireworks")
			Citizen.Wait(10)
		end
	end

	local mHash = GetHashKey("ind_prop_firework_03")

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	local explosives = 25
	local ped = PlayerPedId()
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.6,0.0)
	firecracker = CreateObjectNoOffset(mHash,coords.x,coords.y,coords.z,true,false,false)

	PlaceObjectOnGroundProperly(firecracker)
	FreezeEntityPosition(firecracker,true)
	SetModelAsNoLongerNeeded(mHash)

	Citizen.Wait(10000)

	repeat
		UseParticleFxAssetNextCall("scr_indep_fireworks")
		local explode = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",coords.x,coords.y,coords.z,0.0,0.0,0.0,2.5,false,false,false,false)
		explosives = explosives - 1

		Citizen.Wait(2000)
	until explosives == 0

	TriggerServerEvent("tryDeleteEntity",ObjToNet(firecracker))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TECHDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.techDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(1174.66,2640.45,37.82))
	if distance <= 10 then
		return true
	end
	return false
end





-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRUMAR PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mike:pneunamao")
AddEventHandler("mike:pneunamao",function()
    if not pneunamao then
		local ped = PlayerPedId()
		local source = source
		if ped then
			if GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_UNARMED') and not IsPedInAnyVehicle(ped) then
				func.closeInventory(source)
        		vRP._createObjects("anim@heists@box_carry@","idle","prop_wheel_tyre",50,28422)
				pneunamao = not pneunamao
			end
		end
    else
        TriggerEvent('cancelando',false)
        vRP._stopAnim(false)
        vRP.vRP._removeObjects(source)
        pneunamao = false
        pneu = {}
        FreezeEntityPosition(ped,false)
    end
end)

RegisterNetEvent("roubarpneu")
AddEventHandler("roubarpneu",function()
	local roubarpneu = 0
	while func.getItem(source) do
		if roubarpneu == 1 then	
			break
		end	
        sleep = 1000
        local ped = PlayerPedId()
            sleep = 5            
            if ped then
                local veh,vnetid,placa,vname,lock,banned,work = vRP.vehList(7)
                if veh and not lock then

                    if IsVehicleTyreBurst(veh,0,false) then
						pneu[0] = nil
					else
						pneu[0] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_lf"))
                    end
                    if IsVehicleTyreBurst(veh,1,false) then
						pneu[1] = nil
					else
                        pneu[1] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_rf"))
                    end
                    if IsVehicleTyreBurst(veh,4,false) then
						pneu[4] = nil
					else
                        pneu[4] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_lr"))

                    end
                    if IsVehicleTyreBurst(veh,5,false) then
						pneu[5] = nil
					else
                        pneu[5] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_rr"))

                    end
                    if IsVehicleTyreBurst(veh,2,false) then
						pneu[2] = nil
					else
                        pneu[2] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_lm"))

                    end
                    if IsVehicleTyreBurst(veh,3,false) then
						pneu[3] = nil
					else
                        pneu[3] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_rm"))
                    end

                    for k,v in pairs(pneu) do
                        if pneu[k] then
                            DrawText3Ds(pneu[k].x,pneu[k].y,pneu[k].z+0.80,"~b~[E] ~w~ROUBAR")
                            local x,y,z = table.unpack(GetEntityCoords(ped))
                            local bowz,cdz = GetGroundZFor_3dCoord(pneu[k].x,pneu[k].y,pneu[k].z)
                            local distance = GetDistanceBetweenCoords(pneu[k].x,pneu[k].y,cdz,x,y,z,true)

                            if distance < 1.2 then
                                if IsControlJustPressed(0,38) then
									vRP._playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
									if vSERVER.skillbar() then                                            
										vSERVER.estouraPneu(VehToNet(veh),k)
										vSERVER.givePneuRoubado(source)
										roubarpneu = 1
										vRP._stopAnim(false)
										Citizen.Wait(2000)
										vRP._createObjects("anim@heists@box_carry@","idle","prop_wheel_tyre",50,28422)
										SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
										TriggerEvent("Progress",10000)
										Citizen.Wait(10000)
										vRP._removeObjects()
										TriggerEvent("Notify","verde","Pneu guadado.",5000)
									else
										TriggerEvent("Notify","vermelho","Você falhou.",5000)
										vRP._stopAnim(false)
									end	

								end
							end
						end				
					end
				end
			end
			Citizen.Wait(sleep)	
	end								
end)	









-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        if pneunamao then
            sleep = 5            
            if ped then
                local veh,vnetid,placa,vname,lock,banned,work = vRP.vehList(7)
                if veh then

                    if IsVehicleTyreBurst(veh,0,false) then
                        pneu[0] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_lf"))
                    elseif pneu[0] then
                        pneu[0] = nil
                    end
                    if IsVehicleTyreBurst(veh,1,false) then
                        pneu[1] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_rf"))
                    elseif pneu[1] then
                        pneu[1] = nil
                    end
                    if IsVehicleTyreBurst(veh,4,false) then
                        pneu[4] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_lr"))
                    elseif pneu[4] then
                        pneu[4] = nil
                    end
                    if IsVehicleTyreBurst(veh,5,false) then
                        pneu[5] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_rr"))
                    elseif pneu[5] then
                        pneu[5] = nil
                    end
                    if IsVehicleTyreBurst(veh,2,false) then
                        pneu[2] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_lm"))
                    elseif pneu[2] then
                        pneu[2] = nil
                    end
                    if IsVehicleTyreBurst(veh,3,false) then
                        pneu[3] = GetWorldPositionOfEntityBone(veh,GetEntityBoneIndexByName(veh,"wheel_rm"))
                    elseif pneu[3] then
                        pneu[3] = nil
                    end

                    for k,v in pairs(pneu) do
                        if pneu[k] then
                            DrawText3Ds(pneu[k].x,pneu[k].y,pneu[k].z+0.80,"~b~[E] ~w~ARRUMAR")
                            local x,y,z = table.unpack(GetEntityCoords(ped))
                            local bowz,cdz = GetGroundZFor_3dCoord(pneu[k].x,pneu[k].y,pneu[k].z)
                            local distance = GetDistanceBetweenCoords(pneu[k].x,pneu[k].y,cdz,x,y,z,true)

                            if distance < 1.2 then
                                if IsControlJustPressed(0,38) then
                                    FreezeEntityPosition(ped,true)
                                    vRP._playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
                                    TriggerEvent('cancelando',true)
                                    vRP._removeObjects()
                                    if IsVehicleTyreBurst(veh,k,true) then
                                        if vSERVER.skillbar() then
                                            pneu[k] = nil
                                            pneunamao = false
                                            vRP._stopAnim(false)
                                            vRP._removeObjects()
                                            TriggerEvent('cancelando',false)
                                            TriggerEvent("Notify", "sucesso", "Pneu substituido!",5000)
                                            FreezeEntityPosition(ped,false)
					    vSERVER.retiraPneu(VehToNet(veh),k)
                                        else
                                            TriggerEvent("Notify", "negado", "Você não conseguiu colocar o novo pneu.",5000)
                                            vRP._stopAnim(false)
                                            vRP._removeObjects()
                                            pneunamao = false
                                            pneu = {}
                                            TriggerEvent('cancelando',false)
                                            FreezeEntityPosition(ped,false)
                                        end
                                    else
                                        if vSERVER.skillbar() then                                            
					    vSERVER.estouraPneu(VehToNet(veh),k)
                                            TriggerEvent("Notify", "sucesso", "Pneu velho retirado, colocando novo pneu.",5000)
                                            if vSERVER.skillbar() then                                                                
                                                vRP._stopAnim(false)
                                                vRP._removeObjects()
                                                pneunamao = false
                                                pneu = {}
                                                TriggerEvent('cancelando',false)
                                                TriggerEvent("Notify", "sucesso", "Pneu substituido!")												
                                                FreezeEntityPosition(ped,false)
						vSERVER.retiraPneu(VehToNet(veh),k) 
                                            else
                                                TriggerEvent("Notify", "negado", "Você não conseguiu colocar o novo pneu.",5000)
                                                vRP._stopAnim(false)
                                                vRP._removeObjects()
                                                pneunamao = false
                                                pneu = {}
                                                TriggerEvent('cancelando',false)
                                                FreezeEntityPosition(ped,false)
                                            end
                                        else
                                            TriggerEvent("Notify", "negado", "Você não conseguiu tirar o pneu velho.",5000)
                                            vRP._stopAnim(false)
                                            vRP._removeObjects()
                                            pneunamao = false
                                            pneu = {}
                                            TriggerEvent('cancelando',false)
                                            FreezeEntityPosition(ped,false)
                                        end
                                    end
                                end
                            end
                        end
                    end

                else
                    TriggerEvent("Notify", "negado", "Você não está perto de nenhum veículo.",5000)
                    vRP._stopAnim(false)
                    vRP._removeObjects()
                    pneunamao = false
                    pneu = {}
                    TriggerEvent('cancelando',false)
                    FreezeEntityPosition(ped,false)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRUMA PNEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('finalizarTroca')
AddEventHandler('finalizarTroca', function(index,pneu)
	if NetworkDoesEntityExistWithNetworkId(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			SetVehicleTyreFixed(v,pneu,true,0.0)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURA PNEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('retiraPneu')
AddEventHandler('retiraPneu', function(index,pneu)
	if NetworkDoesEntityExistWithNetworkId(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			SetVehicleTyreBurst(v,pneu,true,1000.0)
		end
	end
end)

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end