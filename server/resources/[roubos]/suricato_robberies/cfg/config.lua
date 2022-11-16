cfg = {}

cfg.webhook_screenshot = 'https://discord.com/api/webhooks/1009171312993894601/zGQ0noLPGbH4EgPkwQwJdoz97tWBLRwHmbY2lddXWPTw98bLgnDX1dJVsAHjH2x1kV-Z' -- WEBHHOK ONDE SERÁ ENVIADO A TELA DO JOGADOR CASO ALGUM ADMINISTRADOR TIRE A PRINT ENQUANTO ESTÁ ESPECTANDO
cfg.webhook_startrob = 'https://discord.com/api/webhooks/1009171180382589039/ZoNA1ApMWL34EFuWhKCHThhGm7AMkvfd5R5-8ykKUZ_1upXY-hbR1L_gDKIaKrF3xmJS' -- WEBHOOK PARA NOTIFICAR QUANDO UM ROUBO INICIA (E SUAS INFORMAÇÕES)
cfg.webhook_endrob = 'https://discord.com/api/webhooks/1009171103438078054/VMSV2N7YmAv2NZ2BqUIg0O06VVyq1-Rk1IHIjw59GtK__avtlD5ya-STC0u6ibjwH1BO' -- WENHOOK PARA NOTIFICAR QUANDO UM ROUBO FINALIZA (E SEU RALATÓRIO)
cfg.webhook_killsrob = 'https://discord.com/api/webhooks/1009170984928038942/j-VQFw4Uhux1QLn__DDPVhJn0SzaUcPXZe_scGpYMguCMUlBYG7m4jsOIRszsISXCnu4' -- WEBHOOK PARA NOTIFICAR AS KILLS DENTRO DOS ROUBOS QUE ESTÃO OCORRENDO
cfg.webhook_cl = 'https://discord.com/api/webhooks/1009170888345800825/TUDVPk8Tmh_DtB6-16miHVPAedjYYlKJLmAnh0QuPxd5VoL1N2Vigsx39pYtyIRgifEV' -- WEBHOOK PARA NOTIFICAR UM POSSÍVEL COMBAT-LOGGING, SÓ AVISARÁ SE ELE DESCONECTAR ENQUANTO O ROUBO NÃO ESTIVER ACABADO

cfg.OpenScoreboardKey = 'INSERT' -- TECLA PARA ABRIR O SCOREBOARD (ESCOLHA O INPUT PARAMETER EM: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/)
cfg.DisableCooldown = true -- DESABILITAR O COOLDOWN DE ROUBOS (RECOMENDADO APENAS PARA TESTES)
cfg.BlipCooldown = 100 -- TEMPO EM SEGUNDOS QUE APARECERÁ O BLIP COM A ROTA PARA A POLÍCIA

cfg.ComandoPermissao = 'nc.permissao' -- PERMISSÃO PARA ACESSAR AS INTERFACES ADMIN DO SCRIPT

cfg.PermissaoPolicial = 'policia.permissao' -- PERMISSÃO QUE TODO O POLICIAL APTO À ALGUMA AÇÃO TEM
cfg.HierarquiaPolicial = { -- NOME DO GRUPO, NÃO A PERMISSÃO.
    "Comandante",
    "BopeCoronel",
    "BopeTenenteCoronel",
    "BopeMajor",
    "BopeCapitao",
    "BopeTenente",
    "BopeAspirante",
    "BopeSubTenente",
    "BopeSargento",
    "BopeCabo",
    "BopeSoldado",
    "Coronel",
    "TenenteCoronel",
    "Major",
    "Capitao",
    "Tenente",
    "Aspirante",
    "SubTenente",
    "Sargento",
    "Cabo",
    "Soldado",
    "SpeedCoronel",
    "SpeedTenenteCoronel",
    "SpeedMajor",
    "SpeedCapitao",
    "SpeedTenente",
    "SpeedAspirante",
    "SpeedSubTenente",
    "SpeedSargento",
    "SpeedCabo",
    "SpeedSoldado",
    "TenenteCoronel",
    "GamCoronel",
    "GamMajor",
    "GamCapitao",
    "GamTenente",
    "GamAspirante",
    "GamSubTenente",
    "GamSargento",
    "GamCabo",
    "GamSoldado"
}

cfg.NeedAdminAuthorization = false -- FAZER UMA VERIFICAÇÃO NO SERVER-SIDE PARA SABER SE TEM QUE PASSAR PELA A ETAPA DOS STAFFS
cfg.StaffPermission = 'nc.permissao' -- PERMISSÃO QUE SOMENTE OS STAFFS QUE PODERÃO ACEITAR ROUBOS TEM

cfg.messages = { -- NOTIFICAÇÕES DAS QUAIS É FORNECIDO ALGUNS DADOS PARA A CONFIGURAÇÃO DO SEU JEITO (DEIXAR A STRING VAZIA, CASO NÃO QUEIRA QUE ESSA MENSAGEM APAREÇA)
    -- Para inserir uma variável para a respectiva string, coloque ela entre duas chaves assim: {{var}} - VÁLIDO APENAS PARA AS VARIÁVEIS DA MENSAGEM
    cancelSelection = 'A seleção de time foi cancelada!', -- variáveis: Nenhuma
    withoutAprovation = 'Não foi necessário a aprovação de um staff!', -- variáveis: Nenhuma
    requestAprovation = 'Um novo roubo precisa ser aprovado!', -- variáveis: {{name}} (nome do roubo), {{cops}} (quantidade de policiais), {{bandits}} (quantidade de bandidos)
    withoutStaffs = 'Não há staffs disponíveis para a aprovação!', -- variáveis: Nenhuma
    adminAlreadySpectating = 'Você já está espectando alguém!', -- variáveis: Nenhuma
    adminDeadSpectate = 'Você não pode espectar alguém quando morto!', -- variáveis: Nenhuma
    adminRobbingSpectate = 'Você não pode espectar alguém estando em um roubo!', -- variáveis: Nenhuma
    withoutPlayerToSpectate = 'O jogador para ser espectado não foi encontrado!', -- variáveis: Nenhuma
    screenshoted = 'Você tirou uma print da tela do jogador que está espectando!', -- variáveis: Nenhuma
    copsRobbing = 'Você é policial, e não pode roubar!', -- variáveis: Nenhuma
    progressRobbery = 'Aguarde o roubo em andamento acabar!', -- variáveis: Nenhuma
    notHasPermissionRobbery = 'Você não possui permissão para fazer esse roubo!', -- variáveis: Nenhuma
    notEnoughCops = 'Você não possui permissão para fazer esse roubo!', -- variáveis: {{required}} (número necessário de policiais), {{actual}} (número atual de policiais)
    inCooldown = 'Os cofres do local estão vazios, aguarde {{seconds}} segundos para roubá-los novamente!', -- variáveis: {{seconds}} (segundos faltando para o fim do cooldown)
    notHasItem = 'Você não possui {{amount}}x do item {{itemLabel}} na sua mochila!', -- variáveis: {{amount}} (quantidade do item que é necessário), {{itemLabel}} (nome de exibição do item), {{item}} (nome identificador do item)
    failedToHack = 'Você não conseguiu hackear o sistema!', -- variáveis: Nenhuma
    banditsInitRobbery = 'O roubo iniciou, a qualquer momento os policiais poderão chegar!', -- variáveis: Nenhuma
    copsInitRobbery = 'O roubo iniciou, a localização já está marcada!', -- variáveis: Nenhuma
    hostagesInitRobbery = 'O roubo iniciou, coopere para sobreviver!', -- variáveis: Nenhuma
    moneyAwardRobbery = 'Você roubou R${{award}},00 em dinheiro!', -- variáveis: {{award}} (quantidade de dinheiro roubado)
    combatLoggingWarn = 'Você deslogou na última ação, e voltou finalizado!', -- variáveis: Nenhuma
    droppedPlayerWarn = 'O roubo foi cancelado, pois quem estava selecionando os integrantes foi desconectado!', -- variáveis: Nenhuma
    notHasCommandPermission = 'Você não tem permissão para executar esse comando!', -- variáveis: Nenhuma
    giveUpMessage = 'O time dos {{team}} se renderam!', -- variáveis: {{team}} (nome do time que se rendeu)
    giveUpVoteStarted = 'Uma votação de desistência foi iniciada, abra o menu e vote!', -- variáveis: Nenhuma
    giveUpVoted = 'O passaporte {{id}} votou para se render!', -- variáveis: {{id}} (id da pessoa que votou para se render)
}

cfg.WeaponClassIcons = { -- ICONES DAS CLASSES DE ARMA
    suicide = 'https://cdn.discordapp.com/attachments/546438668831817769/913973356037038120/SUICIDE.png',
    pistol = 'https://cdn.discordapp.com/attachments/864220360416952341/911036858849435719/WEAPON_PISTOL_MK2.png',
    rifle = 'https://cdn.discordapp.com/attachments/864220360416952341/911036754134441984/WEAPON_ASSAULTRIFLE.png',
    smg = 'https://cdn.discordapp.com/attachments/864220360416952341/911037099275329576/WEAPON_MICROSMG.png',
    unarmed = 'https://cdn.discordapp.com/attachments/864220360416952341/911036987430015046/WEAPON_UNARMED.png',
    sniper = 'https://cdn.discordapp.com/attachments/864220360416952341/911036931649970196/WEAPON_HEAVYSNIPER.png',
    melee = 'https://cdn.discordapp.com/attachments/864220360416952341/911036959957352469/WEAPON_KNUCKLE.png',
    shotgun = 'https://cdn.discordapp.com/attachments/864220360416952341/911037866048626738/WEAPON_PUMPSHOTGUN.png',
    rpg = 'https://cdn.discordapp.com/attachments/864220360416952341/911038263303745586/WEAPON_RPG.png',
    grenade = 'https://cdn.discordapp.com/attachments/864220360416952341/911038505197637663/WEAPON_GRENADE.png',
    snowball = 'https://cdn.discordapp.com/attachments/864220360416952341/911038726036140073/WEAPON_SNOWBALL.png',
}

cfg.whitelistWeapons = { -- ARMAS QUE MATARÃO COM APENAS UM TIRO NA CABEÇA (se você possui um código que também faz isso, coloque pelo menos todas as armas que matam com um tiro do seu código como true aqui)
    [GetHashKey('WEAPON_UNARMED')] = false,
    [GetHashKey('WEAPON_RUN_OVER_BY_CAR')] = false,
    [GetHashKey('WEAPON_RAMMED_BY_CAR')] = false,
    [GetHashKey('VEHICLE_WEAPON_ROTORS')] = false,
    [GetHashKey('WEAPON_DAGGER')] = false,
    [GetHashKey('WEAPON_BAT')] = false,
    [GetHashKey('WEAPON_BOTTLE')] = false,
    [GetHashKey('WEAPON_CROWBAR')] = false,
    [GetHashKey('WEAPON_FLASHLIGHT')] = false,
    [GetHashKey('WEAPON_GOLFCLUB')] = false,
    [GetHashKey('WEAPON_HAMMER')] = false,
    [GetHashKey('WEAPON_HATCHET')] = false,
    [GetHashKey('WEAPON_KNUCKLE')] = false,
    [GetHashKey('WEAPON_KNIFE')] = false,
    [GetHashKey('WEAPON_MACHETE')] = false,
    [GetHashKey('WEAPON_SWITCHBLADE')] = false,
    [GetHashKey('WEAPON_NIGHTSTICK')] = false,
    [GetHashKey('WEAPON_WRENCH')] = false,
    [GetHashKey('WEAPON_BATTLEAXE')] = false,
    [GetHashKey('WEAPON_POOLCUE')] = false,
    [GetHashKey('WEAPON_STONE_HATCHET')] = false,
    [GetHashKey('WEAPON_PISTOL')] = true,
    [GetHashKey('WEAPON_PISTOL_MK2')] = true,
    [GetHashKey('WEAPON_COMBATPISTOL')] = true,
    [GetHashKey('WEAPON_APPISTOL')] = true,
    [GetHashKey('WEAPON_STUNGUN')] = true,
    [GetHashKey('WEAPON_PISTOL50')] = true,
    [GetHashKey('WEAPON_SNSPISTOL')] = true,
    [GetHashKey('WEAPON_SNSPISTOL_MK2')] = true,
    [GetHashKey('WEAPON_HEAVYPISTOL')] = true,
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = true,
    [GetHashKey('WEAPON_FLAREGUN')] = true,
    [GetHashKey('WEAPON_MARKSMANPISTOL')] = true,
    [GetHashKey('WEAPON_REVOLVER')] = true,
    [GetHashKey('WEAPON_REVOLVER_MK2')] = true,
    [GetHashKey('WEAPON_DOUBLEACTION')] = true,
    [GetHashKey('WEAPON_RAYPISTOL')] = true,
    [GetHashKey('WEAPON_CERAMICPISTOL')] = true,
    [GetHashKey('WEAPON_NAVYREVOLVER')] = true,
    [GetHashKey('WEAPON_GADGETPISTOL')] = true,
    [GetHashKey('WEAPON_MICROSMG')] = true,
    [GetHashKey('WEAPON_SMG')] = true,
    [GetHashKey('WEAPON_SMG_MK2')] = true,
    [GetHashKey('WEAPON_ASSAULTSMG')] = true,
    [GetHashKey('WEAPON_COMBATPDW')] = true,
    [GetHashKey('WEAPON_MACHINEPISTOL')] = true,
    [GetHashKey('WEAPON_MINISMG')] = true,
    [GetHashKey('WEAPON_RAYCARBINE')] = true,
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = true,
    [GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = true,
    [GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = true,
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = true,
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = true,
    [GetHashKey('WEAPON_MUSKET')] = true,
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = true,
    [GetHashKey('WEAPON_DBSHOTGUN')] = true,
    [GetHashKey('WEAPON_AUTOSHOTGUN')] = true,
    [GetHashKey('WEAPON_COMBATSHOTGUN')] = true,
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = true,
    [GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_CARBINERIFLE')] = true,
    [GetHashKey('WEAPON_CARBINERIFLE_MK2')] = true,
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = true,
    [GetHashKey('WEAPON_SPECIALCARBINE')] = true,
    [GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = true,
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = true,
    [GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_COMPACTRIFLE')] = true,
    [GetHashKey('WEAPON_MILITARYRIFLE')] = true,
    [GetHashKey('WEAPON_MG')] = true,
    [GetHashKey('WEAPON_COMBATMG')] = true,
    [GetHashKey('WEAPON_COMBATMG_MK2')] = true,
    [GetHashKey('WEAPON_GUSENBERG')] = true,
    [GetHashKey('WEAPON_SNIPERRIFLE')] = true,
    [GetHashKey('WEAPON_HEAVYSNIPER')] = true,
    [GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = true,
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = true,
    [GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = true,
    [GetHashKey('WEAPON_RPG')] = false,
    [GetHashKey('WEAPON_GRENADELAUNCHER')] = false,
    [GetHashKey('WEAPON_MINIGUN')] = true,
    [GetHashKey('WEAPON_FIREWORK')] = false,
    [GetHashKey('WEAPON_RAILGUN')] = false,
    [GetHashKey('WEAPON_HOMINGLAUNCHER')] = false,
    [GetHashKey('WEAPON_COMPACTLAUNCHER')] = false,
    [GetHashKey('WEAPON_RAYMINIGUN')] = false,
    [GetHashKey('WEAPON_GRENADE')] = false,
    [GetHashKey('WEAPON_BZGAS')] = false,
    [GetHashKey('WEAPON_MOLOTOV')] = false,
    [GetHashKey('WEAPON_STICKYBOMB')] = false,
    [GetHashKey('WEAPON_PROXMINE')] = false,
    [GetHashKey('WEAPON_SNOWBALL')] = false,
    [GetHashKey('WEAPON_PIPEBOMB')] = false,
    [GetHashKey('WEAPON_BALL')] = false,
    [GetHashKey('WEAPON_SMOKEGRENADE')] = false,
    [GetHashKey('WEAPON_FLARE')] = false,
    [GetHashKey('WEAPON_PETROLCAN')] = false,
    [GetHashKey('WEAPON_PARACHUTE')] = false,
    [GetHashKey('WEAPON_FIREEXTINGUISHER')] = false,
    [GetHashKey('WEAPON_HAZARDCAN')] = false,
}

cfg.spectator = true -- MODO DE ESPECTADOR APÓS A MORTE
cfg.hitmarker = true -- "X" PERSONALIZADO NA MIRA QUANDO MATA