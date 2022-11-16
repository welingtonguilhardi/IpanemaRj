----==={ CONEXÃO }===----

Resource = GetCurrentResourceName()
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

fServer = Tunnel.getInterface(Resource)

tServer = {}
Tunnel.bindInterface(Resource,tServer)

----==={ CONFIGURAÇÕES CLIENT-SIDE }===----
RegisterNetEvent('suricato_roubos:updateRobbery')
--[[ COLAR NO SURVIVAL.LUA
    local inRobbery = false
    AddEventHandler('suricato_roubos:updateRobbery', function(bool)
        inRobbery = bool
    end)

    ONDE TEM ISSO: if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then (pode ter outra condição, mas se for vrpex, provávelmente é essa!)
    SUBSTITUA POR ISSO: if not inRobbery and GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
]]

config = {
    executeHacking = function(self, minigame)
        if minigame == 1 then 
            local state = GetResourceState('mhacking')
            if state == 'started' or state == 'starting' then 
                local p = promise.new()
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, true)
                self:blockControls(true)
                TriggerEvent('mhacking:seqstart', 4, 20, function(s, t)
                    p:resolve(s, t)
                end)
                FreezeEntityPosition(ped, false)
                self:blockControls(false)
                return Citizen.Await(p)
            end
            return true
        elseif minigame == 2 then 
            local state = GetResourceState('ultra-voltlab')
            if state == 'started' or state == 'starting' then 
                local p = promise.new()
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, true)
                self:blockControls(true)
                TriggerEvent('ultra-voltlab', 30, function(s, r)
                    p:resolve(s == 1, r)
                end)
                FreezeEntityPosition(ped, false)
                self:blockControls(false)
                return Citizen.Await(p)
            end
            return true
        end
    end,
    isAlive = function(ped)
        return GetEntityHealth(ped) > 101
    end,
    setHealth = function(entity, health) -- FUNÇÃO PARA SETAR A VIDA DO JOGADOR ( O ANTICHEAT PODE ACUSAR DE HACK O CLIENT QUE USE A NATIVA, ENTÃO SE SEU ANTICHEAT POSSUI UMA NATIVA PRÓPRIA PARA SETAR A VIDA DO JOGADOR, COLOQUE-A NA FUNÇÃO!)
        if tonumber(health) and DoesEntityExist(entity) then
            SetEntityHealth(entity, parseInt(health))
        end
    end,
    setArmour = function(entity, armour) -- FUNÇÃO PARA SETAR O COLETE DO JOGADOR ( O ANTICHEAT PODE ACUSAR DE HACK O CLIENT QUE USE A NATIVA, ENTÃO SE SEU ANTICHEAT POSSUI UM ANATIVA PRÓPRIA PARA SETAR O ARMOUR DO JOGADOR, COLOQUE-A NA FUNÇÃO )
        if tonumber(armour) and DoesEntityExist(entity) then
            SetPedArmour(entity, parseInt(armour))
        end
    end,
    stopAnim = function() -- FUNÇÃO PARA PARAR A ANIMAÇÃO DE UM PLAYER
        ClearPedTasks(PlayerPedId())
    end,
    blockControls = function(self, status)
        self.blocked = status
        CreateThread(function()
            while self.blocked do 
                BlockWeaponWheelThisFrame()
                DisablePlayerFiring(PlayerId(), true)
                DisableControlAction(0,29,true)
                DisableControlAction(0,38,true)
                DisableControlAction(0,47,true)
                DisableControlAction(0,56,true)
                DisableControlAction(0,57,true)
                DisableControlAction(0,73,true)
                DisableControlAction(0,137,true)
                DisableControlAction(0,166,true)
                DisableControlAction(0,167,true)
                DisableControlAction(0,169,true)
                DisableControlAction(0,170,true)
                DisableControlAction(0,182,true)
                DisableControlAction(0,187,true)
                DisableControlAction(0,188,true)
                DisableControlAction(0,189,true)
                DisableControlAction(0,190,true)
                DisableControlAction(0,243,true)
                DisableControlAction(0,245,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,288,true)
                DisableControlAction(0,289,true)
                DisableControlAction(0,311,true)
                DisableControlAction(0,344,true)
                Wait(0)
            end
        end)
    end,
    setInvincible = function(entity,bool) -- FUNÇÃO PARA SETAR UM JOGADOR COMO INVENCÍVEL, ISSO PODE SER BARRADO EM ALGUNS ANTICHEAT, SE ACONTECER ALGO, É POSSÍVEL COMENTAR ESSA FUNÇÃO (NÃO COMENTE O NOME, E SIM O QUE ELA FARÁ, DEIXANDO ELA VAZIA)
        if entity and type(bool) == 'boolean' then
            SetEntityInvincible(entity, bool)
        end
    end,
    setVisible = function(entity, bool) -- FUNÇÃO PARA SETAR UM JOGADOR COMO VISÍVEL/INVISÍVEL, SE SEU ANTI-CHEAT ACUSA ISSO COMO HACK, E A PERMISSÃO PARA MECHER NOS MENUS DE ADMIN NÃO TEM IMUNIDADE, PODE COMENTAR. (SÓ A PERMISSAO PARA MEXER NO MENU ADMIN VAI UTILIZAR DISSO)
        if entity and type(bool) == 'boolean' then
            SetEntityVisible(entity, bool)
        end
    end,
    format = function(n)
        local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
        return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
    end
}

function tServer.setHealth(health)
    SetEntityHealth(PlayerPedId(),parseInt(health))
end

function tServer.setPosition(vector)
    SetEntityCoords(PlayerPedId(),vector)
end

function tServer.isAlive()
    local ped = PlayerPedId()
    return (GetEntityHealth(ped) > 101)
end

return config