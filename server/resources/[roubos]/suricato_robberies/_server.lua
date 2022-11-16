local ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 = true

local function sucesso(body)
    ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 = true
    print('['.. GetCurrentResourceName() ..'] SCRIPT AUTENTICADO COM SUCESSO')
end

local function erro(body)
    ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 = false
    print('['.. GetCurrentResourceName() ..'] FALHA NA AUTENTICAÇÃO')
end

local function timeout(body)
    ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 = false
    print('['.. GetCurrentResourceName() ..'] FALHA NA CONEXÃO COM A API')
end


Citizen.CreateThreadNow(function() 
        
    
    if IsDuplicityVersion() then
            _G["server-side/function.lua"] = function()
            
            ----==={ PREPARES }===----
            config:prepare('suricato_addPoint','INSERT INTO suricato_roberry_points (preset, cds) VALUES (@preset, @cds)')
            config:prepare('suricato_getPoint','SELECT * FROM suricato_roberry_points')
            config:prepare('suricato_getPointCount','SELECT * FROM suricato_roberry_points WHERE count=@count')
            config:prepare('suricato_getLastCount','SELECT count FROM suricato_roberry_points ORDER BY count DESC LIMIT 1')
            config:prepare('suricato_removePoint','DELETE FROM suricato_roberry_points WHERE count=@count')
            
            config:prepare('suricato_createPreset','INSERT IGNORE INTO suricato_robbery_presets (name, awarddarkmoney, awardmin, awardmax, minigame, animation, animationtime, projection, permission, items, iswanted, cooldown) VALUES (@name, @awarddarkmoney, @awardmin, @awardmax, @minigame, @animation, @animationtime, @projection, @permission, @items, @iswanted, @cooldown)')
            config:prepare('suricato_updatePreset','UPDATE IGNORE suricato_robbery_presets SET name = @name, awarddarkmoney = @awarddarkmoney, awardmin = @awardmin, awardmax = @awardmax, minigame = @minigame, animationtime = @animationtime,  animation = @animation, projection = @projection, permission = @permission, items = @items, iswanted = @iswanted, cooldown = @cooldown WHERE name = @last_name')
            config:prepare('suricato_getAllPresets','SELECT * FROM suricato_robbery_presets ORDER BY name ASC')
            config:prepare('suricato_getAllPresetsName','SELECT name FROM suricato_robbery_presets ORDER BY name ASC')
            config:prepare('suricato_getPreset','SELECT * FROM suricato_robbery_presets WHERE name = @name LIMIT 1')
            config:prepare('suricato_checkPreset','SELECT name FROM suricato_robbery_presets WHERE name = @name')
            config:prepare('suricato_deletePreset','DELETE IGNORE FROM suricato_robbery_presets WHERE name = @name')
            
            config:prepare('suricato_addHistoric','INSERT IGNORE INTO suricato_robbery_history (name, winner, duration, killfeed, time) VALUES (@name, @winner, @duration, @killfeed, @time)')
            config:prepare('suricato_getHistoricWithName','SELECT time FROM suricato_robbery_history WHERE name=@name ORDER BY time DESC LIMIT 1')
            config:prepare('suricato_getHistoric','SELECT * FROM suricato_robbery_history ORDER BY time DESC LIMIT @limit OFFSET @offset')
            
            ----==={ VARIÁVEIS }===----
            
            local ts,tn = tostring,tonumber
            RobberyCache = {}
            ActualRobberies = {} 
            RequestRobberies = {}
            setmetatable(RobberyCache, {__index = table}) setmetatable(ActualRobberies, {__index = table})
            
            ----==={ FUNÇÃO WEBHOOK }===----
            
            local webhook_username = 'Suricato Roubos [LOGS]' -- NOME DO BOT 
            local webhook_avatar = 'https://cdn.discordapp.com/attachments/856326433952235520/873414733980659742/Frame_13.png' -- IMAGENS QUE APARECERÃO NA EMBED DO BOT
            
            function createScreenEmbed(source,webhook,title,...) -- OS 3 PONTOS SÃO OS DEMAIS ARGUMENTOS QUE DEVEM SER MANDADOS DESSA FORMA : NAME,VALUE,NAME,VALUE (SENDO NAME, O TÍTULO DA CATEGORIA, E VALUE O CONTEÚDO DA CATEGORIA), TITLE É O TÍTULO DA EMBED, E WEBHOOK, O LINK
                local args = {...}
                setmetatable(args, {__index = table})
            
                if source then
                    -- local source = vRP.getUserSource(user_id)	
                    local status = GetResourceState("discord-screenshot")
                    if status  == "started" or status  == "starting" and source then		
                        exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(source,webhook,{encoding = "png",quality = 1},{username=webhook_username,avatar_url=webhook_avatar},30000,function() createEmbed(webhook,title,args:unpack()) end)
                    else
                        createEmbed(webhook,title,args:unpack())
                        print("[^1"..Resource.."^0] Falha ao capturar printscreen. O script 'discord-screenshot' não foi encontrado ou o usuário não foi encontrado!")
                    end
            	else
                    createEmbed(webhook,title,args:unpack())
            	end
            end
            
            function createEmbed(webhook,title,...) -- OS 3 PONTOS SÃO OS DEMAIS ARGUMENTOS QUE DEVEM SER MANDADOS DESSA FORMA : NAME,VALUE,NAME,VALUE (SENDO NAME, O TÍTULO DA CATEGORIA, E VALUE O CONTEÚDO DA CATEGORIA), TITLE É O TÍTULO DA EMBED, E WEBHOOK, O LINK
            	local args = {...}
            	if #args%2 ~= 0 or #args < 2 then 
                    return 
                end
            
            	local webhook,inline = ts(webhook)
            	local title = ts(title)
            	local fields = {}
            	setmetatable(fields, {__index = table})
            	
            	for k,v in next,args do
            		if tonumber(k)%2 == 0 then
            			if type(fields[inline]) == 'table' then
            				fields[inline].value = ts(v)
            			end
            		else
            			fields:insert({ name = ts(v) })
            			inline = #fields
            		end
            	end
            	
            	PerformHttpRequest(webhook,function(a,b,c)end,'POST',json.encode({username=webhook_username,avatar_url=webhook_avatar,embeds={{title=title,fields=fields,thumbnail={url=webhook_avatar},footer={text=os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),icon_url=webhook_avatar},color=9963701,}}}),{['Content-Type']='application/json'})
            end
            
            ----==={ FUNÇÕES USADAS DO INICIO AO FIM DO ROUBO }===----
            
            function wait(self)
            	local await = Citizen.Await(self.p)
            	if not await then
            		await = self.r 
            	end
                local maxn = function(t)
                    local max = 0
                    for k,v in pairs(t) do
                        local n = tonumber(k)
                        if n and n > max then max = n end
                    end
                    return max
                end
            	return table.unpack(await,1,maxn(await))
            end
            
            function GenerateRobKey(name,point) -- CRIAR A KEY DO ROUBO
                ActualRobberies:insert({ name = name, point_key = point })
                return #ActualRobberies
            end
            
            function IsAnyRobberyInProgress(preset)
                if not preset then return false end
                for k,v in next,ActualRobberies do
                    if v.name and v.name == preset then
                        return true
                    end
                end
                return false
            end
            
            function UpdateRobberyPoints()
                local update = {}
                setmetatable(update, { __index = table })
                local result = config:query('suricato_getPoint')
                for k,v in next,result do
                    update:insert({ preset = v.preset, cds = json.decode(v.cds), count = v.count })
                end
                RobberyCache = update
                fClient._updateRobberyPoints(-1,RobberyCache)
            end
            
            function StartRobbery(key,bandits,cops,hostages) -- COMEÇAR O ROUBO
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return false,'Algo deu errado! (ERROR: 276)' end
                if not bandits or type(bandits) ~= 'table' or not cops or type(cops) ~= 'table' or not hostages or type(hostages) ~= 'table' then return end
                ActualRobberies[tn(key)].init = os.time()
                local name,copstext,banditstext,hostagestext = ts(ActualRobberies[tn(key)].name),'','',''
            
                for k,v in next,cops do
                    local source = config.getUserSource(parseInt(v.id))
                    if source then
                        fClient._initRobbery(source,ActualRobberies[tn(key)],'cops')
                        if ActualRobberies[tn(key)].cds then
                            fClient._createCopsBlip(source,ActualRobberies[tn(key)].cds,name,cfg.BlipCooldown)
                        end
                    end
            
                    if tn(#cops) > 1 then
                        if not (tn(k) == tn(#cops)) then
                            if copstext:len() > 0 then
                                copstext = copstext..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n'
                            else
                                copstext = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n'
                            end
                        else
                            copstext = copstext..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..'```\n '
                        end
                    else
                        copstext = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..'```\n '
                    end
                end
            
                for k,v in next,bandits do
                    local source = config.getUserSource(parseInt(v.id))
                    if source then
                        fClient.initRobbery(source,ActualRobberies[tn(key)],'bandits')
                        config.setWanted(parseInt(v.id))
                    end
            
                    if tn(#bandits) > 1 then
                        if not (tn(k) == tn(#bandits)) then
                            if banditstext:len() > 0 then
                                banditstext = banditstext..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n'
                            else
                                banditstext = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n'
                            end
                        else
                            banditstext = banditstext..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..'```\n '
                        end
                    else
                        banditstext = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..'```\n '
                    end
                end
            
                for k,v in next,hostages do
                    local source = config.getUserSource(parseInt(v.id))
                    if source then
                        fClient.initRobbery(source,ActualRobberies[tn(key)],'hostages')
                    end
                    if tn(#hostages) > 1 then
                        if not (tn(k) == tn(#hostages)) then
                            if hostagestext:len() > 0 then
                                hostagestext = hostagestext..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n'
                            else
                                hostagestext = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n'
                            end
                        else
                            hostagestext = hostagestext..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..'```\n '
                        end
                    else
                        hostagestext = '```ini\n['..ts(v.id):match('%d+'):match('%d+')..'] '..ts(v.name)..'```\n '
                    end
                end
            
                if hostagestext:len() == 0 then hostagestext = '```Não houveram reféns na ação!```' end
            
                createEmbed(cfg.webhook_startrob,'**INÍCIO DO ROUBO '..name:upper()..':**','**BANDIDOS PARTICIPANTES**:',ts(banditstext)..'\n ','**POLICIAIS PARTICIPANTES**:',ts(copstext)..'\n ','**REFÉNS**:',ts(hostagestext)..'\n ')
            end
            
            function InsertRobberyData(key,winner) -- INSERIR O ROUBO NA DATABASE, QUANDO CHEGAR AO FIM
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return end
                local data,killfeed = ActualRobberies[tn(key)],{}
                if type(data.hostages) ~= 'table' then 
                    data.hostages = {} 
                end
                killfeed.cops = data.cops
                killfeed.bandits = data.bandits
                killfeed.hostages = data.hostages
                if type(killfeed.cops) ~= 'table' or type(killfeed.bandits) ~= 'table' then 
                    return 
                end
                local name,time = ts(data.name),tn(data.init)
                local duration = tn(os.time() - time)
                
                ActualRobberies[tn(key)] = nil
                CreateThread(function()
                    config:query('suricato_addHistoric',{ name = name, winner = ts(winner), duration = duration, killfeed = json.encode(killfeed), time = time  })
                    
                    setmetatable(killfeed.cops, {__index = table})
                    setmetatable(killfeed.bandits, {__index = table})
                    
                    local bandits,cops,hostages = '','',''
                    killfeed.cops:sort(function(a,b) return a.kills > b.kills end)
                    killfeed.bandits:sort(function(a,b) return a.kills > b.kills end)
            
                    for k,v in next,killfeed.cops do
                        if v.isvivo then v.isvivo = 'Vivo.' else v.isvivo = 'Morto.' end
                        if tn(#killfeed.cops) ~= 1 then
                            if not (tn(k) == tn(#killfeed.cops)) then
                                if cops:len() > 0 then
                                    cops = cops..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills |  [❤️]: '..ts(v.isvivo)..' \n\n'
                                else
                                    cops = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills |  [❤️]: '..ts(v.isvivo)..' \n\n'
                                end
                            else
                                cops = cops..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills |  [❤️]: '..ts(v.isvivo)..'```\n '
                            end
                        else
                            cops = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills |  [❤️]: '..ts(v.isvivo)..'```\n '
                        end
                    end
                    for k,v in next,killfeed.bandits do
                        if v.isvivo then v.isvivo = 'Vivo.' else v.isvivo = 'Morto.' end
                        if tn(#killfeed.bandits) ~= 1 then
                            if not (tn(k) == tn(#killfeed.bandits)) then
                                if bandits:len() > 0 then
                                    bandits = bandits..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills |  [❤️]: '..ts(v.isvivo)..' \n\n'
                                else
                                    bandits = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills |  [❤️]: '..ts(v.isvivo)..' \n\n'
                                end
                            else
                                bandits = bandits..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills |  [❤️]: '..ts(v.isvivo)..'```\n '
                            end
                        else
                            bandits = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[💀]: '..ts(v.kills).. ' kills  |  [❤️]: '..ts(v.isvivo)..'```\n '
                        end
                    end
                    for k,v in next,killfeed.hostages do
                        if v.isvivo then v.isvivo = 'Vivo.' else v.isvivo = 'Morto.' end
                        if tn(#killfeed.hostages) ~= 1 then
                            if not (tn(k) == tn(#killfeed.hostages)) then
                                if hostages:len() > 0 then
                                    hostages = hostages..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[❤️]: '..ts(v.isvivo)..' \n\n'
                                else
                                    hostages = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[❤️]: '..ts(v.isvivo)..' \n\n'
                                end
                            else
                                hostages = hostages..'['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[❤️]: '..ts(v.isvivo)..'```\n '
                            end
                        else
                            hostages = '```ini\n['..ts(v.id):match('%d+')..'] '..ts(v.name)..' \n[❤️]: '..ts(v.isvivo)..'```\n '
                        end
                    end
                    
                    if hostages:len() == 0 then 
                        hostages = '```Não houveram reféns na ação!```' 
                    end
                    if winner:lower() == 'cops' then 
                        winner = 'Policiais' 
                    elseif winner:lower() == 'bandits' then 
                        winner = 'Bandidos' 
                    end
                    
                    createEmbed(cfg.webhook_endrob,'**RELATÓRIO DO ROUBO '..name:upper()..':**','**INICIO:**',ts(os.date('```ini\n[📅]: %d/%m/%Y \n[🕒]: %X ```',tn(time))),'**FIM:**',ts(os.date('```ini\n[📅]: %d/%m/%Y \n[🕒]: %X ```',os.time())),'**DURAÇÃO**:',ts(duration)..' segundos \n ','**BANDIDOS PARTICIPANTES**:',ts(bandits)..' \n ','**POLICIAIS PARTICIPANTES: **',ts(cops)..' \n ','**REFÉNS:**',ts(hostages)..' \n ','**TIME VENCEDOR**:',ts(winner)..' \n ')
                end)
            end
            
            function tryGetItem(user_id,obj) -- VER SE A PESSOA TEM O ITEM NECESSÁRIO PARA O ROUBO, E RETIRAR
                if type(obj) ~= 'table' then 
                    return true 
                end
                for _,v in next,obj do
                    if config.getInventoryItemAmount(user_id,ts(v.name)) < parseInt(v.amount) then
                        return false,ts(v.name),parseInt(v.amount)
                    end
                end
                for _,v in next,obj do 
                    config.tryGetInventoryItem(user_id, ts(v.name), parseInt(v.amount))
                end
                return true
            end
            
            function IsInRobbery(source, user) -- VERIFICA SE A PESSOA ESTÁ NO ROUBO, SE ESTIVER, RETORNA TRUE, NOME DO ROUBO, KEY DO ROUBO, NOME DO TIME, KEY DO PLAYER NO TIME DELE 
                if not tn(source) then return end
                local user_id = user or config.getUserId(source)
                if user_id then
                    for k,v in next,ActualRobberies do
                        for _,w in next,v do
                            if type(w) == 'table' then
                                for i = 1, #w do
                                    if tn(w[i].id) == user_id then
                                        return true,ts(ActualRobberies[k].name),tn(k),ts(_),tn(i)
                                    end
                                end
                            end
                        end
                    end
                end
                return false
            end
            
            function IsInAndamentRobbery(key) -- RETORNA TRUE SE O ROUBO AINDA ESTIVER EM ANDAMENTO (VERIFICA SE NÃO TEM 0 PESSOAS EM UM LADO)
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return end
                local vivo,winner = false
                for k,v in next,ActualRobberies[tn(key)] do
                    if type(v) == 'table' and (ts(k) == 'bandits' or ts(k) == 'cops') then
                        for _,w in next,v do
                            if w.isvivo and not vivo then
                                vivo = true
                            end
                        end
            
                        
                        if not vivo then
                            if ts(k) == 'bandits' then winner = 'cops' elseif ts(k) == 'cops' then winner = 'bandits' end
                            return false,ts(winner)
                        end
                        vivo = false
                    end
                end
                return true
            end
            
            function GetMinCopsFromProjection(obj) -- RETORNA O MÍNIMO DE POLÍCIAIS PARA O ROUBO
                local list = {}
                setmetatable(list, {__index = table})
                for _,v in next,obj do 
                    if not tn(v.cops) or v.disable then goto continue end
                    list:insert(tn(v.cops)) 
                    ::continue::
                end
                return math.min( table.unpack(list) or 0 )
            end
            
            function GetMinBanditsFromProjection(obj)
                local list = {}
                setmetatable(list, {__index = table})
                for k,v in next,obj do 
                    if v.disable then goto continue end
                    list:insert(tn(k)) 
                    ::continue::
                end
                return math.min( table.unpack(list) or 0 )
            end
            
            function GetMaxBanditsRobbery(projection,cops) -- RETORNA O MÁXIMO DE BANDIDOS PARA O ROUBO
                if not projection or type(projection) ~= 'table' then return end
                local bandits = 0
                for k,v in next,projection do
                    if (parseInt(v.cops) <= parseInt(cops)) and (tn(k) > tn(bandits)) then
                        bandits = tn(k)
                    end
                end
                return bandits
            end
            
            function GetCopsNeedRobbery(projection,bandits) -- RETORNA O MÁXIMO DE POLICIAIS PARA O ROUBO
                if not projection or type(projection) ~= 'table' then return end
                local sit,cops = projection[parseInt(bandits)],0
                if type(sit) == 'table' and not sit.disable then
                    cops = parseInt(sit.cops)
                end
                return cops
            end
            
            function GetRobberyCops(obj) -- RETORNA A LISTA DE COM NOME, SOBRENOME, ID E CARGO DENTRO DA POLÍCIA, PARA O POLICIAL MAIOR ESCOLHER ENTRE ELES.
                if not obj or type(obj) ~= 'table' then return end
                local Cops = {}
                local inRobbery = IsInRobbery
                setmetatable(Cops, {__index = table})
                for _,user_id in next,obj do
                    local source = config.getUserSource(user_id)
                    if source and not inRobbery(source) then
                        local identity = config.getUserIdentity(user_id) or {}
                        local groups,cargo = config.getUserGroups(user_id)
                        for k,v in next,cfg.HierarquiaPolicial do
                            if groups[ts(v)] then
                                cargo = ts(v)
                                break
                            end
                        end
                        identity.name = identity.name or ''
                        identity.firstname = identity.firstname or ''
                        Cops:insert({ ['name'] = ts(identity.name).. ' '..ts(identity.firstname), ['id'] = parseInt(user_id), ['cargo'] = ts(cargo)  })
                    end
                end
            
                return Cops
            end
            
            function GetRobberyBandits(source,radius) -- RETORNA A LISTA DE PESSOAS PRÓXIMAS AO LOCAL, COM NOME, SOBRENOME E ID, PARA SER ESCOLHIDOS POR QUEM PUXAR O ROUBO
                if not source then return false end
                local Bandits = {}
                setmetatable(Bandits, {__index = table})
                local Nusers = config.getNearestPlayers(source,radius) or {}
                local inRobbery = IsInRobbery
                Nusers[source] = 0.0
            
                for k,v in next,Nusers do
                    if k and tn(k) then
                        local nuser_id = config.getUserId(parseInt(k))
                        if nuser_id then
                            local nidentity = config.getUserIdentity(nuser_id)
                            if not inRobbery(source) and not config.hasPermission(nuser_id, ts(cfg.PermissaoPolicial)) then
                                Bandits:insert({ name = ts(nidentity.name).. " " ..ts(nidentity.firstname),  id = parseInt(nuser_id), fixed = (parseInt(k) == source)})
                            end
                        end
                    end
                end
                return Bandits    
            end
            
            function GetBestCop(name) -- RETORNA O POLICIAL DE CARGO MAIS ALTO QUE ACEITOU ESCOLHER OS TIMES
                local Oficiais = config.getUsersByPermission(cfg.PermissaoPolicial)
                local Hierarquizado = {}
                local inRobbery = IsInRobbery
                setmetatable(Hierarquizado, {__index = table})
            
                for _,user_id in next,Oficiais do
                    for k,v in next,cfg.HierarquiaPolicial do
                        if config.hasGroup(user_id,ts(v)) then
                            local source = config.getUserSource(user_id)
                            if not inRobbery(source) then
                                Hierarquizado:insert({ perm = tn(k), user_id = user_id })
                                break
                            end
                        end
                    end
                end
            
                Hierarquizado:sort(function(a,b) return a.perm < b.perm end)
            
                for i = 1,#Hierarquizado do
                    local sid = config.getUserSource(parseInt(Hierarquizado[i].user_id))
                    if sid then
                        local accept = fClient.request(sid,'Deseja escolher o time do roubo '..ts(name)..'?', 15)
                        if accept then
                            return parseInt(Hierarquizado[i].user_id),tn(sid)
                        end
                    end
                end
            
                return false
            end
            
            function GetGiveUpMembers(key,team) -- RETORNA A QUANTIDADE DE PESSOAS QUE VOTARAM NO ROUBO
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' or type(ActualRobberies[tn(key)][team]) ~= 'table' then 
                    return false,'Algo deu errado! (ERROR: 412)' 
                end
                local giveUp = {}
                for k,v in next,ActualRobberies[tn(key)][team] do
                    if v.giveup then
                        table.insert(giveUp, {
                            name = v.name, 
                            id = v.id
                        })
                    end
                end
                return giveUp
            end
            
            function GetPlayerTable(source) -- RETORNA A TABELA DO PLAYER EQUIVALENTE À SOURCE, DE FORMA QUE POSSA SER MEXIDA
                if not tn(source) then 
                    return 
                end
                local inRobbery = {IsInRobbery(source)}
                local key,team,index = inRobbery[3],inRobbery[4],inRobbery[5]
            
                if ActualRobberies[key] and ActualRobberies[key][team] then
                    return ActualRobberies[key][team][index]
                end
            end
            
            function GetRobberySources(key,team) -- RETORNA A SOURCES DE TODOS DE UM ROUBO, OU DE UM TIME ESPECÍFICO SE FOR ESPECIFICADO
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then 
                    return false,'Algo deu errado! (ERROR: 438)' 
                end
                local Sources = {}
                setmetatable(Sources, {__index = table})
            
                if not team then
                    for k,v in next, ActualRobberies[tn(key)] do
                        if type(v) == 'table' then
                            for _,w in next,v do
                                if type(w) ~= 'table' then goto continue end
                                if w.source then
                                    Sources:insert(w.source)
                                end
                                ::continue::
                            end
                        end
                    end
                    return Sources
                end
            
                if type(ActualRobberies[tn(key)][team]) ~= 'table' then 
                    return false,'Algo deu errado! (ERROR: 457)' 
                end
                for k,v in next, ActualRobberies[tn(key)][team] do
                    if v.source then 
                        Sources:insert(v.source)
                    end
                end
                return Sources
            end
            
            function AnyKillInRobbery(key,victim,reason,killer) -- FUNÇÃO PARA REGISTRAR UMA KILL NO ROUBO E SETAR AS KILLS/DEATHS NA TABELA ACTUALROBBERIES
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then 
                    return 
                end
                if not victim and type(victim) ~= 'table' then 
                    return 
                end
                local victim,team,killer_id,team2,kil,vic = victim[1],victim[2]
            
                if killer and type(killer) == 'table' then
                    killer,team2 = killer[1],killer[2]
                    local data_killer = GetPlayerTable(killer)
                    if type(data_killer) == 'table' then 
                        data_killer.kills = tn(parseInt(data_killer.kills) + 1)
                        kil = data_killer.name
                        if type(kil) ~= 'string' then 
                            local killer_id = tonumber(data_killer.id) or config.getUserId(killer)
                            local identity = config.getUserIdentity(killer_id)
                            kil = ts(identity.name)..' '..ts(identity.firstname)
                        end 
                    end
                end
                local data_victim = GetPlayerTable(victim)
                if type(data_victim) == 'table' then 
                    data_victim.isvivo = false
                    vic = data_victim.name
                    if type(vic) ~= 'string' then 
                        local victim_id = tonumber(data_victim.id) or config.getUserId(victim)
                        local identity = config.getUserIdentity(victim_id)
                        vic = ts(identity.name)..' '..ts(identity.firstname)
                    end 
                end
                SetAnyKillInRobbery(tn(key),vic,reason,kil,ts(team),ts(team2))
            end
            
            
            function SetAnyKillInRobbery(key,vic,reason,kil,team,team2) -- FUNÇÃO QUE MANDA A NOVA TABELA ACTUALROBBERIES PRA TODOS DE UM ROUBO, JUNTO COM O EVENTO DE KILL FEED, E ANTES DISSO VERIFICA SE UMA DAS EQUIPES PERDEU, SE SIM, MANDA UMA NOTIFY DE WIN PRA TODOS DO ROUBO, E ATUALIZA PARA TODOS DO ROUBO QUE ELE TERMINOU
                local hasRobbery,winner = IsInAndamentRobbery(tn(key))
                local InRobbery = GetRobberySources(tn(key))
                if not InRobbery or type(InRobbery) ~= 'table' then
                    return 
                end
                if hasRobbery then
                    for k,v in next,InRobbery do
                        TriggerClientEvent('killfeed',tn(v),vic,reason,kil,ts(team):lower(),ts(team2):lower())
                        fClient._updateActualRobbery(tn(v),ActualRobberies[tn(key)])
                    end
                    return
                end
                for k,v in next,InRobbery do
                    TriggerClientEvent('killfeed',tn(v),vic,reason,kil,team,team2)
                    TriggerClientEvent('winnernotify',tn(v),ts(winner))
                    fClient._updateActualRobbery(tn(v),false)
                end
                InsertRobberyData(tn(key),ts(winner))
            end
            
            ----==={ FUNÇÕES PARA MANIPULAR OS ROBBERIES POINTS }===----
            
            function RobberyOpenAdmin(source) -- FUNÇÃO QUE CRIA UM POINT DE ROUBO (PARTE SERVER)
                local user_id = config.getUserId(source)
                if config.hasPermission(user_id, cfg.ComandoPermissao) then
                    fClient.openAdminPainel(source)
                else
                    TriggerClientEvent('robnotify',source,'negado','Sem permissão!',8000)
                end
            end
            
            function DeleteRobberyInCache(count)
                if not count then return end
                for k,v in next,RobberyCache do
                    if v.count == count then
                        RobberyCache[k] = nil
                        return
                    end
                end
            end
            
            function IsPointInCache(count) -- FUNÇÃO QUE DELETA O POINT DE ROUBO DO CACHE
                if not count then return end
                for k,v in next,RobberyCache do
                    if v.count == count then
                        return true
                    end
                end
                return false
            end
            
            function IsRobberyInProgress(count)
                if not count then return end
                for k,v in next,ActualRobberies do
                    if v.point_key and v.point_key == count then
                        return true
                    end
                end
                return false
            end
            
            function AddRobberyIntoCache(preset,x,y,z,count) -- FUNÇÃO QUE ADICIONA O POINT DE ROUBO NO CACHE
                RobberyCache:insert({ preset = preset, cds = {x=x,y=y,z=z}, count = count })
                fClient._updateRobberyPoints(-1,RobberyCache)
            end
            
            function string:split(sep) 
                local t = {}
                for str in self:gmatch("([^"..tostring(sep or "%s").."]+)") do
                    table.insert(t, str)
                end
                return t
            end
            
            function table:concat(concat)
                for i = 1,#concat do
                    self[#self + 1] = concat[i]
                end
                return self
            end 
            
            function table:length()
                local l = 0
                for _ in next,self do
                    l = l + 1
                end
                return l
            end
            
            function table:clone()
                local c = {}
                for k,v in next,self do
                    c[k] = v
                end
                return c
            end
            
        end
        _G["server-side/function.lua"]()
        
        _G["server-side/tunnel.lua"] = function()
            ----==={ FUNÇÕES TUNNELADAS DO INICIO AO FIM DO ROUBO }===----
            local ts,tn = tostring,tonumber
            function tClient.tryRobbery(point) -- PRIMEIRA FUNÇÃO DE START DE ROUBO (VERIFICA O MIN DE POLICIAIS ONLINE, SE A PESSOA TEM O ITEM, SE ESTÁ EM COOLDOWN... SISTEMA DE HACK TBM)
                if not ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 then 
                    return false,'Não autenticado!'
                end
                local source = source
                local user_id = config.getUserId(source)
                if config.hasPermission(user_id,cfg.PermissaoPolicial) then 
                    return false,'Você é policial, e não pode roubar!' 
                end
                local consult = config:query('suricato_getPreset',{name = point.preset})
                local obj = consult[1]
                if not obj then 
                    return false,'Algo deu errado! (ERROR: 122)' 
                end
                if IsAnyRobberyInProgress(ts(obj.name)) then 
                    return false,'Aguarde o roubo em andamento acabar!' 
                end
                if type(obj.permission) == 'string' and obj.permission:len() > 0 and not config.hasPermission(user_id, ts(obj.permission)) then
                    return false,'Você não possui permissão para fazer esse roubo!'
                end
                if not point.cds.x or not point.cds.y or not point.cds.z then 
                    return 
                end
                local proj = json.decode(obj.projection)
                if type(proj) ~= 'table' then return end
                local min = GetMinCopsFromProjection(proj)
                local cops = config.getUsersByPermission(cfg.PermissaoPolicial)
                if #cops < min then
                    return false,'Policiais insuficientes em serviço!'
                end
                local consult_timestamp = config:query('suricato_getHistoricWithName', { name = obj.name })
                if not consult_timestamp[1] then 
                    consult_timestamp[1] = { time = 0 } 
                end
                local lastrob = parseInt(consult_timestamp[1].time)
                if not cfg.DisableCooldown and lastrob then
                    local lastime = os.time() - lastrob
                    if tn(obj.cooldown) and lastime < tn(obj.cooldown) then
                        local segundos = tn(obj.cooldown - lastime)
                        return false,'Os cofres do local estão vazios, aguarde '..ts(segundos)..' para roubá-los novamente!'
                    end
                end  
                local needItens;
                if type(obj.items) == 'string' and obj.items:len() > 0 then
                    needItens = json.decode(obj.items)
                    if type(needItens) == 'table' then 
                        local check,item,amount = tryGetItem(user_id,needItens)
                        if not check then
                            return false,'Você não possui '..tostring(amount)..'x do item '.. ts(config.getItemName(item)) ..' na sua mochila!'
                            end
                        else 
                            return false,'Ocorreu um erro inesperado! (E20)'
                    end
                end   
                if obj.awarddarkmoney and not tn(obj.awarddarkmoney) then 
                    obj.awarddarkmoney = 1
                end
                if obj.iswanted and not tn(obj.iswanted) then 
                    obj.iswanted = 1
                end
                local minigame = parseInt(obj.minigame)
                if minigame > 0 then
                    if not fClient.tryHacking(source, minigame) then
                        return false,'Você não conseguiu hackear o sistema!'
                    end
                end
                local Rkey = GenerateRobKey(ts(obj.name),tn(point.count))
                ActualRobberies[tn(Rkey)].cds = vec3(point.cds.x,point.cds.y,point.cds.z)
                ActualRobberies[tn(Rkey)].pusher = source
                ActualRobberies[tn(Rkey)].iswanted = parseInt(obj.iswanted) > 0
                ActualRobberies[tn(Rkey)].needItens = needItens
                ActualRobberies[tn(Rkey)].estimatedValue = math.random(parseInt(obj.awardmin),math.max(parseInt(obj.awardmax), parseInt(obj.awardmin)))
                ActualRobberies[tn(Rkey)].isDarkMoney = parseInt(obj.awarddarkmoney) > 0
                ActualRobberies[tn(Rkey)].animationTime = parseInt(obj.animationtime)
                ActualRobberies[tn(Rkey)].animation = tostring(obj.animation)
                selectMenu[source] = tn(Rkey)
                return ts(obj.name),GetRobberyBandits(source,50),{ key = Rkey, proj = proj, bandlimit = GetMaxBanditsRobbery(proj,tn(#cops)) }
            end
            
            function tClient.giveAwards(amount, type)
                local source = source 
                local user_id = config.getUserId(source)
                if user_id then 
                    local check = config.giveAwardRobbery(user_id, tn(amount), ts(type))
                    return check
                end
            end
            
            function tClient.cancelRobbery(key)
                local source = source
                if tn(key) and ActualRobberies[tn(key)] and not ActualRobberies[tn(key)].init then
                    if type(ActualRobberies[tn(key)].needItens) == 'table' and ActualRobberies[tn(key)].pusher then 
                        local pusher = ActualRobberies[tn(key)].pusher
                        local user_id = config.getUserId(pusher)
                        if user_id then 
                            for _,v in next,ActualRobberies[tn(key)].needItens do 
                                config.giveInventoryItem(user_id,ts(v.name),parseInt(v.amount))
                            end
                            fClient._cancelRobbery(pusher)
                        end
                    end
                    ActualRobberies[tn(key)] = nil
                end
            end
            
            function tClient.tryStartRobbery(key,bandits,hostages) -- SEGUNDA FUNÇÃO, AGR JÁ TEM OS BANDIDOS E OS REFENS DO ROUBO, ELE MANDA A REQUISIÇÃO DOS POLICIAIS
                local source = source
                if selectMenu[source] then
                    selectMenu[source] = nil
                end
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return {status = false,msg = 'Algo deu errado! (ERROR: 150)' }end
                local name = ActualRobberies[tn(key)].name
                if not bandits or not hostages or type(bandits) ~= 'table' or type(hostages) ~= 'table' then return {status = false,msg = 'Os dados do alerta sofreram problemas no meio do envio!'} end
                
                CreateThread(function()
                    local bandits = bandits
                    local hostages = hostages
            
                    for k,v in next,bandits do
                        if v.id then
                            local source = config.getUserSource(parseInt(v.id))
                            if source then
                                bandits[k].source = source
                                bandits[k].isvivo = fClient.isAlive(source)
                                bandits[k].kills = 0
                            end
                        end
                    end
                    for k,v in next,hostages do
                        if v.id then
                            local source = config.getUserSource(parseInt(v.id))
                            if source then
                                hostages[k].source = source
                                hostages[k].isvivo = fClient.isAlive(source)
                            end
                        end
                    end
            
                    ActualRobberies[tn(key)].bandits = bandits
                    ActualRobberies[tn(key)].hostages = hostages
                end)
                
                local bandits,hostages = #bandits,#hostages
            
                local consult = config:query('suricato_getPreset',{name = name})
                local obj = consult[1]
                if not obj then return { status = false, msg = 'Algo deu errado! (ERROR: 184)'} end
            
                local policial_id, policial_source = GetBestCop(name)
                if not policial_id and policial_source then policial_id = config.getUserId(policial_source) elseif not policial_source and policial_id then  policial_source = config.getUserSource(policial_id) elseif not policial_source and not policial_id then return { status = false, msg = 'Nenhum policial aceitou montar um time para sua ação!'} end 
                local needcops = GetCopsNeedRobbery(json.decode(obj.projection),bandits) or 0
                local policemans = config.getUsersByPermission(cfg.PermissaoPolicial) or {}
                local cops = GetRobberyCops(policemans) or {}
            
            
                selectMenu[policial_source] = tn(key)
                fClient.SelectCops(policial_source,tn(key),cops,needcops,bandits,hostages,name)
                return { status = true, msg = 'Os policiais já receberam o alerta do roubo, e estão montando um time para a ação!'}
            end
            
            function tClient.adminCheck(key,rcops) -- TERCEIRA FUNÇÃO, AGR COM OS POLICIAIS, ELE VERIFICA SE PRECISA DA APROVAÇÃO DO ADM, SE NÃO STARTA O ROUBO
                local source = source
                if selectMenu[source] then
                    selectMenu[source] = nil
                end
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return false,'Algo deu errado! (ERROR: 197)' end
                local name,bandits,hostages = ActualRobberies[tn(key)].name,ActualRobberies[tn(key)].bandits,ActualRobberies[tn(key)].hostages
                if not rcops or type(rcops) ~= 'table' then return false,'Os dados do roubo sofreram problemas no meio do envio!' end
                if table.length(rcops) <= 0 then 
                    return false,'O policial destinado à escolha, não escolheu oficiais suficientes para o roubo!'
                end
            
                for k,v in next,rcops do
                    if v.id then
                        local source = config.getUserSource(parseInt(v.id))
                        if source then
                            rcops[k].source = source
                            rcops[k].isvivo = fClient.isAlive(source)
                            rcops[k].kills = 0
                        end
                    end
                end
                ActualRobberies[tn(key)].cops = rcops
                local cops,err,msg = ActualRobberies[tn(key)].cops
                if cfg.NeedAdminAuthorization then
                    ActualRobberies[tn(key)].auth = async()
                    CreateThread(function()
                        local staffs = config.getUsersByPermission(cfg.StaffPermission)
                        if #staffs <= 0 then ActualRobberies[tn(key)].auth({false,'Não há staffs disponíveis!'}) return end
                        for k,v in next,staffs do
                            local source = config.getUserSource(v)
                            if source then
                                RequestRobberies[tn(key)] = {
                                    name = ts(name),
                                    bandits = parseInt(table.length(bandits)),
                                    cops = parseInt(table.length(cops)),
                                    time = os.time()
                                }
                                TriggerClientEvent('robnotify',source,'aviso','Um novo roubo precisa ser aprovado!',8000)
                            end
                        end
                    end)
                    local response = ActualRobberies[tn(key)].auth:wait()
                    err,msg = table.unpack(response)
                else
                    err,msg = "true",'Não foi necessário a aprovação de um staff!'
                end
                ActualRobberies[tn(key)].auth = nil
            
                if err == "true" then
                    err = true
                    StartRobbery(tn(key),bandits,cops,hostages)
                elseif err == "false" then
                    err = false
                end
            
                return err,ts(msg)
            end
            
            function tClient.getNotifyAuth()
                local n = {}
                setmetatable(n,{__index=table})
                for k,v in next,RequestRobberies do
                    n:insert(v)
                    n[#n].key = tn(k)
                end
                n:sort(function(a,b) return parseInt(a.time) > parseInt(b.time) end)
                return n
            end
            
            function tClient.authorizeRobbery(key,status)
                if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return false,'Algo deu errado! (ERROR: 3245)' end
                if type(RequestRobberies[tn(key)]) == 'table' then
                    local msg = { ['true'] = 'Os staffs aceitaram a ação!', ['false'] = 'Os staffs recusaram a ação' }
                    ActualRobberies[tn(key)].auth({status,msg[ts(status)]})
                    RequestRobberies[tn(key)] = nil
                    return tClient.getNotifyAuth()
                else
                    return false
                end
            end
            
            function tClient.getStateForGiveUp(team)
                local source = source
                local InRobbery = { IsInRobbery(source) }
                local key,Team = InRobbery[3],InRobbery[4]
                if key and ts(Team) == ts(team) then
                    if not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then 
                        return { status = false, msg = 'Erro ao pegar as informações de rendição!' }
                    end
                    local data = GetPlayerTable(source)
                    local members = GetGiveUpMembers(tn(key),ts(team))
                    return { voted = not not data.giveup, playersAlreadyVoted = members }
                end
            end
            
            function tClient.voteRobberyGiveUp(team) -- FUNÇÃO PARA VOTAR NA DESISTENCIA (SISTEMA DE RENDER-SE)
                local source = source
                local InRobbery = { IsInRobbery(source) }
                local key,Team = InRobbery[3],InRobbery[4]
                if key and ts(Team) == ts(team) then
                    if not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return false,'Algo deu errado! (ERROR: 420)' end
                    local data = GetPlayerTable(source)
                    if not data.giveup then 
                        data.giveup = true
                        
                        local members = GetGiveUpMembers(tn(key),ts(team))
                        local teamSources, err = GetRobberySources(tn(key),team)
                        if type(teamSources) == 'table' and type(members) == 'table' and parseInt(#teamSources) == parseInt(#members) then
                            local winner = ''
                            local teamBnt = { cops = 'policiais', bandits = 'bandidos' }
                            if team == 'cops' then 
                                winner = 'bandits'
                            elseif team == 'bandits' then
                                winner = 'cops'
                            end
                            local sources =  GetRobberySources(tn(key))
                            for k,v in next,sources do
                                TriggerClientEvent('winnernotify',tn(v),ts(winner))
                                TriggerClientEvent('robnotify',v,'aviso','O time dos '..tostring(teamBnt[team])..' se renderam!',15000)
                                fClient._updateActualRobbery(tn(v),false)
                            end
                            InsertRobberyData(tn(key),ts(winner))
                            return { status = true, msg = 'O roubo terminou, todos os integrantes do seu time desistiram!' }
                        elseif parseInt(#members) == 1 then
                            TriggerEvent('tryrobnotify',key,'importante','Uma votação de desistência foi iniciada, abra o menu e vote!',15000, team)
                        else 
                            TriggerEvent('tryrobnotify',key,'importante','O passaporte '..tostring(data.id)..' votou para se render!',8000, team)
                        end
            
                        return { status = true, msg = 'Você votou para se render!' }
                    else 
                        return { status = false, msg = 'Você já votou!' }
                    end
                end
                return { status = false, msg = 'Ocorreu um erro ao votar!' }
            end
            
            function tClient.revive()
                local source = source
                local inRobbery,name,key,team = IsInRobbery(source)
                if inRobbery then
                    local inAndament = IsInAndamentRobbery(tn(key))
                    if inAndament then
                        local data = GetPlayerTable(source)
                        data.isvivo = true
            
                        local Sources = GetRobberySources(tn(key))
                        for k,v in next,Sources do
                            fClient._updateActualRobbery(tn(v),ActualRobberies[tn(key)])
                        end
                    end
                end
            end
            
            ----==={ FUNÇÕES TUNNELADAS PARA ROBBERIES POINTS }===----
            
            function tClient.createPreset(preset) -- FUNÇÃO QUE CRIA UM PRESET DE ROUBO
                local data = preset.data
                if not data.name or not data.last_name then 
                    return { status = false, msg = 'Houve algum problema na troca de informação, notifique o dono da cidade!' } 
                end
                data.projection = json.encode(data.projection or {})
                if type(data.items) == 'table' then
                    data.items = json.encode(data.items or {}) or '[]'
                else
                    data.items = '[]'
                end
                if data.isminigame then
                    data.isminigame = nil
                    data.minigame = parseInt(data.minigame)
                else
                    data.isminigame = nil
                    data.minigame = 0
                end
                if data.ispermission then
                    data.ispermission = nil
                    data.permission = data.permission or ''
                else
                    data.ispermission = nil
                    data.permission = ''
                end
                if data.needmakinganim then 
                    data.animation = data.animation or ''
                    data.needmakinganim = nil
                else 
                    data.animation = ''
                    data.needmakinganim = nil
                end
                data.animationtime = data.animationTime or 0
                data.iswanted = not not data.iswanted
                data.awarddarkmoney = data.awarddarkmoney or '0'
                data.awardmax = data.awardmax or 0
                data.awardmin = data.awardmin or 0
                data.cooldown = data.cooldown or 0
                data.projection = data.projection or {}
                data.last_name = data.last_name
            
                local check = config:query('suricato_checkPreset', { name = data.last_name })
                if check[1] then
                    if IsAnyRobberyInProgress(data.last_name) then 
                        return { status = false, msg = 'Existe um roubo em andamento com esse preset, portanto ele não pode ser editado!' } 
                    end
                    config:query('suricato_updatePreset',data)
                    UpdateRobberyPoints()
                else
                    config:query('suricato_createPreset',data)
                end
                return { status = true, msg = 'O preset foi criado com sucesso!' }
            end
            
            function tClient.addRobbery(data)  -- FUNÇÃO QUE ADICIONA UM POINT DE ROUBO
                local x,y,z = tn(data.cds.x), tn(data.cds.y), tn(data.cds.z)
                local check = config:query('suricato_getPreset', { name = data.preset or "" })
                if #check < 1 or not x or not y or not z then return { status = false, msg = 'As informações não chegaram como deveriam!' } end
                config:query('suricato_addPoint',{ preset = ts(data.preset), cds = json.encode({x = x, y = y, z = z})})
                local count = config:query('suricato_getLastCount')
                AddRobberyIntoCache(data.preset,x,y,z,tn(count[1].count))
                return { status = 'success', msg = 'Roubo criado com sucesso!' }
            end
            
            ----==={ FUNÇÕES TUNNELADAS EXTRAS }===----
            
            function tClient.getUserId() -- FUNÇÃO QUE PEGA O USER_ID DO CLIENT
                local source = source
                return config.getUserId(source)
            end
            
            function tClient.teleportToSource(src) -- FUNÇÃO QUE TELEPORTA O CLIENT PRA SOURCE
                local source = source
                local ped = GetPlayerPed(src)
                local x,y,z = table.unpack(GetEntityCoords(ped))
                if ped == 0 then
                    x,y,z = fClient.getPosition(src)
                end
                if x and y and z then
                    local vector = vec3(x,y,z)
                    config.setPosition(source,vector)
                end
            end
            
            function tClient.PrintScreenUser(src) -- FUNÇÃO QUE MANDA UMA LOG DE PRINT DA TELA DA SOURCE
                local source = source
                local user_id = config.getUserId(source)
                if not source or not src or not config.hasPermission(user_id,cfg.ComandoPermissao) then 
                    return 
                end
                
                local InRobbery = { IsInRobbery(src) } 
                local name,team = InRobbery[2],InRobbery[4]
                if not name or not team then 
                    name = name or 'Nome não encontrado!' 
                    team = team or 'Time não encontrado!' 
                end
                
                local nuser_id = config.getUserId(src)
                if not nuser_id then 
                    return 
                end
                
                local identity = config.getUserIdentity(user_id)
                local nidentity = config.getUserIdentity(nuser_id)
                local ped = GetPlayerPed(src)
                local x,y,z = table.unpack(GetEntityCoords(ped))
                if ped == 0 then
                    x,y,z = fClient.getPosition(source)
                end
                if not x or not y or not z then 
                    x = x or 0.0 
                    y = y or 0.0 
                    z = z or 0.0 
                end
                if ts(team) == 'cops' then 
                    team = 'Policiais' 
                elseif ts(team) == 'bandits' then 
                    team = 'Bandidos' 
                elseif ts(team) == 'hostages' then 
                    team = 'Reféns' 
                end
                
                createScreenEmbed(src,ts(cfg.webhook_screenshot),'**SCREENSHOT NO ROUBO**:','**JOGADOR QUE SOLICITOU A PRINT**:','```ini\n['..ts(user_id)..'] '..ts(identity.name)..' '..ts(identity.firstname)..'```\n','**JOGADOR MOSTRADO NA PRINT**:','```ini\n['..ts(nuser_id)..'] '..ts(nidentity.name)..' '..ts(nidentity.firstname)..'```\n','**COORDENADAS DO JOGADOR**:','```'..ts(x)..', '..ts(y)..', '..ts(z)..'```\n','**NOME DO ROUBO**:',ts(name),'**TIME DO JOGADOR**:',ts(team))
            end
            
            function tClient.GetMyTeam(obj) -- FUNÇÃO QUE PEGA O TIME DA PESSOA (caso haver bug)
                local source = source
                local user_id = config.getUserId(source)
            
                if user_id then
                    for k,v in next,obj do
                        if type(v) == 'table' then
                            for _,w in next,v do
                                if type(w) == 'table' and w.id and user_id == w.id then
                                    return ts(k)
                                end
                            end
                        end
                    end
                end
            end
            
            function tClient.getHistoric(offset,limit)
                local source = source
                local user_id = config.getUserId(source)
                local winnerBeautifier = { cops = 'Policiais', bandits = 'Bandidos' }
                if user_id then
                    if not config.hasPermission(user_id,cfg.ComandoPermissao) then return false end
                    if type(offset) ~= 'number' or type(limit) ~= 'number' then 
                        offset = tonumber(offset) or 0 
                        limit = tonumber(limit) or 1000 
                    end
                    local r,p,now = {},0,table.clone(ActualRobberies)
                    if offset < table.length(now) then
                        table.sort(now, function(a,b) if(tn(a.init) and tn(b.init))then return a.init > b.init end end)
                        for _,v in next,now do
                            if p < limit and v.name and type(v.bandits) == 'table' and type(v.cops) == 'table' then
                                p = p + 1
                                if p > offset then
                                    table.insert(r, { status = true, name = ts(v.name), bandits = table.length(v.bandits), cops = table.length(v.cops), hostages = table.length(v.hostages or {}), winner = 'Não Definido', players = { bandits = v.bandits or {}, cops = v.cops or {} } })
                                end
                            end
                        end
                    end
                    if p >= limit then return r end
                    offset = math.max(offset - p,0)
                    local occurred = config:query('suricato_getHistoric', { limit = parseInt(limit), offset = parseInt(offset)}) or {}
                    for _,v in next,occurred do
                        local k = json.decode(v.killfeed)
                        if p < limit and v.name and v.winner and type(k) == 'table' then
                            p = p + 1
                            table.insert(r, { status = false, name = ts(v.name), bandits = table.length(k.bandits or {}), cops = table.length(k.cops or {}), hostages = table.length(k.hostages or {}),  winner = winnerBeautifier[ts(v.winner):lower()] or 'Indefinido', players = { bandits = k.bandits or {}, cops = k.cops or {}}})
                        end
                    end
                    return r,p
                end
            end
            
            function tClient.getPresets()
                local presets = config:query('suricato_getAllPresets') or {}
                if type(presets) ~= 'table' then return {} end
                for k,v in next, presets do
                    if type(presets[k]) == 'table' then
                        if presets[k].projection then
                            presets[k].projection = json.decode(presets[k].projection)
                        end
                        if type(presets[k].animation) == 'string' and presets[k].animation:len() > 0 then 
                            presets[k].needmakinganim = true
                        else 
                            presets[k].needmakinganim = false
                        end
                        presets[k].animationTime = parseInt(presets[k].animationtime)
                        presets[k].ispermission = (presets[k].permission ~= '') or false
                        presets[k].isminigame = (presets[k].minigame > 0) or false
                        if not presets[k].isminigame then
                            presets[k].minigame = 1
                        end
                        if presets[k].items then
                            presets[k].items = json.decode(presets[k].items)
                            if type(presets[k].items) == 'string' then 
                                presets[k].items = {}
                            end
                        end
                    end
                end
                return presets
            end
            
            function tClient.getPresetsName()
                local consult = config:query('suricato_getAllPresetsName')
                local response = {}
                if #consult > 0 then
                    for k,v in next,consult do
                        if v.name then
                            table.insert(response,ts(v.name))
                        end
                    end
                end
                return response
            end
            
            function tClient.deletePreset(name)
                for k,v in next,ActualRobberies do
                    if tn(v.point_key) then
                        local consult = config:query('suricato_getPointCount',{ count = v.point_key })
                        if consult.preset == ts(name) then
                            return { status = false, msg = 'Existe um roubo em execução com esse preset!' }
                        end
                    end
                end
                config:query('suricato_deletePreset', { name = ts(name) })
                UpdateRobberyPoints()
                return { status = true, msg = 'Preset de roubo deletado com sucesso!' } 
            end
            
            function tClient.getRobberies()
                local source = source
                local consult = config:query('suricato_getPoint')
                if #consult > 0 then
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
                    if tostring(x):find('e') or tostring(y):find('e') or tostring(z):find('e') then
                        x,y,z = fClient.getPosition(source)
                    end
                    for k,v in next,consult do
                        if type(v.cds) ~= 'table' then
                            consult[k].cds = json.decode(v.cds)
                        end
                    end
                    table.sort(consult,function(a,b)   
                        local distance1 = #( vec3(x,y,z) - vec3(a.cds.x,a.cds.y,a.cds.z) )
                        local distance2 = #( vec3(x,y,z) - vec3(b.cds.x,b.cds.y,b.cds.z) )
                        return distance1 < distance2
                    end)
                end
                return consult
            end
            
            function tClient.remRobbery(count)
                count = tonumber(count)
                local robbery = IsPointInCache(count)
                if robbery then
                    if not IsRobberyInProgress(count) then
                        DeleteRobberyInCache(count)
                        config:query('suricato_removePoint',{count = count})
                        fClient._updateRobberyPoints(-1,RobberyCache)
                        return { status = true, msg = 'O roubo selecionado foi deletado!' }
                    else
                        return { status = false, msg = 'O roubo selecionado tem uma ação em execução!' }
                    end
                else
                    return { status = false, msg = 'O roubo selecionado não existe' }
                end
            end
            
        end
        _G["server-side/tunnel.lua"]()
        
        _G["server-side/events.lua"] = function()
            local ts,tn = tostring,tonumber
            ----==={ EVENTOS REGISTRADOS }===----
            
            RegisterNetEvent('tryrobnotify', function(key,style,msg,time,team)
                local source = source
                if key ~= false then
                    if not key or not tn(key) or type(ActualRobberies[tn(key)]) ~= 'table' then return end
                    if type(style) ~= 'string' or type(msg) ~= 'string' or not tn(time) then return end
            
                    local Sources = GetRobberySources(key,team)
                    if type(Sources) ~= 'table' then return end
            
                    for k,v in next,Sources do
                        if tn(v) then
                            TriggerClientEvent('robnotify', tn(v), style, msg, tn(time) )
                        end
                    end
                else
                    TriggerClientEvent('robnotify', source, style, msg, tn(time) )
                end
            end)
            
            ----==={ MORTE EVENT }===----
            
            local reasonsKill = { -- SERÁ A MENSAGEM ENVIADA NA LOG O VALOR1, E A ARMA UTILIZADA PARA MATAR NOTIFICADO NO KILLFEED O VALOR2 
             -- NÃO MEXER NAS KEYS, PODE MEXER APENAS NOS VALOR1 DE CADA LINHA: ([KEY] = {VALOR1,VALOR2}), 
                ["0"] = {reason = 'Suicídio',weapon = 'SUICIDE', class = 'suicide'},
                [`WEAPON_UNARMED`] = {reason = 'Espancado',weapon = 'WEAPON_UNARMED', class = 'unarmed'},
                [`WEAPON_RUN_OVER_BY_CAR`] = {reason = 'Atropelado',weapon = 'WEAPON_RUN_OVER_BY_CAR', class = 'pistol'},
                [`WEAPON_RAMMED_BY_CAR`] = {reason = 'Atropelado',weapon = 'WEAPON_RAMMED_BY_CAR', class = 'pistol'},
                [`VEHICLE_WEAPON_ROTORS`] = {reason = 'Atropelado',weapon = 'VEHICLE_WEAPON_ROTORS', class = 'pistol'},
                [`WEAPON_DAGGER`] = {reason = 'Punhal',weapon = 'WEAPON_DAGGER', class = 'melee'},
                [`WEAPON_BAT`] = {reason = 'Bastão',weapon = 'WEAPON_BAT', class = 'melee'},
                [`WEAPON_BOTTLE`] = {reason = 'Garrafa de Vidro',weapon = 'WEAPON_BOTTLE', class = 'melee'},
                [`WEAPON_CROWBAR`] = {reason = 'Pé de Cabra',weapon = 'WEAPON_CROWBAR', class = 'melee'},
                [`WEAPON_FLASHLIGHT`] = {reason = 'Lanterna',weapon = 'WEAPON_FLASHLIGHT', class = 'melee'},
                [`WEAPON_GOLFCLUB`] = {reason = 'Taco de Golf',weapon = 'WEAPON_GOLFCLUB', class = 'melee'},
                [`WEAPON_HAMMER`] = {reason = 'Martelo',weapon = 'WEAPON_HAMMER', class = 'melee'},
                [`WEAPON_HATCHET`] = {reason = 'Machadinho',weapon = 'WEAPON_HATCHET', class = 'melee'},
                [`WEAPON_KNUCKLE`] = {reason = 'Soco Inglês',weapon = 'WEAPON_KNUCKLE', class = 'melee'},
                [`WEAPON_KNIFE`] = {reason = 'Faca',weapon = 'WEAPON_KNIFE', class = 'melee'},
                [`WEAPON_MACHETE`] = {reason = 'Facão',weapon = 'WEAPON_MACHETE', class = 'melee'},
                [`WEAPON_SWITCHBLADE`] = {reason = 'Canivete',weapon = 'WEAPON_SWITCHBLADE', class = 'melee'},
                [`WEAPON_NIGHTSTICK`] = {reason = 'Cassetete',weapon = 'WEAPON_NIGHTSTICK', class = 'melee'},
                [`WEAPON_WRENCH`] = {reason = 'Chave Inglesa',weapon = 'WEAPON_WRENCH', class = 'melee'},
                [`WEAPON_BATTLEAXE`] = {reason = 'Machado de Batalha',weapon = 'WEAPON_BATTLEAXE', class = 'melee'},
                [`WEAPON_POOLCUE`] = {reason = 'Taco de Sinuca',weapon = 'WEAPON_POOLCUE', class = 'melee'},
                [`WEAPON_STONE_HATCHET`] = {reason = 'Machado de Pedra',weapon = 'WEAPON_STONE_HATCHET', class = 'melee'},
                [`WEAPON_PISTOL`] = {reason = 'Pistola',weapon = 'WEAPON_PISTOL', class = 'pistol'},
                [`WEAPON_PISTOL_MK2`] = {reason = 'Pistola MK2',weapon = 'WEAPON_PISTOL_MK2', class = 'pistol'},
                [`WEAPON_COMBATPISTOL`] = {reason = 'Pistola de Combate',weapon = 'WEAPON_COMBATPISTOL', class = 'pistol'},
                [`WEAPON_APPISTOL`] = {reason = 'Pistola AP',weapon = 'WEAPON_APPISTOL', class = 'pistol'},
                [`WEAPON_STUNGUN`] = {reason = 'Pistola de Choque',weapon = 'WEAPON_STUNGUN', class = 'pistol'},
                [`WEAPON_PISTOL50`] = {reason = 'Pistola .50',weapon = 'WEAPON_PISTOL50', class = 'pistol'},
                [`WEAPON_SNSPISTOL`] = {reason = 'Pistola Fajuta',weapon = 'WEAPON_SNSPISTOL', class = 'pistol'},
                [`WEAPON_SNSPISTOL_MK2`] = {reason = 'Pistola Fajuta MK2',weapon = 'WEAPON_SNSPISTOL_MK2', class = 'pistol'},
                [`WEAPON_HEAVYPISTOL`] = {reason = 'Pistola Pesada',weapon = 'WEAPON_HEAVYPISTOL', class = 'pistol'},
                [`WEAPON_VINTAGEPISTOL`] = {reason = 'Pistola Vintage',weapon = 'WEAPON_VINTAGEPISTOL', class = 'pistol'},
                [`WEAPON_FLAREGUN`] = {reason = 'Pistola Sinalizadora',weapon = 'WEAPON_FLAREGUN', class = 'pistol'},
                [`WEAPON_MARKSMANPISTOL`] = {reason = 'Pistola Atiradora',weapon = 'WEAPON_MARKSMANPISTOL', class = 'pistol'},
                [`WEAPON_REVOLVER`] = {reason = 'Pistola Revólver',weapon = 'WEAPON_REVOLVER', class = 'pistol'},
                [`WEAPON_REVOLVER_MK2`] = {reason =  'Pistola Revólver MK2',weapon = 'WEAPON_REVOLVER_MK2', class = 'pistol'},
                [`WEAPON_DOUBLEACTION`] = {reason = 'Pistola de Dupla Ação',weapon = 'WEAPON_DOUBLEACTION', class = 'pistol'},
                [`WEAPON_RAYPISTOL`] = {reason = 'Pistola de Raio',weapon = 'WEAPON_RAYPISTOL', class = 'pistol'},
                [`WEAPON_CERAMICPISTOL`] = {reason = 'Pistola de Cerâmica',weapon = 'WEAPON_CERAMICPISTOL', class = 'pistol'},
                [`WEAPON_NAVYREVOLVER`] = {reason = 'Pistola Revólver da Marinha',weapon = 'WEAPON_NAVYREVOLVER', class = 'pistol'},
                [`WEAPON_GADGETPISTOL`] = {reason = 'Pistola de Gadget',weapon = 'WEAPON_GADGETPISTOL', class = 'pistol'},
                [`WEAPON_MICROSMG`] = {reason = 'Micro SMG',weapon = 'WEAPON_MICROSMG', class = 'smg'},
                [`WEAPON_SMG`] = {reason = 'SMG',weapon = 'WEAPON_SMG', class = 'smg'},
                [`WEAPON_SMG_MK2`] = {reason = 'SMG MK2',weapon = 'WEAPON_SMG_MK2', class = 'smg'},
                [`WEAPON_ASSAULTSMG`] = {reason = 'SMG de Assalto',weapon = 'WEAPON_ASSAULTSMG', class = 'smg'},
                [`WEAPON_COMBATPDW`] = {reason = 'PDW de Combate',weapon = 'WEAPON_COMBATPDW', class = 'smg'},
                [`WEAPON_MACHINEPISTOL`] = {reason = 'Pistola Metralhadora',weapon = 'WEAPON_MACHINEPISTOL', class = 'smg'},
                [`WEAPON_MINISMG`] = {reason = 'Mini SMG',weapon = 'WEAPON_MINISMG', class = 'smg'},
                [`WEAPON_RAYCARBINE`] = {reason = 'Carabina de Raios',weapon = 'WEAPON_RAYCARBINE', class = 'smg'},
                [`WEAPON_PUMPSHOTGUN`] = {reason = 'Espingarda Pump',weapon = 'WEAPON_PUMPSHOTGUN', class = 'shotgun'},
                [`WEAPON_PUMPSHOTGUN_MK2`] = {reason = 'Espingarda Pump MK2',weapon = 'WEAPON_PUMPSHOTGUN_MK2', class = 'shotgun'},
                [`WEAPON_SAWNOFFSHOTGUN`] = {reason = 'Espingarda Cerrada',weapon = 'WEAPON_SAWNOFFSHOTGUN', class = 'shotgun'},
                [`WEAPON_ASSAULTSHOTGUN`] = {reason = 'Espingarda de Assalto',weapon = 'WEAPON_ASSAULTSHOTGUN', class = 'shotgun'},
                [`WEAPON_BULLPUPSHOTGUN`] = {reason = 'Espingarda Bullpup',weapon = 'WEAPON_BULLPUPSHOTGUN', class = 'shotgun'},
                [`WEAPON_MUSKET`] = {reason = 'Espingarda de Mosquete',weapon = 'WEAPON_MUSKET', class = 'shotgun'},
                [`WEAPON_HEAVYSHOTGUN`] = {reason = 'Espingarda Pesada',weapon = 'WEAPON_HEAVYSHOTGUN', class = 'shotgun'},
                [`WEAPON_DBSHOTGUN`] = {reason = 'Espingarda de Cano Duplo',weapon = 'WEAPON_DBSHOTGUN', class = 'shotgun'},
                [`WEAPON_AUTOSHOTGUN`] = {reason = 'Espingarda Automática',weapon = 'WEAPON_AUTOSHOTGUN', class = 'shotgun'},
                [`WEAPON_COMBATSHOTGUN`] = {reason = 'Espingarda de Combate',weapon = 'WEAPON_COMBATSHOTGUN', class = 'shotgun'},
                [`WEAPON_ASSAULTRIFLE`] = {reason = 'Rifle de Assalto',weapon = 'WEAPON_ASSAULTRIFLE', class = 'rifle'},
                [`WEAPON_ASSAULTRIFLE_MK2`] = {reason = 'Rifle de Assalto MK2',weapon = 'WEAPON_ASSAULTRIFLE_MK2', class = 'rifle'},
                [`WEAPON_CARBINERIFLE`] = {reason = 'Carabina',weapon = 'WEAPON_CARBINERIFLE', class = 'rifle'},
                [`WEAPON_CARBINERIFLE_MK2`] = {reason = 'Carabina MK2',weapon = 'WEAPON_CARBINERIFLE_MK2', class = 'rifle'},
                [`WEAPON_ADVANCEDRIFLE`] = {reason = 'Rifle Avançado',weapon = 'WEAPON_ADVANCEDRIFLE', class = 'rifle'},
                [`WEAPON_SPECIALCARBINE`] = {reason = 'Carabina Especial',weapon = 'WEAPON_SPECIALCARBINE', class = 'rifle'},
                [`WEAPON_SPECIALCARBINE_MK2`] = {reason = 'Carabina Especial MK2',weapon = 'WEAPON_SPECIALCARBINE_MK2', class = 'rifle'},
                [`WEAPON_BULLPUPRIFLE`] = {reason = 'Rifle Bullpup',weapon = 'WEAPON_BULLPUPRIFLE', class = 'rifle'},
                [`WEAPON_BULLPUPRIFLE_MK2`] = {reason = 'Rifle Bullpup MK2',weapon = 'WEAPON_BULLPUPRIFLE_MK2', class = 'rifle'},
                [`WEAPON_COMPACTRIFLE`] = {reason = 'Rifle Compacto',weapon = 'WEAPON_COMPACTRIFLE', class = 'rifle'},
                [`WEAPON_MILITARYRIFLE`] = {reason = 'Rifle Militar',weapon = 'WEAPON_MILITARYRIFLE', class = 'rifle'},
                [`WEAPON_MG`] = {reason = 'Metralhadora',weapon = 'WEAPON_MG', class = 'rifle'},
                [`WEAPON_COMBATMG`] = {reason = 'Metralhadora de Combate',weapon = 'WEAPON_COMBATMG', class = 'rifle'},
                [`WEAPON_COMBATMG_MK2`] = {reason = 'Metralhadora de Combate MK2',weapon = 'WEAPON_COMBATMG_MK2', class = 'rifle'},
                [`WEAPON_GUSENBERG`] = {reason = 'Metralhadora de Tambor',weapon = 'WEAPON_GUSENBERG', class = 'rifle'},
                [`WEAPON_SNIPERRIFLE`] = {reason = 'Rifle Sniper',weapon = 'WEAPON_SNIPERRIFLE', class = 'sniper'},
                [`WEAPON_HEAVYSNIPER`] = {reason = 'Rifle Sniper Pesado',weapon = 'WEAPON_HEAVYSNIPER', class = 'sniper'},
                [`WEAPON_HEAVYSNIPER_MK2`] = {reason = 'Rifle Sniper Pesado MK2',weapon = 'WEAPON_HEAVYSNIPER_MK2', class = 'sniper'},
                [`WEAPON_MARKSMANRIFLE`] = {reason = 'Rifle de Atirador',weapon = 'WEAPON_MARKSMANRIFLE', class = 'sniper'},
                [`WEAPON_MARKSMANRIFLE_MK2`] = {reason = 'Rifle de Atirador MK2',weapon = 'WEAPON_MARKSMANRIFLE_MK2', class = 'sniper'},
                [`WEAPON_RPG`] = {reason = 'Lança Míssel (RPG)',weapon = 'WEAPON_RPG', class = 'rpg'},
                [`WEAPON_GRENADELAUNCHER`] = {reason = 'Lançador de Granadas',weapon = 'WEAPON_GRENADELAUNCHER', class = 'rpg'},
                [`WEAPON_MINIGUN`] = {reason = 'Metralhadora Giratória',weapon = 'WEAPON_MINIGUN', class = 'rpg'},
                [`WEAPON_FIREWORK`] = {reason = 'Lança Fogos',weapon = 'WEAPON_FIREWORK', class = 'rpg'},
                [`WEAPON_RAILGUN`] = {reason = 'Arma de Raios',weapon = 'WEAPON_RAILGUN', class = 'rpg'},
                [`WEAPON_HOMINGLAUNCHER`] = {reason = 'Lança Míssel Teleguiado',weapon = 'WEAPON_HOMINGLAUNCHER', class = 'rpg'},
                [`WEAPON_COMPACTLAUNCHER`] = {reason = 'Lançador Compacto',weapon = 'WEAPON_COMPACTLAUNCHER', class = 'rpg'},
                [`WEAPON_RAYMINIGUN`] = {reason = 'Metralhadora Giratória de Raios',weapon = 'WEAPON_RAYMINIGUN', class = 'rpg'},
                [`WEAPON_GRENADE`] = {reason = 'Granada',weapon = 'WEAPON_GRENADE', class = 'grenade'},
                [`WEAPON_BZGAS`] = {reason = 'Granada Gás',weapon = 'WEAPON_BZGAS', class = 'grenade'},
                [`WEAPON_MOLOTOV`] = {reason = 'Molotov',weapon = 'WEAPON_MOLOTOV', class = 'grenade'},
                [`WEAPON_STICKYBOMB`] = {reason = 'Bomba Adesivo (C4)',weapon = 'WEAPON_STICKYBOMB', class = 'grenade'},
                [`WEAPON_PROXMINE`] = {reason = 'Mina de Proximidade',weapon = 'WEAPON_PROXMINE', class = 'grenade'},
                [`WEAPON_SNOWBALL`] = {reason = 'Bola de Neve',weapon = 'WEAPON_SNOWBALL', class = 'snowball'},
                [`WEAPON_PIPEBOMB`] = {reason = 'Bomba Caseira',weapon = 'WEAPON_PIPEBOMB', class = 'grenade'},
                [`WEAPON_BALL`] = {reason = 'Bola de Tênis',weapon = 'WEAPON_BALL', class = 'grenade'},
                [`WEAPON_SMOKEGRENADE`] = {reason = 'Granada de Fumaça',weapon = 'WEAPON_SMOKEGRENADE', class = 'grenade'},
                [`WEAPON_FLARE`] = {reason = 'Granda de Clarão',weapon = 'WEAPON_FLARE', class = 'grenade'},
                [`WEAPON_PETROLCAN`] = {reason = 'Galão de Gasolina',weapon = 'WEAPON_PETROLCAN', class = 'grenade'},
                [`WEAPON_PARACHUTE`] = {reason = 'Paraquedas',weapon = 'WEAPON_PARACHUTE', class = 'grenade'},
                [`WEAPON_FIREEXTINGUISHER`] = {reason = 'Extintor de Incêndio',weapon = 'WEAPON_FIREEXTINGUISHER', class = 'grenade'},
                [`WEAPON_HAZARDCAN`] = {reason = 'Rezidos Inflamáveis',weapon = 'WEAPON_HAZARDCAN', class = 'grenade'},
            }
            
            RegisterNetEvent('suricato:playerKilled', function(killedBy, data)
            	local victim,assasin,reason,x,y,z,weaponed,weaponClass = source,killedBy,data.weaponhash,table.unpack(data.killerpos)  
                if victim and assasin then
                    if tn(assasin) == -1 or tn(assasin) == tn(victim) then 
                        assasin = false 
                    else 
                        if cfg.hitmarker then 
                            TriggerClientEvent('robhitmarker', assasin)
                        end
                    end 
                    local inRobbery,name,key,team = IsInRobbery(victim)
                    if not tn(key) then 
                        return
                    end
                    local inRobbery2,name2,key2,team2
                    if assasin then
                        inRobbery2,name2,key2,team2 = IsInRobbery(assasin)
                    end
                    if reasonsKill[tn(reason)] and reasonsKill[tn(reason)].reason and reasonsKill[tn(reason)].weapon and reasonsKill[tn(reason)].class then
                        weaponClass = ts(reasonsKill[tn(reason)].class) 
                        weaponed = cfg.WeaponClassIcons[weaponClass]
                        reason = ts(reasonsKill[tn(reason)].reason) 
                    else 
                        weaponed = cfg.WeaponClassIcons.unarmed
                        weaponClass = 'unarmed' 
                        reason = 'O motivo da morte do jogador não foi encontrada!' 
                    end
                    local times = {cops='Policiais',bandits='Bandidos',hostages='Reféns'}
                    if inRobbery then
                        if assasin then
                            if inRobbery2 then
                                if key == key2 then
                                    AnyKillInRobbery(tn(key),{ parseInt(victim), ts(team) },weaponed,{ parseInt(assasin), team2 })
                                    CreateThread(function()
                                        local victim_datatable = table.clone(GetPlayerTable(victim) or {})                
                                        local assasin_datatable = table.clone(GetPlayerTable(assasin) or {})
                                        if type(victim_datatable) ~= 'table' or not victim_datatable.name or not victim_datatable.id then 
                                            local victim_id = tonumber(victim_datatable.id) or config.getUserId(parseInt(victim)) or 'Não definido!'
                                            local victim_identity = config.getUserIdentity(victim_id) or {}
                                            victim_datatable = { 
                                                id = victim_id,
                                                name = tostring(victim_identity.name or '').. ' '..tostring(victim_identity.firstname or '')
                                            }
                                        end
                                        if type(assasin_datatable) ~= 'table' or not assasin_datatable.name or not assasin_datatable.id then 
                                            local assasin_id = tonumber(assasin_datatable.id) or config.getUserId(parseInt(assasin)) or 'Não definido!'   
                                            local assasin_identity = config.getUserIdentity(assasin_id) or {}
                                            assasin_datatable = { 
                                                id = assasin_id,
                                                name = tostring(assasin_identity.name or '').. ' '..tostring(assasin_identity.firstname or '')
                                            }
                                        end        
                                        createScreenEmbed(assasin,cfg.webhook_killsrob,"**REGISTRO DE KILL:**","**USUÁRIO ASSASSINO:**","```ini\n["..ts(assasin_datatable.id).."] "..ts(assasin_datatable.name).."\n[🛡️]: "..ts(times[team2]):upper().."```\n","**USUÁRIO VÍTIMA:**","```ini\n["..ts(victim_datatable.id).."] "..ts(victim_datatable.name).."\n[🛡️]: "..ts(times[team]):upper().."```\n","**COORDENADAS DA MORTE**:",'```'..ts(x)..','..ts(y)..','..ts(z)..'``` \n',"**CAUSA DA MORTE:**",reason,"**ROUBO:**",ts(name):upper().."\n⠀")
                                    end)    
                                    return true
                                end
                            else
                                AnyKillInRobbery(tn(key),{ parseInt(victim), ts(team) },weaponed)
                                CreateThread(function()
                                    local victim_datatable = table.clone(GetPlayerTable(victim) or {})                
                                    local assasin_datatable = table.clone(GetPlayerTable(assasin) or {})
                                    if type(victim_datatable) ~= 'table' or not victim_datatable.name or not victim_datatable.id then 
                                        local victim_id = tonumber(victim_datatable.id) or config.getUserId(parseInt(victim)) or 'Não definido!'
                                        local victim_identity = config.getUserIdentity(victim_id) or {}
                                        victim_datatable = { 
                                            id = victim_id,
                                            name = tostring(victim_identity.name or '').. ' '..tostring(victim_identity.firstname or '')
                                        }
                                    end
                                    if type(assasin_datatable) ~= 'table' or not assasin_datatable.name or not assasin_datatable.id then 
                                        local assasin_id = tonumber(assasin_datatable.id) or config.getUserId(parseInt(assasin)) or 'Não definido!'   
                                        local assasin_identity = config.getUserIdentity(assasin_id) or {}
                                        assasin_datatable = { 
                                            id = assasin_id,
                                            name = tostring(assasin_identity.name or '').. ' '..tostring(assasin_identity.firstname or '')
                                        }
                                    end
                                    createScreenEmbed(assasin,cfg.webhook_killsrob,"**REGISTRO DE KILL:**","**USUÁRIO ASSASSINO:**","```ini\n["..ts(assasin_datatable.id).."] "..ts(assasin_datatable.name).." \n[🛡️]: O ASSASSINO não está participando do roubo!```\n","**USUÁRIO VÍTIMA:**","```ini\n["..ts(victim_datatable.id).."] "..ts(victim_datatable.name).."\n[🛡️]: "..ts(times[team]):upper().."```\n","**COORDENADAS DA MORTE**:",'```'..ts(x)..','..ts(y)..','..ts(z)..'``` \n',"**CAUSA DA MORTE:**",reason,"**ROUBO:**",ts(name):upper().."\n⠀")
                                end)
                                return true
                            end
                        else
                            AnyKillInRobbery(tn(key),{ parseInt(victim), ts(team) },weaponed)
                            CreateThread(function()
                                local victim_datatable = table.clone(GetPlayerTable(victim) or {})                
                                if type(victim_datatable) ~= 'table' or not victim_datatable.name or not victim_datatable.id then 
                                    local victim_id = tonumber(victim_datatable.id) or config.getUserId(parseInt(victim)) or 'Não definido!'
                                    local victim_identity = config.getUserIdentity(victim_id) or {}
                                    victim_datatable = { 
                                        id = victim_id,
                                        name = tostring(victim_identity.name or '').. ' '..tostring(victim_identity.firstname or '')
                                    }
                                end
                                createScreenEmbed(assasin,cfg.webhook_killsrob,"**REGISTRO DE MORTE:**","**USUÁRIO VÍTIMA:**","```ini\n["..ts(victim_datatable.id).."] "..ts(victim_datatable.name).."\n[🛡️]: "..ts(times[team]):upper().."```\n","**COORDENADAS DA MORTE**:",'```'..ts(x)..','..ts(y)..','..ts(z)..'``` \n',"**CAUSA DA MORTE:**",reason,"**ROUBO:**",ts(name):upper().."\n")
                            end)
                            return true
                        end
                    end
                end
            end)
            
            ----==={ FUNÇÕES PARA EVENTOS FIVEM }===----
            local combatlog = {}
            local reasons = {}
            selectMenu = {}
            
            RegisterNetEvent(Resource..':playerSpawned', function()
                local source = source
                while not ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 do 
                    Wait(1000)
                end
                fClient._updateRobberyPoints(source,RobberyCache)
                
                local user_id = config.getUserId(source)
                if user_id and (combatlog or {})[user_id] then
                    Wait(5000)
                    TriggerClientEvent('robnotify',source,'aviso','Você deslogou na última ação, e voltou finalizado!',10000)
                    config.setHealth(source,100)
                    combatlog[user_id] = nil
                end
            end)
            
            AddEventHandler('playerDropped',function(reason)
                local source = source
                reasons[source] = reason
            end)
            
            function playerDropped(user_id, source) 
                local isRobbery,name,key,team = IsInRobbery(source, user_id)
                local weaponed = 'SUICIDE'
                if selectMenu[source] and ActualRobberies[selectMenu[source]] and not ActualRobberies[selectMenu[source]].init then
                    TriggerEvent('tryrobnotify', selectMenu[source], 'negado', 'O roubo foi cancelado, pois quem estava selecionando os integrantes foi desconectado!', 8000)
                    fServer._cancelRobbery(selectMenu[source])
                    selectMenu[source] = nil
                end
                if isRobbery then
                    AnyKillInRobbery(tn(key),{ parseInt(source), ts(team) },weaponed)
                    
                    if not name then 
                        name = 'Nome do roubo não definido!' 
                    end
                        
                    if user_id then 
                        local identity = config.getUserIdentity(user_id) or {}
                        if ts(team) == 'cops' then 
                            team = 'Policiais' 
                        elseif team == 'bandits' then 
                            team = 'Bandidos' 
                        end
                        createEmbed(cfg.webhook_cl,"**REGISTRO DE COMBATLOG:**","**USUÁRIO:**","```ini\n["..ts(user_id).."] "..ts(identity.name).." "..ts(identity.firstname).."```\n","**REASON**:",ts(reasons[source] or 'Não encontrado.').."\n","**TIME**:",ts(team).."\n","**ROUBO:**",ts(name):upper().."\n⠀")
                        combatlog[user_id] = true
                    end
                end
            end
        end
        _G["server-side/events.lua"]()
        
        _G["server-side/thread.lua"] = function()
            local ts,tn = tostring,tonumber
            ----==={ THREADS (CITIZEN) }===----
            
            CreateThread(function()
                Wait(2000)
                while not ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 do 
                    Wait(1000)
                end
                local createDatabase = ([[
                    CREATE TABLE IF NOT EXISTS `suricato_robbery_history` (
                        `id` int(11) NOT NULL AUTO_INCREMENT,
                        `name` varchar(255) DEFAULT NULL,
                        `winner` varchar(255) DEFAULT NULL,
                        `duration` int(11) DEFAULT NULL,
                        `killfeed` varchar(10000) DEFAULT NULL,
                        `time` bigint(11) DEFAULT NULL,
                    PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4;
                    CREATE TABLE IF NOT EXISTS `suricato_robbery_presets` (
                        `name` varchar(255) NOT NULL,
                        `awarddarkmoney` tinyint(1) NOT NULL DEFAULT 0,
                        `awardmin` int(11) NOT NULL DEFAULT 0,
                        `awardmax` int(11) NOT NULL DEFAULT 0,
                        `minigame` tinyint(11) NOT NULL DEFAULT 0,
                        `animation` varchar(100) DEFAULT '',
                        `animationtime` int(11) DEFAULT 0,
                        `projection` longtext NOT NULL DEFAULT '[]',
                        `permission` varchar(255) DEFAULT '',
                        `items` longtext DEFAULT '[]',
                        `iswanted` tinyint(1) DEFAULT 0,
                        `cooldown` int(11) DEFAULT 0,
                    PRIMARY KEY (`name`) USING BTREE
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                    CREATE TABLE IF NOT EXISTS `suricato_roberry_points` (
                        `count` int(11) NOT NULL AUTO_INCREMENT,
                        `preset` varchar(50) NOT NULL,
                        `cds` varchar(255) NOT NULL,
                    PRIMARY KEY (`count`),
                    KEY `FK_suricato_roberry_points_suricato_robbery_presets` (`preset`),
                    CONSTRAINT `FK_suricato_roberry_points_suricato_robbery_presets` FOREIGN KEY (`preset`) REFERENCES `suricato_robbery_presets` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
                    ) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;
                ]]):split(';')
                for k,v in next,(createDatabase or {}) do
                    if type(v) == 'string' and v:match('%w') then 
                        config:query(v)
                    end
                end
                Wait(3000)
            
                UpdateRobberyPoints()
            end)
            
            ----==={ COMANDOS }===----
            
            local CommandArgumentos = {
                admin = RobberyOpenAdmin,
            }
            
            RegisterCommand('suricato',function(source,args)
                if not ________________________________________ALQukNCcWKW9dF9h0GkPbarTW7PlrVu33t1gHZp9 then 
                    return
                end
                if args[1] ~= 'roubos' then return end
                CommandArgumentos.admin(source)
            end)
            
        end
        _G["server-side/thread.lua"]()
        
            
    else
            _G["client-side/function.lua"] = function()
            ----==={ VARIÁVEIS }===----
            
            local ts,tn = tostring,tonumber
            inPainel = false
            RobberyPoints,blips = {},{}
            isInRobbery = false
            myidentifier = false
            ActualRobbery,Team = nil
            
            setmetatable(blips, {__index = table})
            
            ----==={ FUNÇÕES USADAS DO INICIO AO FIM DO ROUBO }===----
            
            function wait(self)
            	local await = Citizen.Await(self.p)
            	if not await then
            		await = self.r 
            	end
                local maxn = function(t)
                    local max = 0
                    for k,v in pairs(t) do
                        local n = tonumber(k)
                        if n and n > max then max = n end
                    end
                    return max
                end
            	return table.unpack(await,1,maxn(await))
            end
            
            function playerDie() -- FUNÇÃO DE MORTE 
                CreateThread(function()
                    local ped = PlayerPedId()
                    config.setHealth(ped, 101)
                    config.setInvincible(ped,true)
                    config.stopAnim()
                    config:blockControls(true)
                    SetPedToRagdoll(ped,1000,1000,0,0,0,0)
                    local deathfailout = function()
                        if not isAlive and not spectating then
                            AnimpostfxPlay("DeathFailOut")
                        else
                            AnimpostfxStop("DeathFailOut")
                        end
                    end
                    CreateThread(function()
                        deathfailout()
                        PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
                        ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
                        
                        local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
            
                        while not HasScaleformMovieLoaded(scaleform) do
                            scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
                            Wait(0)
                        end
            
                        if HasScaleformMovieLoaded(scaleform) then
                            Wait(0)
                            PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                            BeginTextComponent("STRING")
                            AddTextComponentString("~r~você morreu")
                            EndTextComponent()
                            PopScaleformMovieFunctionVoid()
                            Wait(500)
                            PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
                        end
                        while not config.isAlive(ped) do
                            config.setArmour(ped,0)   
                            config.setHealth(ped, 101)
                            config.setInvincible(ped,true)
                            SetPedToRagdoll(ped,1000,1000,0,0,0,0)
                            DisablePlayerFiring(PlayerId())
                            if not spectating then
                                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                            end
                            Wait(0)
                        end 
                        spectating = false
                        isAlive = true
                        config:blockControls(false)
                        config.stopAnim()
                        AnimpostfxStop("DeathFailOut")
                        fServer.revive()
                    end)
                    Wait(5000)
                    local getLivePlayers = function()
                        local livePlayers = {}
                        if ActualRobbery and ActualRobbery[Team] then
                            for k,v in ipairs(ActualRobbery[Team]) do
                                if v.isvivo and v.id ~= myidentifier then
                                    table.insert(livePlayers, v)
                                end
                            end
                        end
                        return livePlayers
                    end
                    local livePlayers = getLivePlayers()
                    if #livePlayers > 0 then
                        local i = #livePlayers
                        local spectatePlayer = function(data)
                            local playerSrc = data.source
                            if playerSrc then
                                local playerPed = GetPlayerPed(GetPlayerFromServerId(playerSrc))
                                if playerPed and DoesEntityExist(playerPed) and GetEntityHealth(playerPed) > 101 and GetEntityHealth(ped) <= 101 then
                                    if spectedPlayer and spectedPlayer == playerSrc then return end
                                    NetworkSetInSpectatorMode(true, playerPed)
                                    AnimpostfxStop("DeathFailOut")
                                    spectedPlayer = data
                                    OpenNUI({ action = 'Spectating', player = spectedPlayer, admin = false },false)
                                    CreateThread(function()
                                        local actualspectate = data
                                        if actualspectate then
                                            repeat
                                                if Team and type(ActualRobbery[ts(Team)]) == 'table' then
                                                    for k,v in next,ActualRobbery[ts(Team)] do
                                                        if tn(actualspectate.id) == tn(v.id) then
                                                            if not v.isvivo then
                                                                goToNextPlayer()
                                                                return
                                                            end
                                                        end
                                                    end
                                                else return end
                                                Wait(1000)
                                            until (tn(spectedPlayer.id) ~= actualspectate)
                                        end
                                    end)
                                end
                            end
                        end
                        goToNextPlayer = function()
                            if ActualRobbery then
                                livePlayers = getLivePlayers()
                                if #livePlayers > 0 then
                                    i = i + 1
                                    while not livePlayers[i] do
                                        i = i + 1
                                        if i > #livePlayers  then 
                                            i = 1
                                            break
                                        end
                                        Wait(1)
                                    end
                                    spectatePlayer(livePlayers[i])
                                else
                                    spectating = false
                                end
                            else
                                spectating = false
                            end
                        end
                        goToBackPlayer = function()
                            if ActualRobbery then
                                livePlayers = getLivePlayers()
                                if #livePlayers > 0 then
                                    i = i - 1
                                    while not livePlayers[i] do
                                        i = i - 1
                                        if i < 1 then 
                                            i = #livePlayers
                                            break
                                        end
                                        Wait(1)
                                    end
                                    spectatePlayer(livePlayers[i])
                                else
                                    spectating = false
                                end
                            else
                                spectating = false
                            end
                        end
                        spectatePlayer(livePlayers[i])
                        spectating = true
                        while spectating do
                            if IsDisabledControlJustPressed(0, 174) or IsDisabledControlJustPressed(0, 34) or IsDisabledControlJustPressed(0, 24) then
                                goToNextPlayer()
                            elseif IsDisabledControlJustPressed(0, 175) or IsDisabledControlJustPressed(0, 35) or IsDisabledControlJustPressed(0, 25) then
                                goToBackPlayer()
                            end
            
                            if spectedPlayer and not spectedPlayer.isvivo then
                                goToNextPlayer()
                            end
                            local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(spectedPlayer.source)))
                            if coords.x and coords.y then 
                                RequestCollisionAtCoord(coords.x, coords.y)
                            end
                            Wait(0)
                        end
                        CloseNUI()
            
                        OpenNUI({ action = 'Spectating', player = false },false)
                        goToNextPlayer,goToBackPlayer = nil,nil
                        NetworkSetInSpectatorMode(false)
                        deathfailout()
                        spectedPlayer = nil
                    end
                end)
                OpenNUI({ action = 'ClosePainel' }, false)
                CloseNUI()
            end
            
            function showKeyForScoreboard()
                local showWarn = true
                AddTextEntry('warning_line_1', 'Pressione  ~INPUT_7C07FAA7~  para abrir o menu do roubo.')
                CreateThread(function()
                    SetTimeout(8000, function()
                        showWarn = false
                    end)
                    while showWarn do
                        Wait(0)
                        SetWarningMessage("warning_line_1", 2, false, false, -1, false, false, false, 0)
                        if IsDisabledControlJustPressed(2,201) or IsDisabledControlJustPressed(2,215) then 
                            showWarn = false
                        end
                    end
                end)
            end
            
            function spectedPlayerAdmin(data)
                local playerSrc = data.source
                local ped = PlayerPedId()
                if spectedPlayer then 
                    TriggerEvent('robnotify','negado','Você já está espectando alguém!',8000)
                    return
                elseif not config.isAlive(ped) then 
                    TriggerEvent('robnotify','negado','Você está morto, e não pode espectar!',8000)
                    return
                elseif isInRobbery then 
                    TriggerEvent('robnotify','negado','Você está em um roubo, e não pode espectar!',8000)
                    return
                end
                if playerSrc then
                    local playerPed = GetPlayerPed(GetPlayerFromServerId(playerSrc))
                    if playerPed and DoesEntityExist(playerPed) then
                        if spectedPlayer and spectedPlayer == playerSrc then 
                            return 
                        end
                        NetworkSetInSpectatorMode(true, playerPed)
                        
                        config.setVisible(PlayerPedId(), false)
                        spectedPlayer = data
                        OpenNUI({ action = 'Spectating', player = spectedPlayer, admin = true },false)
                        
                        CreateThread(function()
                            repeat
                                DrawTxt("PRESSIONE  ~r~G~w~  PARA ENVIAR UMA PRINT DA TELA DO JOGADOR",4,0.5,0.90,0.50,255,255,255,200)
                                DrawTxt("PRESSIONE  ~r~F~w~  PARA SAIR DA TELA DO JOGADOR",4,0.5,0.875,0.50,255,255,255,200)
                                if IsDisabledControlJustPressed(0,47) then
                                    fServer._PrintScreenUser(spectedPlayer.source)
                                    TriggerEvent('robnotify','sucesso','Você tirou uma print da tela do jogador que está espectando!',8000)
                                end
                                if IsDisabledControlJustPressed(0,23) then
                                    spectedPlayer = nil 
                                    break
                                end
            
                                local coords = GetEntityCoords(playerPed)
                                if coords.x and coords.y then 
                                    RequestCollisionAtCoord(coords.x, coords.y)
                                end
                                Wait(1)
                            until spectedPlayer == nil or not config.isAlive(ped)-- or isInRobbery
                            NetworkSetInSpectatorMode(false)
                            OpenNUI({ action = 'Spectating', player = false },false)
                            config.setVisible(PlayerPedId(), true)
                        end)
                    end
                end
            end
            
            ----==={ FUNÇÕES EXTRAS }===----
            
            function DrawText3D(x, y, z, text)
            	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
            	-- local px,py,pz=table.unpack(GetGameplayCamCoords())
            	
            	SetTextScale(0.39, 0.39)
            	SetTextFont(4)
            	SetTextProportional(1)
            	SetTextColour(255, 255, 255, 235)
            	SetTextEntry("STRING")
            	SetTextCentre(1)
            	AddTextComponentString(text)
            	DrawText(_x,_y)
            	local factor = (string.len(text)) / 270
            	DrawRect(_x,_y+0.0125, 0.005+ factor, 0.04, 0, 0, 0, 145)
            end
            
            function DrawTxt(text,font,x,y,scale,r,g,b,a)
            	SetTextFont(font)
            	SetTextScale(scale,scale)
            	SetTextColour(r,g,b,a)
            	SetTextOutline()
            	SetTextCentre(1)
            	SetTextEntry("STRING")
            	AddTextComponentString(text)
            	DrawText(x,y)
            end
            
            function OpenNUI( table,focus )
                if type(table) ~= 'table' then return end
                SendNUIMessage(table)
                if focus then
                    inPainel = true
                    SetNuiFocus(focus, focus)
                    TriggerScreenblurFadeIn(2000)
                end
            end
            
            function CloseNUI()
                inPainel = false
                SetNuiFocus(false, false)
                TriggerScreenblurFadeOut(500)
            end
        end
        _G["client-side/function.lua"]()
        
        _G["client-side/tunnel.lua"] = function()
            ----==={ VARIÁVEIS }===----
            
            local ts,tn = tostring,tonumber
            local important_warns = {
                ['bandits'] = 'O roubo iniciou, a qualquer momento os policiais poderão chegar!',
                ['cops'] = 'O roubo iniciou, a localização já está marcada!',
                ['hostages'] = 'O roubo iniciou, coopere para sobreviver!',
                Warn = function(self,team)
                    TriggerEvent('robnotify', 'importante', ts(self[team]), 8000)
                end
            }
            
            ----==={ FUNÇÕES TUNNELADAS DO INICIO AO FIM DO ROUBO }===----
            
            local requests = {}
            
            -- Função não tão boa, seria mais interessante usar callbacks, Mas eles parecem não funcionarem tanto na interação client-server
            function tServer.tryHacking(minigame) -- FUNÇÃO PARA HACKEAR (TEMPORÁRIO)
                return config:executeHacking(minigame)
            end
            
            function tServer.SelectCops(key,cops,needcops,bandits,hostages,name) -- FUNÇÃO CLIENT, QUE SELECIONA OS COPS
                if not tn(key) then return end if type(cops) ~= 'table' or not needcops or not bandits or not hostages then return end
            
                inSelectTeam = true
                OpenNUI({ action = 'CopsTeam', key = tn(key), nusers = cops, needcops = parseInt(tn(needcops)), bandits = parseInt(tn(bandits)), hostages = parseInt(tn(hostages)), name = ts(name), cops = {} },true)
            end
            
            function tServer.initRobbery(robbery,team)
                if not robbery or type(robbery) ~= 'table' or type(team) ~= 'string' then return end
                ActualRobbery = robbery
                isInRobbery,Team,isAlive = true,team,tServer.isAlive()
                TriggerEvent('suricato_roubos:updateRobbery',true)
                
                OpenNUI({action = 'UpdatingHud', robbery = ActualRobbery, team = Team, initialUpdate = true},false)
                showKeyForScoreboard()
            
                CreateThread(function()
                    if ActualRobbery.pusher == GetPlayerServerId(PlayerId()) and GetPlayerServerId(PlayerId()) ~= 0 then 
                        OpenNUI({ action = 'CloseLoadscreen' }, false)
                        CloseNUI()
                        local response;
                        local initAnim = GetGameTimer()
                        local typeMoney; 
                        if ActualRobbery.isDarkMoney then 
                            typeMoney = 'darkmoney'
                        else 
                            typeMoney = 'money'
                        end
                        if ActualRobbery.animation and ActualRobbery.animation:len() > 0 then 
                            if type(ActualRobbery.cds) == 'vector3' then 
                                SetEntityCoords(PlayerPedId(),ActualRobbery.cds)
                            end
                            ExecuteCommand(ActualRobbery.animation)
                            config:blockControls(true)
                            SetTimeout(parseInt(ActualRobbery.animationTime)*1000, function()
                                if not response then
                                    config.stopAnim()
                                    config:blockControls(false)
                                    response = true
                                end
                            end)
                        else 
                            response = true
                        end
                        local ped = PlayerPedId()
                        while not response and config.isAlive(ped) do
                            local timePast = math.abs(math.floor((GetGameTimer() - initAnim) / 1000 ))
                            local seconds = parseInt(ActualRobbery.animationTime) - timePast
                            if seconds > 0 then 
                                DrawTxt("FALTAM   ~r~"..tostring(seconds).."~w~  SEGUNDOS PARA TERMINAR DE ROUBAR",4,0.5,0.90,0.50,255,255,255,200)
                            end
                            Wait(0)
                        end 
                        if config.isAlive(ped) then 
                            local award = ActualRobbery.estimatedValue
                            local paid = fServer.giveAwards(parseInt(award), typeMoney)
                            if paid then 
                                TriggerEvent('robnotify','sucesso','Você roubou R$'..tostring(config.format(parseInt(award)))..',00 em dinheiro!')
                            end
                        else 
                            response = true
                        end
                    end
                end)
                
                SetTimeout(1000, function()
                    important_warns:Warn(Team)
                end)
            end
            
            function tServer.cancelRobbery()
                config:blockControls(false)
                config.stopAnim()
                OpenNUI({ action = 'CloseLoadscreen' }, false)
                CloseNUI()
            end
            
            function tServer.updateActualRobbery(obj)
                if obj then
                    if type(obj) ~= 'table' then return end
                    ActualRobbery = obj
                    local Team = fServer.GetMyTeam(ActualRobbery)
                    OpenNUI({action = 'UpdatingHud', robbery = ActualRobbery, team = Team},false)
                    return
                end
            
                ActualRobbery = {}
                isInRobbery,Team = false
                spectating = false
                OpenNUI({action = 'UpdatingHud', robbery = false},false)
                TriggerEvent('suricato_roubos:updateRobbery',false)
            end
            
            ----==={ FUNÇÕES TUNNELADAS POINTS }===----
            
            function tServer.openAdminPainel()
                if not inPainel then 
                    OpenNUI({action = 'openAdminPainel'},true)
                end
            end
            
            function tServer.updateRobberyPoints(obj)
                RobberyPoints = obj
            end
            
            ----==={ FUNÇÕES EXTRAS }===----
            
            function tServer.getPosition() 
                return table.unpack(GetEntityCoords(PlayerPedId()))
            end
            
            function tServer.createCopsBlip(vec,name,cooldown)
                if not vec then return end
                if not name then name = '' end
                blips:insert(AddBlipForCoord(vec))
                local blip = blips[#blips]
            
                if DoesBlipExist(blip) then
                    SetBlipScale(blip,0.5)
                    SetBlipSprite(blip,1)
                    SetBlipColour(blip,27)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Roubo: ~r~"..ts(name))
                    EndTextCommandSetBlipName(blip)
                    SetBlipAsShortRange(blip,false)
                    SetBlipRoute(blip,true)
                end
            
                SetTimeout(tn(cooldown) * 1000, function()
                    RemoveBlip(blip)
                end)
            end
            
            function tServer.request(msg,sleep)
                if not tn(sleep) or not msg then return end
                local new_request = parseInt(#requests + 1)
                SendNUIMessage({ action = 'RegisterRequest', id = new_request, msg = msg })
                requests[new_request] = setmetatable({ p = promise.new(), wait = function(this) return Citizen.Await(this.p) end },{ __call = function(self,...) 
                    if self.p then
                        self.p:resolve(({...})[1])
                    end
                    SendNUIMessage({ action = 'DeleteRequest', id = new_request, accepted = ({...})[1] })
                end})
                SetTimeout(parseInt(sleep) * 1000, function() finishRequest(new_request,false) end)
                return requests[new_request]:wait()
            end 
            
            function finishRequest(id,res)
                if id and requests[id] then
                    requests[id](res)
                    requests[id] = nil
                end
            end
            
            RegisterCommand(GetCurrentResourceName()..':request', function(source,args)
                if not args[1] or not (args[1] == 'Y' or args[1] == 'U') then return end
                for k,v in next,requests do
                    finishRequest(k,args[1] == 'Y')
                    return
                end
            end)
        end
        _G["client-side/tunnel.lua"]()
        
        _G["client-side/events.lua"] = function()
            local request = nil
            local ts,tn = tostring,tonumber
            
            ----==={ NOTIFY }===----
            
            RegisterNetEvent('robnotify', function(style,content,sleep)
                local styles = { negado = true, sucesso = true, aviso = true, importante = true } 
                if not styles[style] or not content then return end 
                sleep = tn(sleep) or 8000
                OpenNUI({ style = style, content = content, sleep = sleep, action = 'NotifyMessage' }, false)
            end)
            
            ----==={ REQUEST }===----
            
            RegisterKeyMapping(GetCurrentResourceName()..':request Y','Aceitar request','KEYBOARD','Y')
            RegisterKeyMapping(GetCurrentResourceName()..':request U','Recusar request','KEYBOARD','U')
            
            ----==={ KILL FEED }===---- 
            
            RegisterNetEvent('killfeed', function(victim,reason,killer,team,team2)
                if type(victim) ~= 'string' or type(reason) ~= 'string' then return end
                local Team = Team or ts(fServer.GetMyTeam(ActualRobbery) or '')
                if killer then
                    OpenNUI({ type = 'kill', victim = { name = ts(victim) , team = ts(team) }, killer = { name = ts(killer) , team = ts(team2) }, icon = ts(reason),  myteam = ts(Team), action = 'KillFeed'},false)
                    return
                end
                OpenNUI({ type = 'death', victim = { name = ts(victim) , team = ts(team) }, icon = ts(reason),  myteam = ts(Team), action = 'KillFeed'},false)
            end)
            
            ----==={ HIT MARKER }===----
            
            RegisterNetEvent('robhitmarker', function(color)
                OpenNUI({ action = 'Hitmarker' }, false)
            end)
            
            
            ----==={ WINNER NOTIFY }===----
            
            RegisterNetEvent('winnernotify', function(team)
                if type(team) ~= 'string' then return end
                OpenNUI({ action = 'WinnerNotify', winner = ts(team) }, false)
            end)
            
            ----==={ KILL EVENT }===----
            
            local isNear = false
            
            local meeleWeapons = {
                ["0"] = true,
                [`WEAPON_UNARMED`] = true,
                [`WEAPON_RUN_OVER_BY_CAR`] = true,
                [`WEAPON_RAMMED_BY_CAR`] = true,
                [`VEHICLE_WEAPON_ROTORS`] = true,
                [`WEAPON_DAGGER`] = true,
                [`WEAPON_BAT`] = true,
                [`WEAPON_BOTTLE`] = true,
                [`WEAPON_CROWBAR`] = true,
                [`WEAPON_FLASHLIGHT`] = true,
                [`WEAPON_GOLFCLUB`] = true,
                [`WEAPON_HAMMER`] = true,
                [`WEAPON_HATCHET`] = true,
                [`WEAPON_KNUCKLE`] = true,
                [`WEAPON_KNIFE`] = true,
                [`WEAPON_MACHETE`] = true,
                [`WEAPON_SWITCHBLADE`] = true,
                [`WEAPON_NIGHTSTICK`] = true,
                [`WEAPON_WRENCH`] = true,
                [`WEAPON_BATTLEAXE`] = true,
                [`WEAPON_POOLCUE`] = true,
                [`WEAPON_STONE_HATCHET`] = true,
                [`WEAPON_GRENADE`] = true,
                [`WEAPON_BZGAS`] = true,
                [`WEAPON_MOLOTOV`] = true,
                [`WEAPON_STICKYBOMB`] = true,
                [`WEAPON_PROXMINE`] = true,
                [`WEAPON_SNOWBALL`] = true,
                [`WEAPON_PIPEBOMB`] = true,
                [`WEAPON_BALL`] = true,
                [`WEAPON_SMOKEGRENADE`] = true,
                [`WEAPON_FLARE`] = true,
                [`WEAPON_PETROLCAN`] = true,
                [`WEAPON_PARACHUTE`] = true,
                [`WEAPON_FIREEXTINGUISHER`] = true,
                [`WEAPON_HAZARDCAN`] = true
            }
            
            local timeout = 0
            
            AddEventHandler('gameEventTriggered', function (event, args)
                if event ~= 'CEventNetworkEntityDamage' then return end
                local data = {
                    victim = args[1],
                    attacker = args[2],
                }
                if IsEntityAPed(data.victim) then
                    local ped = PlayerPedId()        
                    local gameTimer = GetGameTimer()
                    if data.victim == ped and timeout < gameTimer then
                        local source = -1
                        local weapon = "0"
                        if DoesEntityExist(data.attacker) and IsPedAPlayer(data.attacker) and data.attacker ~= data.victim then 
                            source = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.attacker))
                            weapon = ({GetCurrentPedWeapon(data.attacker)})[2]
                        end
                        local _,bone = GetPedLastDamageBone(ped)
                        if (bone and bone == 31086 and not meeleWeapons[weapon]) or not config.isAlive(ped) then 
                            if isInRobbery then
                                timeout = gameTimer + 500
                                config.setHealth(ped, 100)
                                local coords = GetEntityCoords(ped)
                                playerDie()
                                TriggerServerEvent('suricato:playerKilled', source, {weaponhash = weapon, killerpos = coords})
                                isAlive = false
                            end
                        end
                    end
                end
            end)
            
            ----==={ FUNÇÕES PARA EVENTOS FIVEM }===----
            
            AddEventHandler('onResourceStop', function(resourceName)
                if (Resource ~= resourceName) then return end
                TriggerEvent('suricato_roubos:updateRobbery',false)
                CloseNUI()
                
                AnimpostfxStop("DeathFailOut")
                NetworkSetInSpectatorMode(false)
                config:blockControls(false)
                config.stopAnim()
                spectedPlayer = nil
            end)
            
            AddEventHandler("playerSpawned",function()
                TriggerServerEvent(Resource..':playerSpawned')
            end)
        end
        _G["client-side/events.lua"]()
        
        _G["client-side/callback.lua"] = function()
            ----==={ LISTA DE CALLBACKS }===----
            
            local ts,tn = tostring,tonumber
            local CallBacks = {
                ['createPreset'] = function(data)
                    if type(data) ~= 'table' then 
                        return 
                    end
                    return fServer.createPreset(data)
                end,
                ['getPresets'] = function(data)
                    return fServer.getPresets()
                end,
                ['deletePreset'] = function(data)
                    if not data.name then return end 
                    return fServer.deletePreset(data.name)
                end,
                ['addRobbery'] = function(data)
                    if not data.preset or not data.cds or not data.cds.x or not data.cds.y or not data.cds.z then 
                        return 
                    end
                    return fServer.addRobbery(data)
                end,
                ['remRobbery'] = function(data)
                    if data.count then
                        return fServer.remRobbery(data.count)
                    end
                end,
                ['getRobberies'] = function(data)
                    return fServer.getRobberies()
                end,
                ['getCoords'] = function(data)
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
                    if x and y and z then
                        return { x = x, y = y, z = z }
                    end
                    return { x = 0.0, y = 0.0, z = 0.0 }
                end,
                ['getPresetsName'] = function(data)
                    return fServer.getPresetsName() or {}
                end,
                ['takeBanditsForRob'] = function(data)
                    inSelectTeam = false
                    if type(data) ~= 'table' or not data.key or not data.bandits or not data.hostages then 
                        return {status = false, msg = 'Algum dado não foi recebido!'} 
                    end
                    local response = fServer.tryStartRobbery(tn(data.key),data.bandits,data.hostages) -- INTRODUZIR KEY COMO PRIMEIRO PARÂMETRO, TIRAR O PARÂMETRO NAME, POIS DA PRA PEGAR O NAME SABENDO A KEY!
                    if not response.status then 
                        fServer._cancelRobbery(data.key)
                    end
                    return response
                end,
                ['takeCopsForRob'] = function(data)
                    CloseNUI()
                    inSelectTeam = false
                    if type(data) ~= 'table' or not tn(data.key) or not data.cops then 
                        return 
                    end
                    local err,msg = fServer.adminCheck(tn(data.key),data.cops)
                    if not err then
                        TriggerServerEvent('tryrobnotify', tn(data.key), 'negado', ts(msg), 8000)
                        fServer._cancelRobbery(data.key)
                        return
                    end
                end,
                ['getGiveUpInfos'] = function(data)
                    local consult = fServer.getStateForGiveUp(Team)
                    return consult
                end,
                ['voteGiveUpinRobbery'] = function(data)
                    local result = fServer.voteRobberyGiveUp(Team)
                    if result.status then
                        CloseNUI()
                    end
                    return result
                end,
                ['openHistoricRobberys'] = function(data)
                    if type(data) ~= 'table' then 
                        return {}
                    end
            
                    data.limit = 50
                    data.offset = 0
                    if data.limit and data.offset then
                        return fServer.getHistoric(data.offset,data.limit)
                    end
                end,
                ['openNotify'] = function(data)
                    return fServer.getNotifyAuth()
                end,
                ['responseAdminNotify'] = function(data)
                    if data.status ~= nil and data.key then
                        return fServer.authorizeRobbery(tn(data.key),data.status) or {}
                    end
                end,
                ['spectateUserInRobberyNow'] = function(data)
                    CloseNUI()
                    if type(data) == 'table' then 
                        if type(data.player) == 'table' then
                            spectedPlayerAdmin(data.player)
                        end
                        return { status = true }
                    end
                end,
                ['teleportToUserInRobberyNow'] = function(data)
                    CloseNUI()
                    if type(data) == 'table' or type(data.player) == 'table' then 
                        local source = data.player.source 
                        if source  then
                            fServer._teleportToSource(tn(source))
                            return { status = true }
                        end
                    end
                end,
                ['closePainel'] = function(data)
                    CloseNUI()
                    if data.key and inSelectTeam then
                        TriggerServerEvent('tryrobnotify', tn(data.key), 'negado', 'A seleção de time foi cancelada!', 8000)
                        fServer._cancelRobbery(data.key)
                        inSelectTeam = false
                    end
                end,
            }
            
            ----==={ FUNÇÃO DE CALL BACK }===----
            
            local cfg = { API_ROUTE = ts(Resource)..'_API' }
            
            RegisterNUICallback(cfg.API_ROUTE, function(data,cb)
                local callback = ts(data.cb)
                local handler = CallBacks[callback]
                if not handler then return end
                
                local res = handler(data)
                
                if res ~= nil then
                    cb(res)
                end
            end)
        end
        _G["client-side/callback.lua"]()
        
        _G["client-side/thread.lua"] = function()
            ----==={ THREADS (CITIZEN) }===----
            local ts,tn = tostring,tonumber
            inSelectTeam = false
            
            CreateThread(function() -- MARKER
                repeat
                    local sleep = 1000
                    local ped = PlayerPedId()
                    local cds = GetEntityCoords(ped)
                    for k,v in next,(RobberyPoints or {}) do
                        local distance = #( cds - vec3(v.cds.x,v.cds.y,v.cds.z) )
                        if distance < 10 then
                            sleep = 1
                            DrawMarker(21,v.cds.x,v.cds.y,v.cds.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
                            if distance < 1.5 then
                                DrawText3D(v.cds.x,v.cds.y,v.cds.z, 'PRESSIONE ~r~E ~w~PARA ROUBAR')
                                if IsControlJustPressed(0,38) and config.isAlive(ped) and not inPainel then
                                    local err,msg,add = fServer.tryRobbery(v)
                                    if err then
                                        if msg then 
                                            if not add or type(add) ~= 'table' or not add.key then return end
                                            if type(add.proj) == 'table' then
                                                local message = { action = 'BanditsTeam', key = add.key, name = err, nusers = msg, projection = add.proj, bandlimit = add.bandlimit  }
                                                inSelectTeam = true
                                                OpenNUI(message,true)
                                            end
                                        end
                                    else
                                        TriggerEvent('robnotify','negado',ts(msg),8000)
                                    end
                                end
                            end
                        end
                    end
                    Wait(sleep)
                until false
            end)
            
            CreateThread(function() -- ATUALIZAR (myidentifier)
                RegisterKeyMapping('suricato_roubos:openscoreboard','Abrir Scoreboard','KEYBOARD',ts(cfg.OpenScoreboardKey))
                SetTimeout(2000, function() 
                    OpenNUI({action = 'UpdatingHud', robbery = false},false) 
                end)
                repeat
                    myidentifier = fServer.getUserId()
                    Wait(1000)
                until tn(myidentifier) and tn(myidentifier) > 0
            end)
            
            CreateThread(function() 
                Wait(1000)
                local _script = GetCurrentResourceName()
                local function split(inputstr, sep)
                    if sep == nil then
                        sep = "%s"
                    end
                    local t={}
                    for str in inputstr:gmatch("([^"..sep.."]+)") do
                        table.insert(t, str)
                    end
                    return t
                end
                TriggerServerEvent(_script..':auth', split(GetCurrentServerEndpoint(), ':')[2])
            end)
            
            ----==={ COMANDOS }===----
            
            function OpenScoreboard()
                if isInRobbery and not inPainel then
                    if type(ActualRobbery) ~= 'table' then return end
                    OpenNUI({ action = 'OpenScoreboard', robbery = ActualRobbery, team = Team or ts(fServer.GetMyTeam(ActualRobbery)) },true)
                end
            end
            
            RegisterCommand('suricato_roubos:openscoreboard', OpenScoreboard) -- COMANDO PARA ABRIR SCOREBOARD
        end
        _G["client-side/thread.lua"]()
        
            
    end
end)