Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1500)
        local ped = PlayerPedId()
		local distance = GetDistanceBetweenCoords(94.66, -854.02, 31.05,GetEntityCoords(ped),true)		
		if distance < 510 then			
			while true do
				Citizen.Wait(10)
				distance = GetDistanceBetweenCoords(94.66, -854.02, 31.05,GetEntityCoords(ped),true)
				if distance > 150 then
					break
				end
				xpkMarker2(92.95, -853.89, 32.39, 14.0, 5.0, 35, "xpkmarker", "xpika")			
			end					
		end
	end
end)

function xpkMarker2(x, y, z, sizex, sizey, sizez, src, id)
    if not HasStreamedTextureDictLoaded(src) then
        RequestStreamedTextureDict(src, true)
        while not HasStreamedTextureDictLoaded(src) do
            Wait(1)
        end
    else
        DrawMarker(9, x, y, z, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, sizex, sizey, sizez, 255, 255, 255, 255,false, true, 2, false, src, id, false)
    end
end
