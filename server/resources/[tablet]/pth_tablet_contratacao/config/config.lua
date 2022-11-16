Config = {}

Config.isCreative = true -- É BASE CREATIVE

-- [[ NOTIFICAÇÕES]] --------------------------------------
Config.Notify_Event = "Notify"
Config.Notify_Sucesso = "sucesso"
Config.Notify_Aviso = "aviso"
Config.Notify_Importante = "importante"
Config.Notify_Negado = "negado"

-- [[ CONFIG ]] --------------------------------------

Config.tabletComando = "grupo" -- COMANDO PARA ABRIR O TABLET

Config.tabletUsarBlockList = true -- CASO QUERIA TER AS BLOCK LIST ATIVA NO SCIPT
Config.tabletDiasBlockList = 3 -- DIAS QUE A PESSOA ESTÁ NA BLOCKLIST DE SETAGEM
Config.tabletBlockListDB = "vRP:pth_tablet_contratacao_group_blocklist" -- NOME DA LINHA QUE FICA NO BANCO DE DADOS ( tabela: vrp_user_data )

Config.tabletPermissoes = {
["contratosmecanico.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
        nome = "Mecanicos", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
        grupos = {
            [1] = { 
                title = "Mecanica", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
                cargos = {
                    [1] = {
                        group = "MecanicoL", -- GRUPO DE SETAGEM
                        title = "Mecanico - Lider", -- LEGENDA DO GRUPO
                        blocklist = false -- SE APLICA BLOCKLIST OU NÃO
                    },
                    [2] = {group = "MecanicoGG", title = "Mecanico - Gerente Geral", blocklist = false},
                    [3] = {group = "MecanicoG", title = "Mecanico - Gerente", blocklist = false},
                    [4] = {group = "MecanicoC", title = "Mecanico - Contratado", blocklist = false},
                    [5] = {group = "MecanicoA", title = "Mecanico Aprendiz", blocklist = false},
                },
            }
        }
    },

["dkGerente.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "DkChefe", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Drift king", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {
                    group = "Drift king", -- GRUPO DE SETAGEM
                    title = "Drift king", -- LEGENDA DO GRUPO
                    blocklist = false -- SE APLICA BLOCKLIST OU NÃO
                },  -- 
                [2] = {group = "DkGerente", title = "Dk Gerente", blocklist = false},
                [3] = {group = "Dk", title = "Membro Dk", blocklist = false},
            },
        }
    }
},

["contratosyakuza.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Yakuza", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Yakuza", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = { -- 
                [1] = {group = "YakuzaLider", title = "YakuzaLider", blocklist = false},
                [2] = {group = "YakuzaD", title = "Yakuza Diretor", blocklist = false},
                [3] = {group = "YakuzaGG", title = "Yakuza Gerente Geral", blocklist = false},
                [4] = {group = "YakuzaG", title = "Yakuza Gerente", blocklist = false},
                [5] = {group = "YakuzaC", title = "Yakuza Contratado", blocklist = false},
                [6] = {group = "YakuzaR", title = "Yakuza Recruta", blocklist = false},
            },
        }
    }
},
["contratoscosanostra.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "BratvaChefe", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Bratva", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "CosanostraLider", title = "Cosanostra Lider", blocklist = false},
                [2] = {group = "CosanostraD", title = "Cosanostra Diretor", blocklist = false},
                [3] = {group = "CosanostraGG", title = "Cosanostra Gerente Geral", blocklist = false},
                [4] = {group = "CosanostraG", title = "Cosanostra Gerente", blocklist = false},
                [5] = {group = "CosanostraC", title = "Cosanostra Contratado", blocklist = false},
                [6] = {group = "CosanostraR", title = "Cosanostra Recruta", blocklist = false},
            },
        }
    }
},

["contratosgrove.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Grove", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Grove", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "GroveLider", title = "Grove Lider", blocklist = false},
                [2] = {group = "GroveD", title = "Grove Diretor", blocklist = false},
                [3] = {group = "GroveGG", title = "Grove Gerente Geral", blocklist = false},
                [4] = {group = "GroveG", title = "Grove Gerente", blocklist = false},
                [5] = {group = "GroveC", title = "Grove Contratado", blocklist = false},
                [6] = {group = "GroveR", title = "Grove Recruta", blocklist = false},
            },
        }
    }
},

["contratosvagos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Vagos", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Vagos", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "VagosLider", title = "Vagos Lider", blocklist = false},
                [2] = {group = "VagosD", title = "Vagos Diretor", blocklist = false},
                [3] = {group = "VagosGG", title = "Vagos Gerente Geral", blocklist = false},
                [4] = {group = "VagosG", title = "Vagos Gerente", blocklist = false},
                [5] = {group = "VagosC", title = "Vagos Contratado", blocklist = false},
                [6] = {group = "VagosR", title = "Vagos Recruta", blocklist = false},
            },
        }
    }
},

["contratosballas.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Ballas", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Ballas", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "BallasLider", title = "Ballas Lider", blocklist = false},
                [2] = {group = "BallasD", title = "Ballas Diretor", blocklist = false},
                [3] = {group = "BallasGG", title = "Membro Gerente Geral", blocklist = false},
                [4] = {group = "BallasG", title = "Ballas Gerente", blocklist = false},
                [5] = {group = "BallasC", title = "Ballas Contratado", blocklist = false},
                [6] = {group = "BallasR", title = "Ballas Recruta", blocklist = false},
            },
        }
    }
},

["bratvacontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Bratva", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Bratva", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "BratvaLider", title = "Bratva Lider", blocklist = false},
                [2] = {group = "BratvaD", title = "Bratva Diretor", blocklist = false},
                [3] = {group = "BratvaGG", title = "Bratva Gerente Geral", blocklist = false},
                [4] = {group = "BratvaG", title = "Bratva Gerente", blocklist = false},
                [5] = {group = "BratvaC", title = "Bratva Contratado", blocklist = false},
                [6] = {group = "BratvaR", title = "Bratva Recruta", blocklist = false},
            },
        }
    }
},
["serpentscontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Serpents", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Serpents", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "SerpentsLider", title = "Serpents Lider", blocklist = false},
                [2] = {group = "SerpentsD", title = "Serpents Diretor", blocklist = false},
                [3] = {group = "SerpentsGG", title = "Serpents Gerente Geral", blocklist = false},
                [4] = {group = "SerpentsG", title = "Serpents Gerente", blocklist = false},
                [5] = {group = "SerpentsC", title = "Serpents Contratado", blocklist = false},
                [6] = {group = "SerpentsR", title = "Serpents Recruta", blocklist = false},
            },
        }
    }
},
["maiascontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Maias", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Maias", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "MaiasLider", title = "Maias Lider", blocklist = false},
                [2] = {group = "MaiasD", title = "Maias Diretor", blocklist = false},
                [3] = {group = "MaiasGG", title = "Maias Gerente Geral", blocklist = false},
                [4] = {group = "MaiasG", title = "Maias Gerente", blocklist = false},
                [5] = {group = "MaiasC", title = "Maias Contratado", blocklist = false},
                [6] = {group = "MaiasR", title = "Maias Recruta", blocklist = false},
            },
        }
    }
},
["camorracontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Camorra", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Camorra", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "CamorraLider", title = "Camorra Lider", blocklist = false},
                [2] = {group = "CamorraD", title = "Camorra Diretor", blocklist = false},
                [3] = {group = "CamorraGG", title = "Camorra Gerente Geral", blocklist = false},
                [4] = {group = "CamorraG", title = "Camorra Gerente", blocklist = false},
                [5] = {group = "CamorraC", title = "Camorra Contratado", blocklist = false},
                [6] = {group = "CamorraR", title = "Camorra Recruta", blocklist = false},
            },
        }
    }
},

["bahamascontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Bahamas", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Bahamas", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "BahamasLider", title = "Bahamas Lider", blocklist = false},
                [2] = {group = "BahamasD", title = "Bahamas Diretor", blocklist = false},
                [3] = {group = "BahamasGG", title = "Bahamas Gerente Geral", blocklist = false},
                [4] = {group = "BahamasG", title = "Bahamas Gerente", blocklist = false},
                [5] = {group = "BahamasC", title = "Bahamas Contratado", blocklist = false},
                [6] = {group = "BahamasR", title = "Bahamas Recruta", blocklist = false},
            },
        }
    }
},
["pcccontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Pcc", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Pcc", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "PccLider", title = "Pcc Lider", blocklist = false},
                [2] = {group = "PccD", title = "Pcc Diretor", blocklist = false},
                [3] = {group = "PccGG", title = "Pcc Gerente Geral", blocklist = false},
                [4] = {group = "PccG", title = "Pcc Gerente", blocklist = false},
                [5] = {group = "PccC", title = "Pcc Contratado", blocklist = false},
                [6] = {group = "PccA", title = "Pcc Aviãozinho", blocklist = false},
            },
        }
    }
},
["cvcontratos.permissao.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Cv", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Cv", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "CvLider", title = "Cv Lider", blocklist = false},
                [2] = {group = "CvD", title = "Cv Diretor", blocklist = false},
                [3] = {group = "CvGG", title = "Cv Gerente Geral", blocklist = false},
                [4] = {group = "CvG", title = "Cv Gerente", blocklist = false},
                [5] = {group = "CvC", title = "Cv Contratado", blocklist = false},
                [6] = {group = "CvA", title = "Cv Aviãozinho", blocklist = false},
            },
        }
    }
},
["tequilacontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Tequila", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Tequila", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "TequilaLider", title = "Tequila Lider", blocklist = false},
                [2] = {group = "TequilaD", title = "Tequila Diretor", blocklist = false},
                [3] = {group = "TequilaGG", title = "Tequila Gerente Geral", blocklist = false},
                [4] = {group = "TequilaG", title = "Tequila Gerente", blocklist = false},
                [5] = {group = "TequilaC", title = "Tequila Contratado", blocklist = false},
                [6] = {group = "TequilaR", title = "Tequila Recruta", blocklist = false},
            },
        }
    }
},
["aztecascontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Aztecas", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Aztecas", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "AztecasLider", title = "Aztecas Lider", blocklist = false},
                [2] = {group = "AztecasD", title = "Aztecas Diretor", blocklist = false},
                [3] = {group = "AztecasGG", title = "Aztecas Gerente Geral", blocklist = false},
                [4] = {group = "AztecasG", title = "Aztecas Gerente", blocklist = false},
                [5] = {group = "AztecasC", title = "Aztecas Contratado", blocklist = false},
                [6] = {group = "AztecasR", title = "Aztecas Recruta", blocklist = false},
            },
        }
    }
},
["elementscontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Elements", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Elements", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "ElementsLider", title = "Elements Lider", blocklist = false},
                [2] = {group = "ElementsD", title = "Elements Diretor", blocklist = false},
                [3] = {group = "ElementsGG", title = "Elements Gerente Geral", blocklist = false},
                [4] = {group = "ElementsG", title = "Elements Gerente", blocklist = false},
                [5] = {group = "ElementsC", title = "Elements Contratado", blocklist = false},
                [6] = {group = "ElementsR", title = "Elements Recruta", blocklist = false},
            },
        }
    }
},
["vanillacontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Vanilla", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Vanilla", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "VanillaLider", title = "Vanilla Lider", blocklist = false},
                [2] = {group = "VanillaD", title = "Vanilla Diretor", blocklist = false},
                [3] = {group = "VanillaGG", title = "Vanilla Gerente Geral", blocklist = false},
                [4] = {group = "VanillaG", title = "Vanilla Gerente", blocklist = false},
                [5] = {group = "VanillaC", title = "Vanilla Contratado", blocklist = false},
                [6] = {group = "VanillaR", title = "Vanilla Recruta", blocklist = false},
            },
        }
    }
},
["motoclubcontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Motoclub", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Motoclub", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "MotoclubLider", title = "Motoclub Lider", blocklist = false},
                [2] = {group = "MotoclubD", title = "Motoclub Diretor", blocklist = false},
                [3] = {group = "MotoclubGG", title = "Motoclub Gerente Geral", blocklist = false},
                [4] = {group = "MotoclubG", title = "Motoclub Gerente", blocklist = false},
                [5] = {group = "MotoclubC", title = "Motoclub Contratado", blocklist = false},
                [6] = {group = "MotoclubR", title = "Motoclub Recruta", blocklist = false},
            },
        }
    }
},
["hellsangelscontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Hells Angels", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Hells Angels", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "HellsAngelsLider", title = "Hells Angels Lider", blocklist = false},
                [2] = {group = "HellsAngelsD", title = "Hells Angels Diretor", blocklist = false},
                [3] = {group = "HellsAngelsGG", title = "Hells Angels Gerente Geral", blocklist = false},
                [4] = {group = "HellsAngelsG", title = "Hells Angels Gerente", blocklist = false},
                [5] = {group = "HellsAngelsC", title = "Hells Angels Contratado", blocklist = false},
                [6] = {group = "HellsAngelsR", title = "Hells Angels Recruta", blocklist = false},
            },
        }
    }
},
["cripscontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Crips", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Crips", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "CripsLider", title = "Crips Lider", blocklist = false},
                [2] = {group = "CripsD", title = "Crips Diretor", blocklist = false},
                [3] = {group = "CripsGG", title = "Crips Gerente Geral", blocklist = false},
                [4] = {group = "CripsG", title = "Crips Gerente", blocklist = false},
                [5] = {group = "CripsC", title = "Crips Contratado", blocklist = false},
                [6] = {group = "CripsR", title = "Crips Recruta", blocklist = false},
            },
        }
    }
},
["cartelmedellincontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Cartel Medellin", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Cartel Medellin", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "CartelMedellinLider", title = "Cartel Medellin Lider", blocklist = false},
                [2] = {group = "CartelMdellinD", title = "Cartel Medellin Diretor", blocklist = false},
                [3] = {group = "CartelMdellinGG", title = "Cartel Medellin Gerente Geral", blocklist = false},
                [4] = {group = "CartelMdellinG", title = "Cartel Medellin Gerente", blocklist = false},
                [5] = {group = "CartelMdellinC", title = "Cartel Medellin Contratado", blocklist = false},
                [6] = {group = "CartelMdellinR", title = "Cartel Medellin Recruta", blocklist = false},
            },
        }
    }
},

["contratoshp.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "Hospital", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Hospital", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {
                    group = "Diretoria", -- GRUPO DE SETAGEM
                    title = "Diretoria Hospital", -- LEGENDA DO GRUPO
                    blocklist = false -- SE APLICA BLOCKLIST OU NÃO
                },  -- 
                [2] = {group = "SubDiretoria", title = "SubDiretoria Hospital", blocklist = false},
                [3] = {group = "Cirurgiao", title = "Cirurgiao Hospital", blocklist = false},
                [4] = {group = "MedicoSupervisor", title = "Medico Supervisor Hospital", blocklist = false},
                [5] = {group = "Medico", title = "Medico Hospital", blocklist = false},
                [6] = {group = "Enfermaria", title = "Enfermaria Hospital", blocklist = false},
                [7] = {group = "Paramedico", title = "Paramedico Hospital", blocklist = false},
            },
        }
    }
},

["civilDelegado.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "CivilDelegado", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "Policia Civil", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {
                    group = "Policia Civil", -- GRUPO DE SETAGEM
                    title = "Policia Civil", -- LEGENDA DO GRUPO
                    blocklist = false -- SE APLICA BLOCKLIST OU NÃO
                },  -- 
                [2] = {group = "CivilInvestigador", title = "Civil Investigador", blocklist = false},
                [3] = {group = "CivilEscrivão", title = "Civil Escrivão", blocklist = false},
                [4] = {group = "Civil Agente", title = "Civil Agente", blocklist = false},
            },
        }
    }
},

["prfcoronel.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "PRFCoronel", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "PRF", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {
                    group = "PRF", -- GRUPO DE SETAGEM
                    title = "PRF", -- LEGENDA DO GRUPO
                    blocklist = false -- SE APLICA BLOCKLIST OU NÃO
                },  -- 
                [2] = {group = "PRFMajor", title = "PRF Major", blocklist = false},
                [3] = {group = "PRFCapitão", title = "PRF Capitão", blocklist = false},
                [4] = {group = "PRFTenente", title = "PRF Tenente", blocklist = false},
                [5] = {group = "PRFSargento", title = "PRF Sargento", blocklist = false},
                [6] = {group = "PRFCabo", title = "PRF Cabo", blocklist = false},
                [7] = {group = "PRFSoldado", title = "PRF Soldado", blocklist = false},
                [8] = {group = "PRFRecruta", title = "PRF Recruta", blocklist = false}, 
            },
        }
    }
},


["speedcontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "PMERJ SPEED", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "PMERJ SPEED", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = { -- 
                [1] = {group = "SpeedCoronel", title = "Coronel Speed", blocklist = false},
                [2] = {group = "SpeedTenenteCoronel", title = "Tenente Coronel Speed", blocklist = false},
                [3] = {group = "SpeedMajor", title = "Major Speed", blocklist = false},
                [4] = {group = "SpeedCapitao", title = "Capitão Speed", blocklist = false},
                [5] = {group = "SpeedTenente", title = "Tenente Speed", blocklist = false},
                [6] = {group = "SpeedAspirante", title = "Aspirante Speed", blocklist = false},
                [7] = {group = "SpeedSubTenente", title = "Sub Tenente Speed", blocklist = false},
                [8] = {group = "SpeedSargento", title = "Sargento Speed", blocklist = false},
                [9] = {group = "SpeedCabo", title = "Cabo Speed", blocklist = false},
                [10] = {group = "SpeedSoldado", title = "Soldado Speed", blocklist = false}, 
            },
        }
    }
},

["gamcontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "PMERJ GAM", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "PMERJ GAM", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "GamCoronel", title = "Coronel Gam", blocklist = false},
                [2] = {group = "GamTenenteCoronel", title = "Tenente Coronel Gam", blocklist = false},
                [3] = {group = "GamMajor", title = "Major Gam", blocklist = false},
                [4] = {group = "GamCapitao", title = "Capitão Gam", blocklist = false},
                [5] = {group = "GamTenente", title = "Tenente Gam", blocklist = false},
                [6] = {group = "GamAspirante", title = "Aspirante Gam", blocklist = false},
                [7] = {group = "GamSubTenente", title = "Sub Tenente Gam", blocklist = false},
                [8] = {group = "GamSargento", title = "Sargento Gam", blocklist = false},
                [9] = {group = "GamCabo", title = "Cabo Gam", blocklist = false},
                [10] = {group = "GamSoldado", title = "Soldado Gam", blocklist = false}, 
            },
        }
    }
},

["bopecontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "PMERJ BOPE", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "PMERJ BOPE", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "BopeCoronel", title = "Coronel Bope", blocklist = false},
                [2] = {group = "BopeTenenteCoronel", title = "Tenente Coronel Bope", blocklist = false},
                [3] = {group = "BopeMajor", title = "Major Bope", blocklist = false},
                [4] = {group = "BopeCapitao", title = "Capitão Bope", blocklist = false},
                [5] = {group = "BopeTenente", title = "Tenente Bope", blocklist = false},
                [6] = {group = "BopeAspirante", title = "Aspirante Bope", blocklist = false},
                [7] = {group = "BopeSubTenente", title = "Sub Tenente Bope", blocklist = false},
                [8] = {group = "BopeSargento", title = "Sargento Bope", blocklist = false},
                [9] = {group = "BopeCabo", title = "Cabo Bope", blocklist = false},
                [10] = {group = "BopeSoldado", title = "Soldado Bope", blocklist = false}, 
            },
        }
    }
},

["policiacontratos.permissao"] = { -- PERMISSÃO QUE TERÁ ACESSO A DAR OS CARGOS ABAIXO
    nome = "PMERJ", -- TITULO DA CAIXA DE GRUPOS (NO NUI)
    grupos = {
        [1] = { 
            title = "PMERJ", -- TITULO DA SUB CAIXA DE CARGOS (CASO SO TENHA 1 LISTA DE SUBCARGOS, O TITULO SERÁ O ACIMA)
            cargos = {
                [1] = {group = "Coronel", title = "PMERJ Coronel", blocklist = false},
                [2] = {group = "TenenteCoronel", title = "PMERJ Tenente Coronel", blocklist = false},
                [3] = {group = "Major", title = "PMERJ Major", blocklist = false},
                [4] = {group = "Capitao", title = "PMERJ Capitão", blocklist = false},
                [5] = {group = "Tenente", title = "PMERJ Tenente", blocklist = false},
                [6] = {group = "Aspirante", title = "PMERJ Aspirante", blocklist = false},
                [7] = {group = "SubTenente", title = "PMERJ Sub Tenente", blocklist = false},
                [8] = {group = "Sargento", title = "PMERJ Sargento", blocklist = false},
                [9] = {group = "Cabo", title = "PMERJ Cabo", blocklist = false},
                [10] = {group = "Soldado", title = "PMERJ Soldado", blocklist = false}, 
            },
        }
    }
},
}


-- [[ LOGS HOSPITAL ]] --------------------------------------
Config.webhookTablet = "https://discord.com/api/webhooks/1024063171096481893/tBJ2Tkl5B_Uta59zMCqHIQqpSgsuub-TLLtwjjCgTwp7pIaU6sjdwxrFUB6tNUC6EhjS" -- LOG ABRIR TABLET
Config.webhookTabletRemoveGrupo = "https://discord.com/api/webhooks/1024063091509567519/4APznnMncK79ztfnoY00TIFLuZAf_a_Zz5HWAa_oIrT37knr-pv3V6gYskthbRw-BOsi" -- LOG DE REMOVER GRUPO DE CIDADÃO
Config.webhookTabletEditGrupos = "https://discord.com/api/webhooks/1024062989504102571/qdIM9smOM-FgQbj-TJp3mJdgValH1Ldcom7BwXvJWQx-tVsxRt4NRbQUy3QmkLakJY69" -- LOG DE QUANDO EDITA AS PERMISSOES DO CIDADAO