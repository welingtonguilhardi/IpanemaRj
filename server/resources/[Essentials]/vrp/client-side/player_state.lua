-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getModelPlayer() --declarar todas skins
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("s_f_y_scrubs_01") then
		return "s_f_y_scrubs_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_m_boatstaff_01") then
		return "mp_m_boatstaff_01"	
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPOSITIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getPositions() --pega a posição do player
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	return vRPserver.mathLegth(coords.x),vRPserver.mathLegth(coords.y),vRPserver.mathLegth(coords.z),vRPserver.mathLegth(GetEntityHeading(ped))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.applySkin(model)
	local mHash = model

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mHash) then
		SetPlayerModel(PlayerId(),mHash)
		SetModelAsNoLongerNeeded(mHash)
	end

	SetPedComponentVariation(PlayerPedId(),1,0,0,2)
end

