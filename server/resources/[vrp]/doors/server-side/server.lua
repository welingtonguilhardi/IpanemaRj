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
Tunnel.bindInterface("doors",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = {
	[1] = { ["x"] = 361.77, ["y"] = -1584.5, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 2 },
	[2] = { ["x"] = 360.95, ["y"] = -1585.57, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 1 },
	[3] = { ["x"] = 365.63, ["y"] = -1588.71, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[4] = { ["x"] = 361.9, ["y"] = -1593.08, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[5] = { ["x"] = 368.3, ["y"] = -1596.09, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[6] = { ["x"] = 370.03, ["y"] = -1590.86, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[7] = { ["x"] = 379.03, ["y"] = -1598.43, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[8] = { ["x"] = 374.72, ["y"] = -1603.75, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[9] = { ["x"] = 383.35, ["y"] = -1603.82, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[10] = { ["x"] = 368.52, ["y"] = -1607.82, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 11 },
	[11] = { ["x"] = 369.58, ["y"] = -1606.65, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 10 },
	[12] = { ["x"] = 366.45, ["y"] = -1608.44, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[13] = { ["x"] = 364.12, ["y"] = -1606.44, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[14] = { ["x"] = 355.22, ["y"] = -1599.09, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[15] = { ["x"] = 352.74, ["y"] = -1597.14, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[16] = { ["x"] = 360.6, ["y"] = -1611.01, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[17] = { ["x"] = 362.92, ["y"] = -1612.79, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[18] = { ["x"] = 351.48, ["y"] = -1603.33, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[19] = { ["x"] = 349.17, ["y"] = -1601.64, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },

	-- [20] = { ["x"] = -630.81, ["y"] = -237.96, ["z"] = 38.1, ["hash"] = 9467943, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 21 },
	-- [21] = { ["x"] = -631.62, ["y"] = -236.92, ["z"] = 38.06, ["hash"] = 1425919976, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 20 },
	[22] = { ["x"] = -14.14, ["y"] = -1441.17, ["z"] = 31.11, ["hash"] = 520341586, ["lock"] = true, ["text"] = false, ["distance"] = 10, ["press"] = 1.5, ["perm"] = "Admin" },
	[23] = { ["x"] = 981.72, ["y"] = -102.78, ["z"] = 74.85, ["hash"] = 190770132, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "TheLost" },
	[24] = { ["x"] = 1846.049, ["y"] = 2604.733, ["z"] = 45.579, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
	[25] = { ["x"] = 1819.475, ["y"] = 2604.743, ["z"] = 45.577, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
	[26] = { ["x"] = 488.89, ["y"] = -1017.49, ["z"] = 28.15, ["hash"] = 2691149580, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "Police" },
	[27] = { ["x"] = 1274.47, ["y"] = -1720.43, ["z"] = 54.76, ["hash"] = 1145337974, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true },
	[28] = { ["x"] = 1595.79, ["y"] = 6451.34, ["z"] = 26.07, ["hash"] = -1428884643, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Avalanches", ["sound"] = true },
	[29] = { ["x"] = 1580.38, ["y"] = 6458.34, ["z"] = 26.07, ["hash"] = 861832298, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Avalanches", ["sound"] = true },
	[30] = { ["x"] = 1852.24, ["y"] = 3695.2, ["z"] = 34.22, ["hash"] = -1491332605, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "Police" },
	[31] = { ["x"] = 1849.29, ["y"] = 3693.52, ["z"] = 34.22, ["hash"] = -1491332605, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "Police" },
	[32] = { ["x"] = 1856.53, ["y"] = 3696.43, ["z"] = 34.22, ["hash"] = -1491332605, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "Police" },
	[33] = { ["x"] = -2588.32, ["y"] = 1910.89, ["z"] = 167.5, ["hash"] = 308207762, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- -2588.32, 1910.89, 167.5 westonsmansion
	[34] = { ["x"] = -2600.23, ["y"] = 1917.75, ["z"] = 167.34, ["hash"] = 224975209, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- -2600.23, 1917.75, 167.34 westonsmansion
	[35] = { ["x"] = -1987.77, ["y"] = -511.89, ["z"] = 12.18, ["hash"] = 308207762, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- -1987.77, -511.89, 12.18 casabigode
	[36] = { ["x"] = -1987.13, ["y"] = -502.9, ["z"] = 12.18, ["hash"] = 1980513646, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- -1987.13, -502.9, 12.18 casabigode
	[37] = { ["x"] = -3216.89, ["y"] = 816.58, ["z"] = 8.93, ["hash"] = 308207762, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- -3216.89, 816.58, 8.93 manssão malibu
	[38] = { ["x"] = -3217.93, ["y"] = 775.8, ["z"] = 14.09, ["hash"] = 270936785, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- -3217.93, 775.8, 14.09 manssão malibu
	[39] = { ["x"] = 407.22, ["y"] = -17.88, ["z"] = 91.94, ["hash"] = -973354389, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 407.22,-17.88,91.94 Mafia ORG
	
	[40] = { ["x"] = 427.09, ["y"] = -1.3, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 427.09, -1.3, 99.65 Mafia CASA
	[41] = { ["x"] = 420.87, ["y"] = 2.23, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 420.87, 2.23, 99.65 Mafia CASA
	[42] = { ["x"] = 411.17, ["y"] = 7.87, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 411.17, 7.87, 99.65 Mafia CASA
	[43] = { ["x"] = 429.44, ["y"] = -7.3, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 429.44, -7.3, 99.65 Mafia CASA
	[44] = { ["x"] = 425.77, ["y"] = -13.83, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 425.77, -13.83, 99.65 Mafia CASA
	[45] = { ["x"] = 422.23, ["y"] = -19.88, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 422.23, -19.88, 99.65 Mafia CASA
	[46] = { ["x"] = 416.7, ["y"] = -29.55, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 416.7, -29.55, 99.65 Mafia CASA
	[47] = { ["x"] = 411.98, ["y"] = -30.49, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 411.98, -30.49, 99.65 Mafia CASA
	[48] = { ["x"] = 402.2, ["y"] = -24.71, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 402.2, -24.71, 99.65 Mafia CASA
	[49] = { ["x"] = 396.13, ["y"] = -21.23, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 396.13, -21.23, 99.65 Mafia CASA
	[50] = { ["x"] = 396.19, ["y"] = -15.88, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 396.19, -15.88, 99.65 Mafia CASA
	[51] = { ["x"] = 401.74, ["y"] = -6.1, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 401.74, -6.1, 99.65 Mafia CASA
	[52] = { ["x"] = 405.29, ["y"] = 0.05, ["z"] = 99.65, ["hash"] = -807362247, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 405.29, 0.05, 99.65 Mafia CASA
	
	[53] = { ["x"] = 85.64, ["y"] = -1959.61, ["z"] = 21.13, ["hash"] = 1436076651, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 85.64, -1959.61, 21.13 Ballas ORG
	[54] = { ["x"] = 84.45, ["y"] = -1966.88, ["z"] = 20.94, ["hash"] = -1563640173, ["lock"] = true, ["text"] = false, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "nc.permissao" }, -- 84.45, -1966.88, 20.94 BALAS ORG


}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("sounds:source",source,"doorlock",0.1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:doorsStatistics")
AddEventHandler("doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("doors:doorsUpdate",source,doors)
end)