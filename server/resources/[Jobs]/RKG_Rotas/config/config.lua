Config = {
    BindCancelRoute = "F7", -- Tecla para cancelar a rota.
    RandomRoutes = true, -- true para deixar as rotas aleatórias.
    
    ["Orgs"] = {
        -------------------ORGS LEGAIS-------------------------------------------------------------
        ["Mec"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3( 1220.46, -2968.5, 5.87 ), -- Cordenadas do ped. (Iniciar a rota.)
            heading = 92.79, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA DE MECANICO", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "mecanico.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            { name = "rubber", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "fabric", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
        }
    },
    -------------------ORGS ILEGAIS-------------------------------------------------------------
        ["Mafia"] = { -- Nome da fac (Ilustrativo)
            Ped = {
                coords = vector3( 408.5, 5.46, 84.93 ), -- Cordenadas do ped. (Iniciar a rota.)
                heading = 241.71, -- Heading do ped.
                Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
                Text = "~r~[E]~w~ PARA INICIAR A ROTA DE ARMAS", -- Texto que aparecerá na cabeça do ped.
            },
            Perms = { "cosanostra.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
            RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
            Itens = {
                { name = "copper", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
                { name = "aluminum", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
            },
            BlipRoutes = { -- Coordenadas da rota.
                vector3( 206.15,-85.93,69.41 ),
                vector3( 124.01,64.86,79.75 ),
                vector3( 105.93,493.03,147.15 ),
                vector3( -355.69,516.42,120.19 ),
                vector3( -768.78,469.86,100.17 ),
                vector3( -1045.72,503.44,84.17 ),
                vector3( -1357.05,551.06,130.72 ),
                vector3( -914.18,693.68,151.44 ),
                vector3( -575.2,741.26,184.06 ),
                vector3( -396.56,877.59,230.78 ),
                vector3( -172.67,966.3,237.54 ),
                vector3( 347.53,930.02,203.44 ),
                vector3( 148.79,1667.29,228.85 ),
                vector3( -43.75,1960.0,190.28 ),
                vector3( 721.13,2335.37,50.25 ),
                vector3( 241.71,3107.92,42.49 ),
                vector3( 464.37,3565.33,33.24 ),
                vector3( 961.28,3625.82,32.46 ),
                vector3( 1433.75,3628.48,35.85 ),
                vector3( 1703.26,3791.46,34.81 ),
                vector3( 2004.1,3790.62,32.19 ),
                vector3( 2521.56,4124.29,38.64 ),
                vector3( 1792.88,4594.97,37.69 ),
                vector3( 1961.57,5184.87,47.99 ),
                vector3( 2553.99,4668.08,34.02 ),
                vector3( 2932.2,4624.17,48.71 ),
                vector3( 2916.17,4367.91,50.47 ),
                vector3( 2987.89,3481.61,72.49 ),
                vector3( 2632.29,2935.29,40.43 ),
                vector3( 2527.82,2617.12,37.96 ),
                vector3( 2473.79,1572.17,32.73 ),
                vector3( 1531.67,816.58,77.43 ),
                vector3( 771.51,230.37,86.04 ),
                vector3( 397.9,175.87,103.86 ),
            }
        },
        ["Ballas"] = { -- Nome da fac (Ilustrativo)
            Ped = {
                coords = vector3( 83.62, -1961.17, 20.75 ), -- Cordenadas do ped. (Iniciar a rota.)
                heading = 230.11, -- Heading do ped.
                Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
                Text = "~r~[E]~w~ PARA INICIAR A ROTA DE MUNIÇÃO", -- Texto que aparecerá na cabeça do ped.
            },
            Perms = { "ballas.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
            RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
            Itens = {
                { name = "capsula", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
                { name = "polvora", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
            },
            BlipRoutes = { -- Coordenadas da rota.
                vector3( 206.15,-85.93,69.41 ),
                vector3( 124.01,64.86,79.75 ),
                vector3( 105.93,493.03,147.15 ),
                vector3( -355.69,516.42,120.19 ),
                vector3( -768.78,469.86,100.17 ),
                vector3( -1045.72,503.44,84.17 ),
                vector3( -1357.05,551.06,130.72 ),
                vector3( -914.18,693.68,151.44 ),
                vector3( -575.2,741.26,184.06 ),
                vector3( -396.56,877.59,230.78 ),
                vector3( -172.67,966.3,237.54 ),
                vector3( 347.53,930.02,203.44 ),
                vector3( 148.79,1667.29,228.85 ),
                vector3( -43.75,1960.0,190.28 ),
                vector3( 721.13,2335.37,50.25 ),
                vector3( 241.71,3107.92,42.49 ),
                vector3( 464.37,3565.33,33.24 ),
                vector3( 961.28,3625.82,32.46 ),
                vector3( 1433.75,3628.48,35.85 ),
                vector3( 1703.26,3791.46,34.81 ),
                vector3( 2004.1,3790.62,32.19 ),
                vector3( 2521.56,4124.29,38.64 ),
                vector3( 1792.88,4594.97,37.69 ),
                vector3( 1961.57,5184.87,47.99 ),
                vector3( 2553.99,4668.08,34.02 ),
                vector3( 2932.2,4624.17,48.71 ),
                vector3( 2916.17,4367.91,50.47 ),
                vector3( 2987.89,3481.61,72.49 ),
                vector3( 2632.29,2935.29,40.43 ),
                vector3( 2527.82,2617.12,37.96 ),
                vector3( 2473.79,1572.17,32.73 ),
                vector3( 1531.67,816.58,77.43 ),
                vector3( 771.51,230.37,86.04 ),
                vector3( 397.9,175.87,103.86 ),
            }
        },

        ["Motoclub"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3( 1953.12, 3837.78, 35.78 ), -- Cordenadas do ped. (Iniciar a rota.)
            heading = 122.25, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA DE COLETE", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "motoclub.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            { name = "aluminum", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "rubber", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
        }
    },
    ----------------------BOATES-------------------------------------------------------------------
        ["bahamas"] = { -- Nome da fac (Ilustrativo)
            Ped = {
                coords = vector3( -1398.05, -629.51, 30.32), -- Cordenadas do ped. (Iniciar a rota.)
                heading = 303.02, -- Heading do ped.
                Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
                Text = "~r~[E]~w~ PARA INICIAR A ROTA", -- Texto que aparecerá na cabeça do ped.
            },
            Perms = { "bahamas.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
            RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
            Itens = {
                { name = "copper", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
                { name = "plastic", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
                { name = "fabric", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
                { name = "aluminum", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
            },
            BlipRoutes = { -- Coordenadas da rota.
                vector3( 206.15,-85.93,69.41 ),
                vector3( 124.01,64.86,79.75 ),
                vector3( 105.93,493.03,147.15 ),
                vector3( -355.69,516.42,120.19 ),
                vector3( -768.78,469.86,100.17 ),
                vector3( -1045.72,503.44,84.17 ),
                vector3( -1357.05,551.06,130.72 ),
                vector3( -914.18,693.68,151.44 ),
                vector3( -575.2,741.26,184.06 ),
                vector3( -396.56,877.59,230.78 ),
                vector3( -172.67,966.3,237.54 ),
                vector3( 347.53,930.02,203.44 ),
                vector3( 148.79,1667.29,228.85 ),
                vector3( -43.75,1960.0,190.28 ),
                vector3( 721.13,2335.37,50.25 ),
                vector3( 241.71,3107.92,42.49 ),
                vector3( 464.37,3565.33,33.24 ),
                vector3( 961.28,3625.82,32.46 ),
                vector3( 1433.75,3628.48,35.85 ),
                vector3( 1703.26,3791.46,34.81 ),
                vector3( 2004.1,3790.62,32.19 ),
                vector3( 2521.56,4124.29,38.64 ),
                vector3( 1792.88,4594.97,37.69 ),
                vector3( 1961.57,5184.87,47.99 ),
                vector3( 2553.99,4668.08,34.02 ),
                vector3( 2932.2,4624.17,48.71 ),
                vector3( 2916.17,4367.91,50.47 ),
                vector3( 2987.89,3481.61,72.49 ),
                vector3( 2632.29,2935.29,40.43 ),
                vector3( 2527.82,2617.12,37.96 ),
                vector3( 2473.79,1572.17,32.73 ),
                vector3( 1531.67,816.58,77.43 ),
                vector3( 771.51,230.37,86.04 ),
                vector3( 397.9,175.87,103.86 ),
            }
        },
        ["galaxy"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3( 390.13, 272.92, 95.0), -- Cordenadas do ped. (Iniciar a rota.)
            heading = 358.08, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "dono.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            { name = "copper", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "plastic", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "fabric", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "aluminum", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
        }
    },
    ["vilaMix"] = { -- Nome da fac (Ilustrativo)
    Ped = {
        coords = vector3( -570.4, 291.7, 79.19), -- Cordenadas do ped. (Iniciar a rota.)
        heading = 91.35, -- Heading do ped.
        Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
        Text = "~r~[E]~w~ PARA INICIAR A ROTA", -- Texto que aparecerá na cabeça do ped.
    },
    Perms = { "dono.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
    RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
    Itens = {
        { name = "copper", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
        { name = "plastic", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
        { name = "fabric", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
        { name = "aluminum", min = 7, max = 9 }, -- name = "nome do item", min = "minimo", max "maximo"
    },
    BlipRoutes = { -- Coordenadas da rota.
        vector3( 206.15,-85.93,69.41 ),
        vector3( 124.01,64.86,79.75 ),
        vector3( 105.93,493.03,147.15 ),
        vector3( -355.69,516.42,120.19 ),
        vector3( -768.78,469.86,100.17 ),
        vector3( -1045.72,503.44,84.17 ),
        vector3( -1357.05,551.06,130.72 ),
        vector3( -914.18,693.68,151.44 ),
        vector3( -575.2,741.26,184.06 ),
        vector3( -396.56,877.59,230.78 ),
        vector3( -172.67,966.3,237.54 ),
        vector3( 347.53,930.02,203.44 ),
        vector3( 148.79,1667.29,228.85 ),
        vector3( -43.75,1960.0,190.28 ),
        vector3( 721.13,2335.37,50.25 ),
        vector3( 241.71,3107.92,42.49 ),
        vector3( 464.37,3565.33,33.24 ),
        vector3( 961.28,3625.82,32.46 ),
        vector3( 1433.75,3628.48,35.85 ),
        vector3( 1703.26,3791.46,34.81 ),
        vector3( 2004.1,3790.62,32.19 ),
        vector3( 2521.56,4124.29,38.64 ),
        vector3( 1792.88,4594.97,37.69 ),
        vector3( 1961.57,5184.87,47.99 ),
        vector3( 2553.99,4668.08,34.02 ),
        vector3( 2932.2,4624.17,48.71 ),
        vector3( 2916.17,4367.91,50.47 ),
        vector3( 2987.89,3481.61,72.49 ),
        vector3( 2632.29,2935.29,40.43 ),
        vector3( 2527.82,2617.12,37.96 ),
        vector3( 2473.79,1572.17,32.73 ),
        vector3( 1531.67,816.58,77.43 ),
        vector3( 771.51,230.37,86.04 ),
        vector3( 397.9,175.87,103.86 ),
    }
},

        ---------------------FACS--------------------------------------------------------------------------
        ["meta"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3( 1372.6, 27.04, 124.03), -- Cordenadas do ped. (Iniciar a rota.) 1220.45,-2976.8,5.87,102.05
            heading = 175.68, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA DE META", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "dono.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            {name = "anfetamina", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "methliquid", min = 7, max = 9}, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
            }
        },
        ["md"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3( -1797.46, -126.28, 80.78), -- Cordenadas do ped. (Iniciar a rota.) 1220.45,-2976.8,5.87,102.05
            heading = 108.31, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA DE ECSTASY", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "dono.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            {name = "anfetamina", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "cafeina", min = 7, max = 9}, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
            }
        },
        ["maconha"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3(1220.48, -2984.55, 5.87), -- Cordenadas do ped. (Iniciar a rota.) 1220.45,-2976.8,5.87,102.05
            heading = 102.05, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA DE EMBALAGEM PARA MACONHA", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "dono.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            { name = "papelfilme", min = 7, max = 9}, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
            }
        },
        ["lean"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3( 1220.47, -2988.68, 5.87), -- Cordenadas do ped. (Iniciar a rota.) 1220.45,-2976.8,5.87,102.05
            heading = 102.05, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA DE LEAN", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "dono.permissao","Campinho" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            {name = "prometazina", min = 5, max = 7 }, -- name = "nome do item", min = "minimo", max "maximo"
            { name = "xaropedecodeina", min = 7, max = 9}, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
            }
        },
        ["coca"] = { -- Nome da fac (Ilustrativo)
        Ped = {
            coords = vector3( 708.16, -231.66, 69.48), -- Cordenadas do ped. (Iniciar a rota.) 1220.45,-2976.8,5.87,102.05
            heading = 330.57, -- Heading do ped.
            Hash = { 0x4F2E038A,"a_m_m_salton_01" }, -- Hash do ped (https://wiki.rage.mp/index.php?title=Peds)
            Text = "~r~[E]~w~ PARA INICIAR A ROTA DE COCA", -- Texto que aparecerá na cabeça do ped.
        },
        Perms = { "yakuza.permissao","Campinho favela" }, -- Permissões para inicar a rota. (Deixe em tabelas para colocar mais permissões.)
        RandomItens = false, -- true para pegar apenas UM item aleatório, false para pegar TODOS.
        Itens = {
            { name = "folhadecoca", min = 7, max = 9}, -- name = "nome do item", min = "minimo", max "maximo"
        },
        BlipRoutes = { -- Coordenadas da rota.
            vector3( 206.15,-85.93,69.41 ),
            vector3( 124.01,64.86,79.75 ),
            vector3( 105.93,493.03,147.15 ),
            vector3( -355.69,516.42,120.19 ),
            vector3( -768.78,469.86,100.17 ),
            vector3( -1045.72,503.44,84.17 ),
            vector3( -1357.05,551.06,130.72 ),
            vector3( -914.18,693.68,151.44 ),
            vector3( -575.2,741.26,184.06 ),
            vector3( -396.56,877.59,230.78 ),
            vector3( -172.67,966.3,237.54 ),
            vector3( 347.53,930.02,203.44 ),
            vector3( 148.79,1667.29,228.85 ),
            vector3( -43.75,1960.0,190.28 ),
            vector3( 721.13,2335.37,50.25 ),
            vector3( 241.71,3107.92,42.49 ),
            vector3( 464.37,3565.33,33.24 ),
            vector3( 961.28,3625.82,32.46 ),
            vector3( 1433.75,3628.48,35.85 ),
            vector3( 1703.26,3791.46,34.81 ),
            vector3( 2004.1,3790.62,32.19 ),
            vector3( 2521.56,4124.29,38.64 ),
            vector3( 1792.88,4594.97,37.69 ),
            vector3( 1961.57,5184.87,47.99 ),
            vector3( 2553.99,4668.08,34.02 ),
            vector3( 2932.2,4624.17,48.71 ),
            vector3( 2916.17,4367.91,50.47 ),
            vector3( 2987.89,3481.61,72.49 ),
            vector3( 2632.29,2935.29,40.43 ),
            vector3( 2527.82,2617.12,37.96 ),
            vector3( 2473.79,1572.17,32.73 ),
            vector3( 1531.67,816.58,77.43 ),
            vector3( 771.51,230.37,86.04 ),
            vector3( 397.9,175.87,103.86 ),
            }
        },
       
    },
    ["Notify"] = {
        StartRoute = "Você Iniciou sua Rota.", -- Iniciou a Rota.
        StopService = "Você saiu de serviço.", -- Saiu de serviço.
        BackpackFull = "A sua Mochila está cheia." -- Mochila Cheia.
    },
}