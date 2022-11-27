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
Tunnel.bindInterface("crafting",cRP)
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCrafting",function(data,cb)
	local inventoryCraft,inventoryUser,weight,maxweight,infos = vSERVER.requestCrafting(data.craft)
	if inventoryCraft then
		cb({ inventoryCraft = inventoryCraft, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionCraft",function(data,cb)
	vSERVER.functionCrafting(data.index,data.craft,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionDestroy",function(data,cb)
	vSERVER.functionDestroy(data.index,data.craft,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("crafting:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("crafting:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateCrafting(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Update")
AddEventHandler("crafting:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
    { 68.88,-1570.04,29.6,"generalCrafting"},
    { 2662.41,3468.25,55.95,"ilegalCrafting" },
    { -883.07,-436.57,39.6,"MotoclubCrafting" },
	{ 48.52,-1594.3,29.6,"BahamasCrafting" },

	{ 92.01,-227.37,49.44,"metanfetamina" }, --92.01,-227.37,49.44,249.44
	{ 87.5, -229.01, 48.95,"md" },
	{ 78.41, -215.55, 48.98,"maconha" },
	{ 89.89, -225.77, 48.98,"lean" },
	{ 88.58, -225.52, 48.97,"coca" },
	{ 18.23, -1110.59, 29.8,"armaReciclagem" },

	{ 72.46, -220.35, 48.96,"lavagem" },
	{ -1441.67, -3305.29, 13.95,"muni" },
	{ -1277.29, -3429.32, 13.95,"armasvip" },

	--chaves ORGS

	{1407.63, -28.34, 121.0,"keyBarragem"},
	{81.35, -1965.8, 18.05,"keyGrove"},
	{395.14, -20.71, 91.94,"keyMafia"},




    { 1275.74,-1710.31,54.76,"mafiaCrafting" },
    { 839.78,-975.81,26.49,"mecanicoCrafting" },
    { 1593.14,6455.61,26.02,"avalanchesCrafting" },
	-- { 84.17,-1552.07,29.6,"lixeiroShop" },
	{ 713.89,-961.52,30.4,"dressMaker" },
	{ 169.56,-1634.05,29.28,"foodMarket" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(craftList) do
		table.insert(innerTable,{ v[1],v[2],v[3],1.25,"E","Loja de Criação","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(craftList) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.25 then
					timeDistance = 4

					if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[4]) then
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showNUI", name = tostring(v[4]) })
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:MECHANICSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:mechanicCraft",function()
	if vSERVER.requestPerm("mechanicCraft") then
		SendNUIMessage({ action = "showNUI", name = tostring("mechanicCraft")})
		SetNuiFocus(true,true)
	end
end)