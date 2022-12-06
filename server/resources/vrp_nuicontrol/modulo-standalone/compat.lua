-- AO MENOS UM DESSES ABAIXO PRECISA ESTAR COMO TRUE PARA UTILIZAÇÃO DO ID
-- Atenção: Caso o mesmo seja selecionado o jogador será obrigado a possuir o id.

-- Steam: terá que abrir a steam antes de entrar no servidor.
-- Discord: terá que vincular o discord ao fivem antes de entrar no servidor.
-- License: todos jogadores possuem essa licença, então não precisa de nada para entrar.

-- ATENÇÃO: CASO VOCÊ SELECIONE ALGUMA DAS 3 OPÇÕES VOCÊ TAMBÉM DEVERÁ ADICIONAR O ID CORRETO NO SERVER.CFG PARA CRIAR AS PERMISSÕES

--[[

# Como deve ser adicionado se for utilizar a STEAM:

add_ace group.admin "flux.bypass" allow
add_ace group.admin "flux.admin" allow
add_principal identifier.steam:000000000000000 group.admin

# Como deve ser adicionado se for utilizar o DISCORD:

add_ace group.admin "flux.bypass" allow
add_ace group.admin "flux.admin" allow
add_principal identifier.discord:000000000000000000 group.admin

# Como deve ser adicionado se for utilizar a LICENÇA CFX:

add_ace group.admin "flux.bypass" allow
add_ace group.admin "flux.admin" allow
add_principal identifier.discord:000000000000000000 group.admin

--]]

local userSteamWithID = true -- PADRÃO
local userDiscordWithID = false
local userLicenseWithID = false

FluxCompat = {}
banSystem = {}
local sourceList = {}

local function get_user_identifiers(user_id)
    local source = FluxCompat.getUserSource(user_id)
    return source and GetPlayerIdentifiers(source) or { user_id }
end

local function get_player_identifiers_query_params(player_identifiers)
    local params = {}
    for i, identifier in ipairs(player_identifiers) do
        params["@player_" .. identifier:split(":")[1]] = identifier
    end

    return params
end

function banSystem.start()
    MySQL.ready(function ()
        Wait(5000)
        local res = MySQL.Sync.fetchScalar("show tables like 'flux_bans';", {})
        if not res then
            MySQL.Async.execute([[
                CREATE TABLE IF NOT EXISTS flux_bans (
                    id CHAR(36) PRIMARY KEY,
                    player_license CHAR(48) UNIQUE,
                    player_steam CHAR(21) UNIQUE,
                    player_discord CHAR(26) UNIQUE,
                    player_fivem VARCHAR(20) UNIQUE,
                    player_live CHAR(20) UNIQUE,
                    player_xbl CHAR(20) UNIQUE
                );
            ]])
        end
    end)

    AddEventHandler("playerConnecting", function (name, setMessage, deferrals)
        local src = source
        deferrals.defer()
        local player_identifiers = GetPlayerIdentifiers(tonumber(src))

        -- userSteamWithID
        local steamid  = nil
        local license  = nil
        local discord  = nil
    
        for k,v in pairs(player_identifiers)do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamid = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            end  
        end

        if userSteamWithID and not steamid then
            deferrals.done("[Flux Anticheat] Você precisa estar com a steam aberta para entrar no servidor.")
            return nil
        end

        if userDiscordWithID and not discord then
            deferrals.done("[Flux Anticheat] Você precisa estar com o discord vinculado ao FiveM para acessar o servidor.")
            return nil
        end

        if userLicenseWithID and not license then
            deferrals.done("[Flux Anticheat] Falha ao identificar o código da sua licença FiveM.")
            return nil
        end

        if #player_identifiers > 0 then
            local ban_id = banSystem.getBanId(player_identifiers)
            if ban_id then
                deferrals.done(("[Flux Anticheat] Você está banido (ban_id = %s)"):format(ban_id))
            else
                local user_id = FluxCompat.getUserId(src)
                deferrals.done()
            end
        end
    end)
end

function banSystem.getBanId(player_identifiers)
    return MySQL.Sync.fetchScalar([[
        SELECT id FROM flux_bans WHERE
            player_license = @player_license
            OR player_steam = @player_steam
            OR player_discord = @player_discord
            OR player_fivem = @player_fivem
            OR player_live = @player_live
            OR player_xbl = @player_xbl
    ]], get_player_identifiers_query_params(player_identifiers))
end

function banSystem.isBanned(player_identifiers)
    return MySQL.Sync.fetchScalar([[
        SELECT EXISTS(
            SELECT * FROM flux_bans WHERE
                player_license = @player_license
                OR player_steam = @player_steam
                OR player_discord = @player_discord
                OR player_fivem = @player_fivem
                OR player_live = @player_live
                OR player_xbl = @player_xbl
        );
    ]], get_player_identifiers_query_params(player_identifiers)) ~= 0
end

function banSystem.ban(player_identifiers)
    MySQL.Sync.execute(
        "INSERT IGNORE INTO flux_bans VALUES(UUID(), @player_license, @player_steam, @player_discord, @player_fivem, @player_live, @player_xbl);",
        get_player_identifiers_query_params(player_identifiers)
    )

    return banSystem.getBanId(player_identifiers)
end

function banSystem.unban(player_identifiers)
    MySQL.Sync.execute([[
        DELETE FROM flux_bans WHERE
            player_license = @player_license
            OR player_steam = @player_steam
            OR player_discord = @player_discord
            OR player_fivem = @player_fivem
            OR player_live = @player_live
            OR player_xbl = @player_xbl;
        ]], get_player_identifiers_query_params(player_identifiers))
end

function banSystem.unbanById(id)
    MySQL.Sync.execute("DELETE FROM flux_bans WHERE id = @id;", { id = id })
end

function FluxCompat.start()
    if not userSteamWithID and not userDiscordWithID then
        userLicenseWithID = true
    end
    banSystem.start()
end

function FluxCompat.getUserId(src)
    local steamid  = nil
    local license  = nil
    local discord  = nil
    local user_id = nil

    for k,v in pairs(GetPlayerIdentifiers(tonumber(src)))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end  
    end

    if steamid and userSteamWithID then
        user_id = steamid
    end

    if discord and userDiscordWithID then
        user_id = discord
    end

    if license and userLicenseWithID then
        user_id = license
    end

    if not sourceList[user_id] then
        sourceList[user_id] = src
    end

    return user_id
end

function FluxCompat.getUserSource(user_id)
    return sourceList[user_id]
end

function FluxCompat.getUserIdentity(user_id)
    local src = FluxCompat.getUserSource(user_id)
    local firstname = GetPlayerName(src)
    return {
        user_id = user_id,
        registration = "000AAA",
        firstname = firstname,
        name = '',
    }
end

function FluxCompat.hasPermission(user_id, permission)
    local src = FluxCompat.getUserSource(user_id)
    -- print('CHECK ACE PERM: '..user_id..' / perm: '..permission..' / source: '..src)
    if src then
        -- print('CHECK ACE PERM ALLOWED: '..user_id..' / perm: '..permission)
        return IsPlayerAceAllowed(src, permission)
    end
    return false
end

function FluxCompat.setBanned(user_id, banned)
    local player_identifiers = get_user_identifiers(user_id)

    if banned then
        banSystem.ban(player_identifiers)
    else
        banSystem.unban(player_identifiers)
    end
end

function FluxCompat.isBanned(user_id)
    return banSystem.isBanned(get_user_identifiers(user_id))
end

function FluxCompat.isUserPlateOwner(user_id, plate)
    return MySQL.Sync.fetchScalar("SELECT EXISTS(SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate);", {
        ["@owner"] = user_id,
        ["@plate"] = plate
    }) ~= 0
end

function string:split(separator)
    local parts = {}
    for part in string.gmatch(self, "([^" .. (separator or "%s") .. "]+)") do
        table.insert(parts, part);
    end

    return parts
end
