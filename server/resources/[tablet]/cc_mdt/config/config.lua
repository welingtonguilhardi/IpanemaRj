--[ VARIAVEL ]----------------------------------------------------------------------------------------------------------------

Config = {}

--[ LICENÇA ]--------------------------------------------------------------------------------------------------------------------

Config.licenca = '727674669280395286-cc_mdt-txgfi' -- Licença do script; Não lembra? Envie no privado de nosso bot Carioca Auth, o comando: .subinfo !

--[ CONFIGURAÇÃO ]----------------------------------------------------------------------------------------------------------------
--[ LOGO ]--------------------------------------------------------------------------------------------------------------------

Config.logo = 'sua-img'

--[ WEBHOOKS ]--------------------------------------------------------------------------------------------------------------------

Config.webhookCriarBoletim = '' -- Webhook para criação de boletins;

Config.webhookDelBoletim = '' -- Webhook para o deletamento de boletins de ocorrência;

Config.webhookPrender = '' -- Webhook quando um boletim for finalizado e o criminoso preso;

Config.webhookDelCadastro = '' -- Webhook quando um administrador, deletar um cadastro;

--[ COMANDO ]--------------------------------------------------------------------------------------------------------------------

Config.comandoAbrir = 'mdt' -- Comando para abrir o Tablet;

--[ PERMISSOES ]--------------------------------------------------------------------------------------------------------------------

Config.permissaoPolicial = 'nc.permissao' -- Permissão para abrir o MDT;

Config.permissaoAdministrativa = 'nc.permissao' -- Permissão que consiguirá acessar a pagina Gerenciar Oficiais;

--[ PRENDER SOMENTE DENTRO DE ZONA ]-------------------------------------------------------------------------------------------------

Config.enablePrenderEmZona = false -- Somente será possível finalizar um boletim dentro de uma zona;

Config.coordenadaZona = vector3(0,0,0) -- Coodernada da zona;

Config.raioZona = 20 -- Raio da zona;

--[ PATENTE ]--------------------------------------------------------------------------------------------------------------------

Config.gtypePatente = 'job' -- Gtype de promoções;

--[ MAPA ]--------------------------------------------------------------------------------------------------------------------

Config.tipoDeMapa = 'Mainmap'

--[ PERSONALIZAÇÃO ]--------------------------------------------------------------------------------------------------------------------

Config.carroCutScene = 't20' -- Carro em que será spawnado, durante a Cut Scene da prisão;

Config.roupaDetento = { -- Roupa em que o prisioneiro será vestido; Após o fim de sua sentença, ela será retirada;
        [1885233650] = { -- Roupa Masculina;
                [1] = {0,0,2},
                [2] = {2,0,0},
                [3] = {0,0,2},
                [4] = {43,1,2},
                [5] = {-1,0,2},
                [6] = {16,6,2},
                [7] = {0,0,2},
                [8] = {15,0,2},
                [9] = {0,0,2},
                [10] = {0,0,2},
                [11] = {22,0,2},
                [0] = {0,0,0},
                ["p2"] = {-1,0},
                ["p1"] = {-1,0},
                ["p0"] = {-1,0},
                ["p7"] = {-1,0},
                ["p6"] = {-1,0},
            },
        [-1667301416] = { -- Roupa Femininas;
                [1] = {0,0,2},
                [2] = {43,0,0},
                [3] = {14,0,2},
                [4] = {58,2,2},
                [5] = {0,0,0},
                [6] = {5,1,2},
                [7] = {0,0,2},
                [8] = {15,0,2},
                [9] = {0,0,0},
                [10] = {0,0,0},
                [11] = {49,0,2},
                [0] = {0,0,0},
                ["p6"] = {-1,0},
                ["p7"] = {-1,0},
                ["p2"] = {-1,0},
                ["p0"] = {-1,0},
                ["p1"] = {-1,0},
        }
}

--[ AVANÇADO ]--------------------------------------------------------------------------------------------------------------------
--[ UPLOAD IMAGENS ]---------------------------------------------------------------------------------------------------------------------

Config.qualidadeDoUpload = 0.1 -- Qualidade de upload. Quanto mais baixo, mais rapido será, mas sua qualidade irá diminuir;

--[ PRENDER ]---------------------------------------------------------------------------------------------------------------------

Config.penaMaxima = 500 -- Pena maxima permitida;

--[ URL IMAGEM CARROS ]------------------------------------------------------------------------------------------------------------------

Config.urlImagemCarros = 'http://200.9.155.205/images/' -- URL em que seus carros ficam hospedados;

--[ CODIGO PENAL ]--------------------------------------------------------------------------------------------------------------

Config.codigoPenal = {
        {
                ["descricao"] = "Homicidio Doloso Qualificado", -- Descrição do crime;
                ["pena"] = 80, -- Pena do crime;
                ["multa"] = 40000, -- Multa do crime;
                ["fianca"] = false -- Fiança do crime; Caso for inafiançável, deve se colocar: false ;
        },
        {
                ["descricao"] = "Homicidio Doloso",
                ["pena"] = 60,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Tentativa de Homicidio",
                ["pena"] = 30,
                ["multa"] = 15000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Homicidio Culposo",
                ["pena"] = 30,
                ["multa"] = 15000,
                ["fianca"] = 300000
        },
        {
                ["descricao"] = "Homicidio Culposo no Transito",
                ["pena"] = 35,
                ["multa"] = 10000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Lesão corporal",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 70000
        },
        {
                ["descricao"] = "Sequestro",
                ["pena"] = 40,
                ["multa"] = 20000,
                ["fianca"] = 300000
        },
        {
                ["descricao"] = "Desmanche de Carros",
                ["pena"] = 50,
                ["multa"] = 25000,
                ["fianca"] = 450000
        },
        {
                ["descricao"] = "Furto/Roubo",
                ["pena"] = 20,
                ["multa"] = 10000,
                ["fianca"] = 75000
        },
        {
                ["descricao"] = "Tentativa de Furto/Roubo",
                ["pena"] = 10,
                ["multa"] = 5000,
                ["fianca"] = 50000
        },
        {
                ["descricao"] = "Obstrução Facial",
                ["pena"] = 0,
                ["multa"] = 5000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Colete balístico",
                ["pena"] = 10,
                ["multa"] = 10000,
                ["fianca"] = 50000
        },
        {
                ["descricao"] = "Uso de coldre",
                ["pena"] = 5,
                ["multa"] = 8000,
                ["fianca"] = 20000
        },
        {
                ["descricao"] = "Fardamento policial",
                ["pena"] = 10,
                ["multa"] = 10000,
                ["fianca"] = 30000
        },
        {
                ["descricao"] = "Resistencia a prisão",
                ["pena"] = 5,
                ["multa"] = 5000,
                ["fianca"] = 20000
        },
        {
                ["descricao"] = "Fuga da abordagem policial",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 50000
        },
        {
                ["descricao"] = "Corrida ilegal",
                ["pena"] = 20,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Multas pendentes",
                ["pena"] = 0,
                ["multa"] = 3000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Omissão de socorro",
                ["pena"] = 0,
                ["multa"] = 5000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Dano ao patrimonio",
                ["pena"] = 0,
                ["multa"] = 10000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Porte de munições ilegal",
                ["pena"] = 20,
                ["multa"] = 15000,
                ["fianca"] = 100000
        },
        {
                ["descricao"] = "Difamação",
                ["pena"] = 0,
                ["multa"] = 5000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Obstrução de justiça",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 50000
        },
        {
                ["descricao"] = "Desacato a autoridade",
                ["pena"] = 15,
                ["multa"] = 15000,
                ["fianca"] = 75000
        },
        {
                ["descricao"] = "Desobediência",
                ["pena"] = 10,
                ["multa"] = 10000,
                ["fianca"] = 100000
        },
        {
                ["descricao"] = "Extorção",
                ["pena"] = 15,
                ["multa"] = 15000,
                ["fianca"] = 75000
        },
        {
                ["descricao"] = "Falsidade ideológica",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Perjúrio",
                ["pena"] = 25,
                ["multa"] = 20000,
                ["fianca"] = 80000
        },
        {
                ["descricao"] = "Suborno",
                ["pena"] = 50,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Corrupção",
                ["pena"] = 100,
                ["multa"] = 150000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Ameaça",
                ["pena"] = 10,
                ["multa"] = 5000,
                ["fianca"] = 50000
        },
        {
                ["descricao"] = "Calúnia",
                ["pena"] = 10,
                ["multa"] = 5000,
                ["fianca"] = 50000
        },
        {
                ["descricao"] = "Apologia ao crime",
                ["pena"] = 30,
                ["multa"] = 30000,
                ["fianca"] = 200000
        },
        {
                ["descricao"] = "Furto/Roubo a viatura",
                ["pena"] = 50,
                ["multa"] = 50000,
                ["fianca"] = 400000
        },
        {
                ["descricao"] = "Genocídio",
                ["pena"] = 120,
                ["multa"] = 70000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Homicídio à oficial",
                ["pena"] = 80,
                ["multa"] = 40000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Algema",
                ["pena"] = 0,
                ["multa"] = 5000,
                ["fianca"] = 30000
        },
        {
                ["descricao"] = "Capuz",
                ["pena"] = 5,
                ["multa"] = 10000,
                ["fianca"] = 40000
        },
        {
                ["descricao"] = "Lockpick",
                ["pena"] = 15,
                ["multa"] = 15000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "C4",
                ["pena"] = 30,
                ["multa"] = 20000,
                ["fianca"] = 90000
        },
        {
                ["descricao"] = "Masterpick",
                ["pena"] = 20,
                ["multa"] = 20000,
                ["fianca"] = 90000
        },
        {
                ["descricao"] = "Placa veícular",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Capsula",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Polvora",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Pendrive",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Divergente/Cannabis/Afentamina",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Fibra de aramida",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 60000
        },
        {
                ["descricao"] = "Posse de Dinheiro sujo",
                ["pena"] = 10,
                ["multa"] = 10000,
                ["fianca"] = 100000
        },
        {
                ["descricao"] = "Posse de peças de armas",
                ["pena"] = 15,
                ["multa"] = 10000,
                ["fianca"] = 150000
        },
        {
                ["descricao"] = "Tráfico de Armas",
                ["pena"] = 60,
                ["multa"] = 50000,
                ["fianca"] = 250000
        },
        {
                ["descricao"] = "Porte de Arma Ilegal",
                ["pena"] = 30,
                ["multa"] = 25000,
                ["fianca"] = 125000
        },
        {
                ["descricao"] = "Trafico de Munição",
                ["pena"] = 40,
                ["multa"] = 50000,
                ["fianca"] = 200000
        },
        {
                ["descricao"] = "Posse de Componentes Narcoticos",
                ["pena"] = 30,
                ["multa"] = 20000,
                ["fianca"] = 75000
        },
        {
                ["descricao"] = "Tráfico de Drogas",
                ["pena"] = 50,
                ["multa"] = 30000,
                ["fianca"] = 200000
        },
        {
                ["descricao"] = "Direção Perigosa",
                ["pena"] = 0,
                ["multa"] = 7000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Estacionar em local proibido",
                ["pena"] = 0,
                ["multa"] = 5000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Veículo abandonado",
                ["pena"] = 0,
                ["multa"] = 10000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Andar com veículo danificado",
                ["pena"] = 0,
                ["multa"] = 3000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Alta velocidade",
                ["pena"] = 0,
                ["multa"] = 3000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Ultrapassar sinal vermelho",
                ["pena"] = 0,
                ["multa"] = 1000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Pousar em local proibido",
                ["pena"] = 0,
                ["multa"] = 50000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Banco Central",
                ["pena"] = 100,
                ["multa"] = 50000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Banco Paleto Bay",
                ["pena"] = 80,
                ["multa"] = 40000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Joalheria",
                ["pena"] = 60,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Açougue",
                ["pena"] = 60,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Galinheiro",
                ["pena"] = 60,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Yellow Jack",
                ["pena"] = 40,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Estadio",
                ["pena"] = 40,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Bancos Nubank",
                ["pena"] = 40,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Navio",
                ["pena"] = 40,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Laboratorio Humane",
                ["pena"] = 40,
                ["multa"] = 30000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Loja de Departamento",
                ["pena"] = 30,
                ["multa"] = 25000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Loja de Armas",
                ["pena"] = 25,
                ["multa"] = 15000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Barbearia",
                ["pena"] = 0,
                ["multa"] = 10000,
                ["fianca"] = false
        },
        {
                ["descricao"] = "Caixa Eletrônico",
                ["pena"] = 10,
                ["multa"] = 5000,
                ["fianca"] = 100000
        },
        {
                ["descricao"] = "Caixa Registradora",
                ["pena"] = 10,
                ["multa"] = 5000,
                ["fianca"] = 100000
        },
}

--[ ATENUANTES ]--------------------------------------------------------------------------------------------------------------
    
Config.atenuantesPenal = {
        {
                ["descricao"] = "Réu Primário", -- Descrição do atenuante;
                ["porcentagem"] = 40 -- Porcentagem que será reduzida do crime;
        },
        {
                ["descricao"] = "Presença de um Advogado;",
                ["porcentagem"] = 10
        },
        {
                ["descricao"] = "Colaboração com a investigação;",
                ["porcentagem"] = 30
        }
}

--[ AGRAVANTES ]--------------------------------------------------------------------------------------------------------------
    
Config.agravantesPenal = {
        {
                ["descricao"] = "Resistência a prisão;", -- Descrição do agravante;
                ["porcentagem"] = 30 -- Porcentagem que será aumentada do crime;
        },
        {
                ["descricao"] = "Criminoso reincidente;",
                ["porcentagem"] = 20
        }
}