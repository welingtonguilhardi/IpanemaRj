local cfg = {}

cfg.groups = {

---------------------------------
---STAFF---------
---------------------------------
    ["Amais"] = {
		"policia.permissao",
		"dados.permissao",
		"mecanico.permissao"
	},	
    
	["Admin"] = {
		"admin.permissao",
		"dono.permissao",
		"wall.permissao",
		"nc.permissao",
		"god.permissao",
		"godall.permissao",
		"staff.permissao",
		"tp.permissao",
		"tpall.permissao",
		"kickall.permissao",
		"kick.permissao",
		"ban.permissao",
		"group.permissao",
		"fix.permissao",
		"car.permissao",
		"dv.permissao",
		"addcar.permissao",
		"remcar.permissao",
		"cds.permissao",
		"reset.permissao",
		"staffon.permissao",
		"money.permissao",
		"carcolor.permissao",
		"addmoney.permissao",
		"tuning.permissao",
		"limpainv.permissao",
		"coleteusar.permissao",
		"pon.permissao",
		"admanuncios.permissao",
		"rename.permissao",
		"arma.permissao",
		"wl.permissao",
		"rg2.permissao",
		"segurarnoh.permissao",
		"rg.permissao",
		"dm.permissao",
		"ajuda.permissao",
		"kill.permissao"
		
	},	

	["Cordenador"] = {
		"cordenador.permissao",
		"polpar.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"ajuda.permissao",
    },

	["Diretor"] = {
		"diretor.permissao",
		"polpar.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"ajuda.permissao",
    },

	["Administrador"] = {
		"administrador.permissao",
		"polpar.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"ajuda.permissao",
    },

	["Mod"] = {
		"mod.permissao",
		"polpar.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"ajuda.permissao",
	},

	["Suporte"] = {
		_config = {
			title = "Suporte",
			gtype = "suporte"
		},
		"suporte.permissao",
		"player.blips",
		"player.spec",
		"player.noclip",
		"player.secret",
		"player.wall",
		"ajuda.permissao",
		"ticket.permissao"
	},
	["Instagram"] = {
		_config = {
			title = "Instagram",
			gtype = "instagram"
		},
		"instagram.permissao"
	},
	["paintball"] = {
		_config = {
			title = "Paintball",
			gtype = "paintball"
		},
		"paintball.permissao"
	},
	["Blips"] = {
		"blips.permissao"
	},
	["CSC"] = {
		_config = {
			title = "CSC",
			gtype = "altl"
		},
		"sem.permissao"
	},
	["Juiz"] = {
		_config = {
			title = "Juiz",
			gtype = "job"
		},
		"juiz.permissao",
		"advogado.permissao",
		"portadp.permissao",
		"sem.permissao"
	},
	["PaisanaJuiz"] = {
		_config = {
			title = "PaisanaJuiz",
			gtype = "job"
		},
		"paisanajuiz.permissao",
		"advogado.permissao",
		"portadp.permissao",
		"sem.permissao"
	},
	["Skins"] = {
		_config = {
			title = "Skins",
			gtype = "altl"
		},
		"personagem.permissao"
	},
	["Advogado"] = {
		_config = {
			title = "Advogado",
			gtype = "job"
		},
		"advogado.permissao",
		"advogado2.permissao",
		"sem.permissao"
	},
	["PaisanaAdvogado"] = {
		_config = {
			title = "PaisanaAdvogado",
			gtype = "job"
		},
		"paisanaadvogado.permissao",
		"sem.permissao"
	},
	["Bennys"] = {
		_config = {
			title = "Bennys",
			gtype = "job"
		},
		"bennys.permissao",
		"tunagem.permissao",
		"sem.permissao"
	},
	["PaisanaBennys"] = {
		_config = {
			title = "Bennys | F.Serviço",
			gtype = "job"
		},
		"paisanabennys.permissao",
		"sem.permissao"
	},
---------Policia-----------------------	
	["Soldado"] = {
		_config = {
			title = "Soldado",
			gtype = "job"
		},
		"policia.permissao",
		"policiaSoldado.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'Soldado.permissao',
		"player.blips",
		"sem.permissao"
	},
	["Cabo"] = {
		_config = {
			title = "Cabo",
			gtype = "job"
		},
		"policia.permissao",
		"policiaCabo.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'Cabo.permissao',
		"player.blips",
		"sem.permissao"
	},
	["Sargento"] = {
		_config = {
			title = "Sargento",
			gtype = "job"
		},
		"policia.permissao",
		"policiaSargento.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'Sargento.permissao',
		"player.blips",
		"sem.permissao"
	},
	["SubTenente"] = {
		_config = {
			title = "Sub Tenente",
			gtype = "job"
		},
		"policia.permissao",
		"policiaSubTenente.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"SubTenente.permissao",
		"player.blips",
		"sem.permissao"
	},
	["Aspirante"] = {
		_config = {
			title = "Aspirante a Oficial",
			gtype = "job"
		},
		"policia.permissao",
		"policiaAspirante.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"Aspirante.permissao",
		"player.blips",
		"sem.permissao"
	},
	["Tenente"] = {
		_config = {
			title = "Tenente",
			gtype = "job"
		},
		"policia.permissao",
		"policiaTenente.permissao",
		"polpar.permissao",
		"Tenente.permissao",
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},
	["Capitao"] = {
		_config = {
			title = "Capitão",
			gtype = "job"
		},
		"policia.permissao",
		"policia.permissao",
		"polpar.permissao",
		"CapitaoCapitao.permissao",
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},
	["Major"] = {
		_config = {
			title = "Major",
			gtype = "job"
		},
		"policia.permissao",
		"policiaMajor.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"Major.permissao",
		"player.blips",
		"sem.permissao"
	},
	["TenenteCoronel"] = {
		_config = {
			title = "Tenente Coronel",
			gtype = "job"
		},
		"policia.permissao",
		"policiaTenenteCoronel.permissao",
		"polpar.permissao",
		"TenenteCoronel.permissao",
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},
	["Coronel"] = {
		_config = {
			title = "Coronel",
			gtype = "job"
		},
		"policia.permissao",
		"policiaCoronel.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"Coronel.permissao",
		'policiacontratos.permissao',
		"player.blips",
		"sem.permissao"
	},
	["Comandante"] = {
		_config = {
			title = "Coronel",
			gtype = "job"
		},
		"policiaComando.permissao",
		"policia.permissao",
		'policiacontratos.permissao',
		'speedcontratos.permissao',
		'gamcontratos.permissao',
		'bopecontratos.permissao',
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'gam.permissao',
		"speed.permissao",
		"player.blips",
		"sem.permissao"
	},
------------Divisão BOPE----------
	["BopeSoldado"] = {
		_config = {
			title = "Soldado Bope",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeSoldado.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeCabo"] = {
		_config = {
			title = "Cabo Bope",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeCabo.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeSargento"] = {
		_config = {
			title = "Sargento Bope",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeSargento.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeSubTenente"] = {
		_config = {
			title = "Sub Tenente Bope",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeSubTenente.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeAspirante"] = {
		_config = {
			title = "Aspirante a Oficial",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		'bope.permissao',
		'bopeAspirante.permissao',
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},
	["BopeTenente"] = {
		_config = {
			title = "Tenente Bope",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeTenente.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeCapitao"] = {
		_config = {
			title = "Capitão Bope",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeCapitao.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeMajor"] = {
		_config = {
			title = "Major",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeMajor.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeTenenteCoronel"] = {
		_config = {
			title = "Tenente Coronel Bope",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'bope.permissao',
		'bopeTenenteCoronel.permissao',
		"player.blips",
		"sem.permissao"
	},
	["BopeCoronel"] = {
		_config = {
			title = "Coronel Bope",
			gtype = "job"
		},
		"policia.permissao",
		'bopecontratos.permissao',
		'bope.permissao',
		'bopeCoronel.permissao',
		"polpar.permissao",
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},





------------Divisão SPEED----------
	["SpeedSoldado"] = {
		_config = {
			title = "Soldado Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedSoldado.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedCabo"] = {
		_config = {
			title = "Cabo Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedCabo.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedSargento"] = {
		_config = {
			title = "Sargento Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedSargento.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedSubTenente"] = {
		_config = {
			title = "Sub Tenente Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedSubTenente.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedAspirante"] = {
		_config = {
			title = "Aspirante a Oficial Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedAspirante.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedTenente"] = {
		_config = {
			title = "Tenente Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedTenente.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedCapitao"] = {
		_config = {
			title = "Capitão Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedCapitao.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedMajor"] = {
		_config = {
			title = "Major Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedMajor.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedTenenteCoronel"] = {
		_config = {
			title = "Tenente Coronel Speed",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"speed.permissao",
		"speedTenenteCoronel.permissao",
		"player.blips",
		"sem.permissao"
	},
	["SpeedCoronel"] = {
		_config = {
			title = "Coronel Speed",
			gtype = "job"
		},
		"policia.permissao",
		'speedcontratos.permissao',
		"speed.permissao",
		"speedCoronel.permissao",
		"polpar.permissao",
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},
------------Divisão GAM----------	
	["GamSoldado"] = {
		_config = {
			title = "Soldado Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'gam.permissao',
		'gamSoldado.permissao',
		"player.blips",
		"sem.permissao"
	},
	["GamCabo"] = {
		_config = {
			title = "Cabo Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		'gam.permissao',
		'gamCabo.permissao',
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},
	["GamSargento"] = {
		_config = {
			title = "Sargento Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		'gam.permissao',
		'gamSargento.permissao',
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},
	["GamSubTenente"] = {
		_config = {
			title = "Sub Tenente Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'gam.permissao',
		'gamSubTenente.permissao',
		"player.blips",
		"sem.permissao"
	},
	["GamAspirante"] = {
		_config = {
			title = "Aspirante a Oficial Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'gam.permissao',
		'gamAspirante.permissao',
		"player.blips",
		"sem.permissao"
	},
	["GamTenente"] = {
		_config = {
			title = "Tenente Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'gam.permissao',
		'gamTenente.permissao',
		"player.blips",
		"sem.permissao"
	},
	["GamCapitao"] = {
		_config = {
			title = "Capitão Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'gam.permissao',
		'gamCapitao.permissao',
		"player.blips",
		"sem.permissao"
	},
	["GamMajor"] = {
		_config = {
			title = "Major Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'gam.permissao',
		'gamMajor.permissao',
		"player.blips",
		"sem.permissao"
	},
	["GamTenenteCoronel"] = {
		_config = {
			title = "Tenente Coronel Gam",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"portadp.permissao",
		'gam.permissao',
		'gamTenenteCoronel.permissao',
		"player.blips",
		"sem.permissao"
	},
	["GamCoronel"] = {
		_config = {
			title = "Coronel Gam",
			gtype = "job"
		},
		"policia.permissao",
		'gamcontratos.permissao',
		'gam.permissao',
		'gamCoronel.permissao',
		"polpar.permissao",
		"portadp.permissao",
		"player.blips",
		"sem.permissao"
	},


------------PaisanaPolicia----------
	["PaisanaComandante"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaComandante.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaSoldado"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaSoldado.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaCabo"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaCabo.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaSargento"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaSargento.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaSubTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaSubTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaAspirante"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaAspirante.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaCapitao"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaCapitao.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaMajor"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaMajor.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaTenenteCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaTenenteCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["PaisanaCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"paisanaCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
------------Paisanabope----------
	["BopePaisanaSoldado"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaSoldado.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaCabo"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaCabo.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaSargento"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaSargento.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaSubTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaSubTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaAspirante"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaAspirante.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaCapitao"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaCapitao.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaMajor"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaMajor.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaTenenteCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaTenenteCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["BopePaisanaCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"BopepaisanaCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
------------PaisanaSpeed----------
	["SpeedPaisanaSoldado"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaSoldado.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaCabo"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaCabo.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaSargento"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaSargento.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaSubTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaSubTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaAspirante"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaAspirante.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaCapitao"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaCapitao.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaMajor"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaMajor.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaTenenteCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaTenenteCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["SpeedPaisanaCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"SpeedpaisanaCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	------------Paisana Gam----------
	["GamPaisanaSoldado"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaSoldado.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaCabo"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaCabo.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaSargento"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaSargento.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaSubTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaSubTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaAspirante"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaAspirante.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaTenente"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaTenente.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaCapitao"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaCapitao.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaMajor"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaMajor.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaTenenteCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaTenenteCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},
	["GamPaisanaCoronel"] = {
		_config = {
			title = "Policia | F.Serviço",
			gtype = "job"
		},
		"GampaisanaCoronel.permissao",
		"policiapaisana.permissao",
		"sem.permissao"
	},			
-------------------------------------------------------------------------	
	["PaisanaMerry"] = {
		_config = {
			title = "Merry | F.Serviço",
			gtype = "job"
		},
		"paisanamerry.permissao",
		"sem.permissao"
	},
	--------------------------------------------------------------------
	["Diretoria"] = {
		_config = {
			title = "Diretoria",
			gtype = "job"
		},
		"diretora.permissao",
		"paramedico.permissao",
		"contratoshp.permissao",
		"polpar.permissao",
		"sem.permissao",
		"jobparamedico.permissao"
	},
	["SubDiretoria"] = {
		_config = {
			title = "Sub Diretoria",
			gtype = "job"
		},
		"paramedico.permissao",
		"contratoshp.permissao",
		"polpar.permissao",
		"sem.permissao",
		"subdiretora.permissao",
		"jobparamedico.permissao"
	},
	["Cirurgiao"] = {
		_config = {
			title = "Cirurgião",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao",
		"sem.permissao",
		"supervisaoala.permissao",
		--"jobparamedico.permissao"
	},
	["MedicoSupervisor"] = {
		_config = {
			title = "Medico Supervisor",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao",
		"sem.permissao",
		"medicochefe.permissao",
		--"jobparamedico.permissao"
	},
	["Medico"] = {
		_config = {
			title = "Medico",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao",
		"sem.permissao",
		"medico.permissao",
		--"jobparamedico.permissao"
	}, 
	["Enfermaria"] = {
		_config = {
			title = "Enfermaria",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao",
		"sem.permissao",
		"residente.permissao",
		--"jobparamedico.permissao"
	},
	["Paramedico"] = {
		_config = {
			title = "Paramedico",
			gtype = "job"
		},
		"paramedico.permissao",
		"paramedicoj.permissao",
		"enfermeiro.permissao",
		"polpar.permissao",
		"sem.permissao",
		--"jobparamedico.permissao"
	},
	---------------------------------------------------------------------
	["PaisanaParamedico"] = {
		_config = {
			title = "PaisanaParamedico",
			gtype = "job"
		},
		"paisanaparamedico.permissao",
		"sem.permissao"
	},
	["PaisanaEnfermaria"] = {
		_config = {
			title = "PaisanaEnfermaria",
			gtype = "job"
		},
		"paisanaresidente.permissao",
		"sem.permissao"
	},
	["PaisanaMedico"] = {
		_config = {
			title = "PaisanaMedico",
			gtype = "job"
		},
		"paisanamedico.permissao",
		"sem.permissao"
	},
	["PaisanaMedicoSupervisor"] = {
		_config = {
			title = "PaisanaMedicoSupervisor",
			gtype = "job"
		},
		"paisanamedicochefe.permissao",
		"sem.permissao"
	},
	["PaisanaCirurgiao"] = {
		_config = {
			title = "PaisanaCirurgiao",
			gtype = "job"
		},
		"paisanasupervisaoala.permissao",
		"sem.permissao"
	},
	["PaisanaSubChefe"] = {
		_config = {
			title = "PaisanaSubChefe",
			gtype = "job"
		},
		"paisanasubchefe.permissao",
		"sem.permissao"
	},
	["PaisanaSubDiretoria"] = {
		_config = {
			title = "PaisanaSubDiretoria",
			gtype = "job"
		},
		"paisanasubdiretora.permissao",
		"sem.permissao"
	},
	["PaisanaDiretoria"] = {
		_config = {
			title = "PaisanaDiretoria",
			gtype = "job"
		},
		"paisanadiretora.permissao",
		"sem.permissao"
	},
	--------------------------------------------------------------------------------------
	["MecanicoA"] = {
		_config = {
			title = "Mecanico Aprendiz",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanicoA.permissao",
		"bennys.permissao",
		"tunagem.permissao",
		"sem.permissao"
	},
	["MecanicoC"] = {
		_config = {
			title = "Mecanico Contratado",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanicoC.permissao",
		"bennys.permissao",
		"tunagem.permissao",
		"sem.permissao"
	},
	["MecanicoG"] = {
		_config = {
			title = "Mecanico Gerente",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanicoG.permissao",
		"bennys.permissao",
		"tunagem.permissao",
		"sem.permissao"
	},
	["MecanicoGG"] = {
		_config = {
			title = "Mecanico Gerente Geral",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanicoGG.permissao",
		"bennys.permissao",
		"contratosmecanico.permissao",
		"tunagem.permissao",
		"sem.permissao"
	},
	["MecanicoL"] = {
		_config = {
			title = "Mecanico Lider",
			gtype = "job"
		},
		"mecanico.permissao",
		"mecanicoL.permissao",
		"contratosmecanico.permissao",
		"bennys.permissao",
		"tunagem.permissao",
		"sem.permissao"
	},
	-----------------------------PAISANA MECANICO-----------------------------
	["PaisanaMecanicoA"] = {
		_config = {
			title = "Mecanico | Descanso",
			gtype = "job"
		},
		"paisanamecanicoA.permissao"
	},
	["PaisanaMecanicoC"] = {
		_config = {
			title = "Mecanico | Descanso",
			gtype = "job"
		},
		"paisanamecanicoC.permissao"
	},
	["PaisanaMecanicoG"] = {
		_config = {
			title = "Mecanico | Descanso",
			gtype = "job"
		},
		"paisanamecanicoG.permissao"
	},
	["PaisanaMecanicoGG"] = {
		_config = {
			title = "Mecanico | Descanso",
			gtype = "job"
		},
		"paisanamecanicoGG.permissao"
	},
	["PaisanaMecanicoL"] = {
		_config = {
			title = "Mecanico | Descanso",
			gtype = "job"
		},
		"paisanamecanicoL.permissao"
	},

--------------------------------------------------------------------------------------------------------------------------------------


	["Taxista"] = {
		--[[_config = {
			title = "Taxista",
			gtype = "job"
		},]]
		"taxista.permissao",
		"sem.permissao"
	},
	["PaisanaTaxista"] = {
		--[[_config = {
			title = "PaisanaTaxista",
			gtype = "job"
		},]]
		"paisanataxista.permissao",
		"sem.permissao"
	},

	['inicial'] = { 
		_config = {
		title = 'VIP Inicial',
		gtype = 'vip'  
	},
	'bronze.permissao', 
	'som.permissao',
	'mochilam.permissao'
	},
	["Bronze"] = {
		_config = {
			title = "Bronze",
			gtype = "vip"
		},
		"bronze.permissao"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip"
		},
		"prata.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip"
		},
		"ouro.permissao",
		"mochila.permissao"
	},
	["Personalizado"] = {
		_config = {
			title = "Personalizado",
			gtype = "vip"
		},
		"personalizado.permissao",
		"mochila.permissao"
	},
	["Wipe"] = {
		_config = {
			title = "Wipe",
			gtype = "vip"
		},
		"wipe.permissao",
		"mochila.permissao"
	},
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"mochila.permissao"
	},
	["Diamante"] = {
		_config = {
			title = "Diamante",
			gtype = "vip"
		},
		"diamante.permissao",
		"mochila.permissao"
	},
	["Supremo"] = {
		_config = {
			title = "Supremo",
			gtype = "vip"
		},
		"supremo.permissao",
		"mochila.permissao"
	},
	["Mafia"] = {
		_config = {
			title = "Mafia",
			gtype = "job"
		},
		"mafia.permissao",
		"ilegal.permissao"
	},
	["Transportadora"] = {
		"trans.permissao"
	},
	["ConcessionariaL"] = {
		_config = {
			title = "Concessionaria job",
			gtype = "job"
		},
		"concessionarial.permissao",
		"concessionaria.permissao",
		"conce.permissao",
		"vendedor.permissao",
		"sem.permissao"
	},
	["Concessionaria"] = {
		_config = {
			title = "Concessionaria",
			gtype = "job"
		},
		"concessionaria.permissao",
		"conce.permissao",
		"vendedor.permissao",
		"sem.permissao"
	},
	["Piloto"] = {
		_config = {
			title = "Piloto",
			gtype = "alt"
		},
		"piloto.permissao"
	},
	["Policiajob"] = {
		_config = {
			title = "Comandante",
			gtype = "job"
		},
		"jobpolicia.permissao",
		"sem.permissao"
	},
	["Mecanicojob"] = {
		_config = {
			title = "Mecanico Chefe",
			gtype = "job"
		},
		"mecanicojob.permissao"
	},
	["Paramedicojob"] = {
		_config = {
			title = "Paramedico Diretor",
			gtype = "job"
		},
		"jobparamedico.permissao",
		"sem.permissao"
	},
	["Mafiajob"] = {
		_config = {
			title = "Mafia job",
			gtype = "job"
			},
		"jobmafia.permissao",
		"ilegal.permissao"
	},
-------------------------------------------------------------------------------------
----FACS------------------------
-------------------------------------------------------------------------------------

------------------------------
--1---Yakuza----
------------------------------

	["YakuzaLider"] = {
		_config = {
			title = "Yakuza Lider",
			gtype = "job"
			},
		"lideryakuza.permissao",
		"yakuza.permissao",
		"contratosyakuza.permissao",
		"ilegal.permissao"
	},
	["YakuzaD"] = {
		_config = {
			title = "Yakuza Diretor",
			gtype = "job"
		},
		"yakuza.permissao",
		"contratosyakuza.permissao",
		"ilegal.permissao"
	},
	["YakuzaGG"] = {
		_config = {
			title = "Yakuza Gerente Geral",
			gtype = "job"
		},
		"yakuza.permissao",
		"ilegal.permissao"
	},
	["YakuzaG"] = {
		_config = {
			title = "Yakuza Gerente",
			gtype = "job"
		},
		"yakuza.permissao",
		"ilegal.permissao"
	},
	["YakuzaC"] = {
		_config = {
			title = "Yakuza Contratado",
			gtype = "job"
		},
		"yakuza.permissao",
		"ilegal.permissao"
	},
	["YakuzaR"] = {
		_config = {
			title = "Yakuza Recruta",
			gtype = "job"
		},
		"yakuza.permissao",
		"ilegal.permissao"
	},

------------------------------
--2-Cosanostra--
------------------------------

	["CosanostraLider"] = {
		_config = {
			title = "Cosanostra Lider",
			gtype = "job"
			},
		"lidercoscosanostra.permissao",
		"contratoscosanostra.permissao",
		"cosanostra.permissao",
		"municao.permissao",
		"ilegal.permissao"
	},
	["CosanostraD"] = {
		_config = {
			title = "Cosanostra Diretor",
			gtype = "job"
		},
		"cosanostra.permissao",
		"contratoscosanostra.permissao",
		"municao.permissao",
		"ilegal.permissao"
	},
	["CosanostraGG"] = {
		_config = {
			title = "Cosanostra Gerente Geral",
			gtype = "job"
		},
		"cosanostra.permissao",
		"municao.permissao",
		"ilegal.permissao"
	},
	["CosanostraG"] = {
		_config = {
			title = "Cosanostra Gerente",
			gtype = "job"
		},
		"cosanostra.permissao",
		"municao.permissao",
		"ilegal.permissao"
	},
	["CosanostraC"] = {
		_config = {
			title = "Cosanostra Contratado",
			gtype = "job"
		},
		"cosanostra.permissao",
		"municao.permissao",
		"ilegal.permissao"
	},
	["CosanostraR"] = {
		_config = {
			title = "Cosanostra Recruta",
			gtype = "job"
		},
		"cosanostra.permissao",
		"municao.permissao",
		"ilegal.permissao"
	},

------------------------------
--3---Grove-----
------------------------------

    ["GroveLider"] = {
		_config = {
			title = "Grove Lider",
			gtype = "job"
			},
		"lidergrove.permissao",
		"contratosgrove.permissao",
		"ilegal.permissao"
	},
	["GroveD"] = {
		_config = {
			title = "Grove Diretor",
			gtype = "job"
		},
		"grove.permissao",
		"contratosgrove.permissao",
		"ilegal.permissao"
	},
	["GroveGG"] = {
		_config = {
			title = "Grove Gerente Geral",
			gtype = "job"
		},
		"grove.permissao",
		"ilegal.permissao"
	},
	["GroveG"] = {
		_config = {
			title = "Grove Gerente",
			gtype = "job"
		},
		"grove.permissao",
		"ilegal.permissao"
	},
	["GroveC"] = {
		_config = {
			title = "Grove Contratado",
			gtype = "job"
		},
		"grove.permissao",
		"ilegal.permissao"
	},
	["GroveR"] = {
		_config = {
			title = "Grove Recruta",
			gtype = "job"
		},
		"grove.permissao",
		"ilegal.permissao"
	},

------------------------------
--4---Vagos-----
------------------------------

	["VagosLider"] = {
		_config = {
			title = "Vagos Lider",
			gtype = "job"
		    },
		"jobvagos.permissao",
		"trafico.permissao",
		"vagos.permissao",
		"contratosvagos.permissao",
		"ilegal.permissao"
	},
	["VagosD"] = {
		_config = {
			title = "Vagos Diretor",
			gtype = "job"
		},
		"vagos.permissao",
		"trafico.permissao",
		"contratosvagos.permissao",
		"ilegal.permissao"
	},
	["VagosGG"] = {
		_config = {
			title = "Vagos Gerente Geral",
			gtype = "job"
		},
		"vagos.permissao",
		"trafico.permissao",
		"ilegal.permissao"
	},
	["VagosG"] = {
		_config = {
			title = "Vagos Gerente",
			gtype = "job"
		},
		"vagos.permissao",
		"trafico.permissao",
		"ilegal.permissao"
	},
	["VagosC"] = {
		_config = {
			title = "Vagos Contratado",
			gtype = "job"
		},
		"vagos.permissao",
		"trafico.permissao",
		"ilegal.permissao"
	},
	["VagosR"] = {
		_config = {
			title = "Vagos Recruta",
			gtype = "job"
		},
		"vagos.permissao",
		"trafico.permissao",
		"ilegal.permissao"
	},

------------------------------
--5---Ballas----
------------------------------


	["BallasLider"] = {
		_config = {
			title = "Ballas Lider",
			gtype = "job"
		    },
		"liderballas.permissao",
		"ballas.permissao",
		"contratosballas.permissao",
		"ilegal.permissao"
	},
	["BallasD"] = {
		_config = {
			title = "Ballas Diretor",
			gtype = "job"
		},
		"ballas.permissao",
		"contratosballas.permissao",
		"ilegal.permissao"
	},
	["BallasGG"] = {
		_config = {
			title = "Ballas Gerente Geral",
			gtype = "job"
		},
		"ballas.permissao",
		"ilegal.permissao"
	},
	["BallasG"] = {
		_config = {
			title = "Ballas Gerente",
			gtype = "job"
		},
		"ballas.permissao",
		"ilegal.permissao"
	},
	["BallasC"] = {
		_config = {
			title = "Ballas Contratado",
			gtype = "job"
		},
		"ballas.permissao",
		"ilegal.permissao"
	},
	["BallasR"] = {
		_config = {
			title = "Ballas Recruta",
			gtype = "job"
		},
		"ballas.permissao",
		"ilegal.permissao"
	},

------------------------------
--6---Bratva----
------------------------------


	["BratvaLider"] = {
		_config = {
			title = "Bratva Lider",
			gtype = "job"
		    },
		"liderbratva.permissao",
		"bratvacontratos.permissao",
		"bratva.permissao",
		"ilegal.permissao"
	},
	["BratvaD"] = {
		_config = {
			title = "Bratva Diretor",
			gtype = "job"
		},
		"bratva.permissao",
		"bratvacontratos.permissao",
		"ilegal.permissao"
	},
	["BratvaGG"] = {
		_config = {
			title = "Bratva Gerente Geral",
			gtype = "job"
		},
		"bratva.permissao",
		"ilegal.permissao"
	},
	["BratvaG"] = {
		_config = {
			title = "Bratva Gerente",
			gtype = "job"
		},
		"bratva.permissao",
		"ilegal.permissao"
	},
	["BratvaC"] = {
		_config = {
			title = "Bratva Contratado",
			gtype = "job"
		},
		"bratva.permissao",
		"ilegal.permissao"
	},
	["BratvaR"] = {
		_config = {
			title = "Bratva Recruta",
			gtype = "job"
		},
		"bratva.permissao",
		"ilegal.permissao"
	},

------------------------------
--7---Serpents----
------------------------------


	["SerpentsLider"] = {
		_config = {
			title = "Serpents Lider",
			gtype = "job"
		    },
		"liderserpents.permissao",
		"serpentscontratos.permissao",
		"ilegal.permissao"
	},
	["SerpentsD"] = {
		_config = {
			title = "Serpents Diretor",
			gtype = "job"
		},
		"serpents.permissao",
		"serpentscontratos.permissao",
		"ilegal.permissao"
	},
	["SerpentsGG"] = {
		_config = {
			title = "Serpents Gerente Geral",
			gtype = "job"
		},
		"serpents.permissao",
		"ilegal.permissao"
	},
	["SerpentsG"] = {
		_config = {
			title = "Serpents Gerente",
			gtype = "job"
		},
		"serpents.permissao",
		"ilegal.permissao"
	},
	["SerpentsC"] = {
		_config = {
			title = "Serpents Contratado",
			gtype = "job"
		},
		"serpents.permissao",
		"ilegal.permissao"
	},
	["SerpentsR"] = {
		_config = {
			title = "Serpents Recruta",
			gtype = "job"
		},
		"serpents.permissao",
		"ilegal.permissao"
	},

------------------------------
--8---Maias----
------------------------------


	["MaiasLider"] = {
		_config = {
			title = "Maias Lider",
			gtype = "job"
		    },
		"lidermaias.permissao",
		"maias.permissao",
		"maiascontratos.permissao",
		"ilegal.permissao"
	},
	["MaiasD"] = {
		_config = {
			title = "Maias Diretor",
			gtype = "job"
		},
		"maias.permissao",
		"maiascontratos.permissao",
		"ilegal.permissao"
	},
	["MaiasGG"] = {
		_config = {
			title = "Maias Gerente Geral",
			gtype = "job"
		},
		"maias.permissao",
		"ilegal.permissao"
	},
	["MaiasG"] = {
		_config = {
			title = "Maias Gerente",
			gtype = "job"
		},
		"maias.permissao",
		"ilegal.permissao"
	},
	["MaiasC"] = {
		_config = {
			title = "Maias Contratado",
			gtype = "job"
		},
		"maias.permissao",
		"ilegal.permissao"
	},
	["MaiasR"] = {
		_config = {
			title = "Maias Recruta",
			gtype = "job"
		},
		"maias.permissao",
		"ilegal.permissao"
	},

------------------------------
--9--Camorra----
------------------------------


	["CamorraLider"] = {
		_config = {
			title = "Camorra Lider",
			gtype = "job"
		    },
		"lidercamorra.permissao",
		"camorracontratos.permissao",
		"camorra.permissao",
		"ilegal.permissao"
	},
	["CamorraD"] = {
		_config = {
			title = "Camorra Diretor",
			gtype = "job"
		},
		"camorra.permissao",
		"camorracontratos.permissao",
		"ilegal.permissao"
	},
	["CamorraGG"] = {
		_config = {
			title = "Camorra Gerente Geral",
			gtype = "job"
		},
		"camorra.permissao",
		"ilegal.permissao"
	},
	["CamorraG"] = {
		_config = {
			title = "Camorra Gerente",
			gtype = "job"
		},
		"camorra.permissao",
		"ilegal.permissao"
	},
	["CamorraC"] = {
		_config = {
			title = "Camorra Contratado",
			gtype = "job"
		},
		"camorra.permissao",
		"ilegal.permissao"
	},
	["CamorraR"] = {
		_config = {
			title = "Camorra Recruta",
			gtype = "job"
		},
		"camorra.permissao",
		"ilegal.permissao"
	},

------------------------------
--10--Bahamas----
------------------------------

	["BahamasLider"] = {
		_config = {
			title = "Bahamas Lider",
			gtype = "job"
		    },
		"Liderbahamas.permissao",
		"bahamas.permissao",
		"bahamascontratos.permissao",
		"ilegal.permissao"
	},
	["BahamasD"] = {
		_config = {
			title = "Bahamas Diretor",
			gtype = "job"
		},
		"bahamas.permissao",
		"bahamascontratos.permissao",
		"ilegal.permissao"
	},
	["BahamasGG"] = {
		_config = {
			title = "Bahamas Gerente Geral",
			gtype = "job"
		},
		"bahamas.permissao",
		"ilegal.permissao"
	},
	["BahamasG"] = {
		_config = {
			title = "Bahamas Gerente",
			gtype = "job"
		},
		"bahamas.permissao",
		"ilegal.permissao"
	},
	["BahamasC"] = {
		_config = {
			title = "Bahamas Contratado",
			gtype = "job"
		},
		"bahamas.permissao",
		"ilegal.permissao"
	},
	["BahamasR"] = {
		_config = {
			title = "Bahamas Recruta",
			gtype = "job"
		},
		"bahamas.permissao",
		"ilegal.permissao"
	},

------------------------------
--12--Rgb----
------------------------------

		["Rgb"] = {
		_config = {
			title = "Rgb",
			gtype = "job"
		},
		"rgb.permissao",
		"ilegal.permissao"
	},
		["RgbLider"] = {
		_config = {
			title = "Rgb lider",
			gtype = "job"
		    },
		"liderrgb.permissao",
		"ilegal.permissao"
	},

------------------------------
--13--PCC----
------------------------------


	["PccLider"] = {
		_config = {
			title = "Pcc Lider",
			gtype = "job"
		    },
		"liderpcc.permissao",
		"pcc.permissao",
		"pcccontratos.permissao",
		"ilegal.permissao"
	},
	["PccD"] = {
		_config = {
			title = "Pcc Diretor",
			gtype = "job"
		},
		"pcc.permissao",
		"pcccontratos.permissao",
		"ilegal.permissao"
	},
	["PccGG"] = {
		_config = {
			title = "Pcc Gerente Geral",
			gtype = "job"
		},
		"pcc.permissao",
		"ilegal.permissao"
	},
	["PccG"] = {
		_config = {
			title = "Pcc Gerente",
			gtype = "job"
		},
		"pcc.permissao",
		"ilegal.permissao"
	},
	["PccC"] = {
		_config = {
			title = "Pcc Contratado",
			gtype = "job"
		},
		"pcc.permissao",
		"ilegal.permissao"
	},
	["PccA"] = {
		_config = {
			title = "Pcc Aviãozinho",
			gtype = "job"
		},
		"pcc.permissao",
		"ilegal.permissao"
	},

------------------------------
--14--Cv----
------------------------------


	["CvLider"] = {
		_config = {
			title = "Cv Lider",
			gtype = "job"
		    },
		"lidercv.permissao",
		"cv.permissao",
		"cvcontratos.permissao",
		"ilegal.permissao"
	},
	["CvD"] = {
		_config = {
			title = "Cv Diretor",
			gtype = "job"
		},
		"cv.permissao",
		"cvcontratos.permissao",
		"ilegal.permissao"
	},
	["CvGG"] = {
		_config = {
			title = "Cv Gerente Geral",
			gtype = "job"
		},
		"cv.permissao",
		"ilegal.permissao"
	},
	["CvG"] = {
		_config = {
			title = "Cv Gerente",
			gtype = "job"
		},
		"cv.permissao",
		"ilegal.permissao"
	},
	["CvC"] = {
		_config = {
			title = "Cv Contratado",
			gtype = "job"
		},
		"cv.permissao",
		"ilegal.permissao"
	},
	["CvA"] = {
		_config = {
			title = "Cv Aviãozinho",
			gtype = "job"
		},
		"cv.permissao",
		"ilegal.permissao"
	},

------------------------------
--15--Tequila----
------------------------------


	["TequilaLider"] = {
		_config = {
			title = "Tequila Lider",
			gtype = "job"
		    },
		"lidertequila.permissao",
		"tequila.permissao",
		"tequilacontratos.permissao",
		"ilegal.permissao"
	},
	["TequilaD"] = {
		_config = {
			title = "Tequila Diretor",
			gtype = "job"
		},
		"tequila.permissao",
		"tequilacontratos.permissao",
		"ilegal.permissao"
	},
	["TequilaGG"] = {
		_config = {
			title = "Tequila Gerente Geral",
			gtype = "job"
		},
		"tequila.permissao",
		"ilegal.permissao"
	},
	["TequilaG"] = {
		_config = {
			title = "Tequila Gerente",
			gtype = "job"
		},
		"tequila.permissao",
		"ilegal.permissao"
	},
	["TequilaC"] = {
		_config = {
			title = "Tequila Contratado",
			gtype = "job"
		},
		"tequila.permissao",
		"ilegal.permissao"
	},
	["TequilaR"] = {
		_config = {
			title = "Tequila Recruta",
			gtype = "job"
		},
		"tequila.permissao",
		"ilegal.permissao"
	},

------------------------------
--16--Aztecas----
------------------------------


	["AztecasLider"] = {
		_config = {
			title = "Aztecas Lider",
			gtype = "job"
		    },
		"lideraztecas.permissao",
		"aztecas.permissao",
		"aztecascontratos.permissao",
		"ilegal.permissao"
	},
	["AztecasD"] = {
		_config = {
			title = "Aztecas Diretor",
			gtype = "job"
		},
		"aztecas.permissao",
		"aztecascontratos.permissao",
		"ilegal.permissao"
	},
	["AztecasGG"] = {
		_config = {
			title = "Aztecas Gerente Geral",
			gtype = "job"
		},
		"aztecas.permissao",
		"ilegal.permissao"
	},
	["AztecasG"] = {
		_config = {
			title = "Aztecas Gerente",
			gtype = "job"
		},
		"aztecas.permissao",
		"ilegal.permissao"
	},
	["AztecasC"] = {
		_config = {
			title = "Aztecas Contratado",
			gtype = "job"
		},
		"aztecas.permissao",
		"ilegal.permissao"
	},
	["AztecasR"] = {
		_config = {
			title = "Aztecas Recruta",
			gtype = "job"
		},
		"aztecas.permissao",
		"ilegal.permissao"
	},

------------------------------
--17--Elements----
------------------------------


	["ElementsLider"] = {
		_config = {
			title = "Elements Lider",
			gtype = "job"
		    },
		"jliderelements.permissao",
		"elements.permissao",
		"elementscontratos.permissao",
		"ilegal.permissao"
	},
	["ElementsD"] = {
		_config = {
			title = "Elements Diretor",
			gtype = "job"
		},
		"elements.permissao",
		"elementscontratos.permissao",
		"ilegal.permissao"
	},
	["ElementsGG"] = {
		_config = {
			title = "Elements Gerente Geral",
			gtype = "job"
		},
		"elements.permissao",
		"ilegal.permissao"
	},
	["ElementsG"] = {
		_config = {
			title = "Elements Gerente",
			gtype = "job"
		},
		"elements.permissao",
		"ilegal.permissao"
	},
	["ElementsC"] = {
		_config = {
			title = "Elements Contratado",
			gtype = "job"
		},
		"elements.permissao",
		"ilegal.permissao"
	},
	["ElementsR"] = {
		_config = {
			title = "Elements Recruta",
			gtype = "job"
		},
		"elements.permissao",
		"ilegal.permissao"
	},

------------------------------
--18--Vanilla----
------------------------------


	["VanillaLider"] = {
		_config = {
			title = "Vanilla Lider",
			gtype = "job"
		    },
		"liderelvanilla.permissao",
		"vanilla.permissao",
		"vanillacontratos.permissao",
		"ilegal.permissao"
	},
	["VanillaD"] = {
		_config = {
			title = "Vanilla Diretor",
			gtype = "job"
		},
		"vanilla.permissao",
		"vanillacontratos.permissao",
		"ilegal.permissao"
	},
	["VanillaGG"] = {
		_config = {
			title = "Vanilla Gerente Geral",
			gtype = "job"
		},
		"vanilla.permissao",
		"ilegal.permissao"
	},
	["VanillaG"] = {
		_config = {
			title = "Vanilla Gerente",
			gtype = "job"
		},
		"vanilla.permissao",
		"ilegal.permissao"
	},
	["VanillaC"] = {
		_config = {
			title = "Vanilla Contratado",
			gtype = "job"
		},
		"vanilla.permissao",
		"ilegal.permissao"
	},
	["VanillaR"] = {
		_config = {
			title = "Vanilla Recruta",
			gtype = "job"
		},
		"vanilla.permissao",
		"ilegal.permissao"
	},


------------------------------
--19--Motoclub----
------------------------------


	["MotoclubLider"] = {
		_config = {
			title = "Motoclub Lider",
			gtype = "job"
		    },
		"lidermotoclub.permissao",
		"motoclubcontratos.permissao",
		"motoclub.permissao",
		"ilegal.permissao"
	},
	["MotoclubD"] = {
		_config = {
			title = "Motoclub Diretor",
			gtype = "job"
		},
		"motoclub.permissao",
		"motoclubcontratos.permissao",
		"ilegal.permissao"
	},
	["MotoclubGG"] = {
		_config = {
			title = "Motoclub Gerente Geral",
			gtype = "job"
		},
		"motoclub.permissao",
		"ilegal.permissao"
	},
	["MotoclubG"] = {
		_config = {
			title = "Motoclub Gerente",
			gtype = "job"
		},
		"motoclub.permissao",
		"ilegal.permissao"
	},
	["MotoclubC"] = {
		_config = {
			title = "Motoclub Contratado",
			gtype = "job"
		},
		"motoclub.permissao",
		"ilegal.permissao"
	},
	["MotoclubR"] = {
		_config = {
			title = "Motoclub Recruta",
			gtype = "job"
		},
		"motoclub.permissao",
		"ilegal.permissao"
	},

------------------------------
--20--HellsAngels--
------------------------------


	["HellsAngelsLider"] = {
		_config = {
			title = "Hells Angels Lider",
			gtype = "job"
		    },
		"hellsangelslider.permissao",
		"hellsangels.permissao",
		"hellsangelscontratos.permissao",
		"ilegal.permissao"
	},
	["HellsAngelsD"] = {
		_config = {
			title = "Hells Angels Diretor",
			gtype = "job"
		},
		"hellsangels.permissao",
		"hellsangelscontratos.permissao",
		"ilegal.permissao"
	},
	["HellsAngelsGG"] = {
		_config = {
			title = "Hells Angels Gerente Geral",
			gtype = "job"
		},
		"hellsangels.permissao",
		"ilegal.permissao"
	},
	["HellsAngelsG"] = {
		_config = {
			title = "Hells Angels Gerente",
			gtype = "job"
		},
		"hellsangels.permissao",
		"ilegal.permissao"
	},
	["HellsAngelsC"] = {
		_config = {
			title = "Hells Angels Contratado",
			gtype = "job"
		},
		"hellsangels.permissao",
		"ilegal.permissao"
	},
	["HellsAngelsR"] = {
		_config = {
			title = "Hells Angels Recruta",
			gtype = "job"
		},
		"hellsangels.permissao",
		"ilegal.permissao"
	},

------------------------------
--21--Crips----
------------------------------


	["CripsLider"] = {
		_config = {
			title = "Crips Lider",
			gtype = "job"
		    },
		"liderelcrips.permissao",
		"crips.permissao",
		"cripscontratos.permissao",
		"ilegal.permissao"
	},
	["CripsD"] = {
		_config = {
			title = "Crips Diretor",
			gtype = "job"
		},
		"crips.permissao",
		"cripscontratos.permissao",
		"ilegal.permissao"
	},
	["CripsGG"] = {
		_config = {
			title = "Crips Gerente Geral",
			gtype = "job"
		},
		"crips.permissao",
		"ilegal.permissao"
	},
	["CripsG"] = {
		_config = {
			title = "Crips Gerente",
			gtype = "job"
		},
		"crips.permissao",
		"ilegal.permissao"
	},
	["CripsC"] = {
		_config = {
			title = "Crips Contratado",
			gtype = "job"
		},
		"crips.permissao",
		"ilegal.permissao"
	},
	["CripsR"] = {
		_config = {
			title = "Crips Recruta",
			gtype = "job"
		},
		"crips.permissao",
		"ilegal.permissao"
	},

------------------------------
--22--Cartel Medellin----
------------------------------


	["CartelMedellinLider"] = {
		_config = {
			title = "Cartel Medellin Lider",
			gtype = "job"
		    },
		"liderelcartelmedellin.permissao",
		"cartelmedellin.permissao",
		"cartelmedellincontratos.permissao",
		"ilegal.permissao"
	},
	["CartelMdellinD"] = {
		_config = {
			title = "Cartel Medellin Diretor",
			gtype = "job"
		},
		"cartelmedellin.permissao",
		"cartelmedellincontratos.permissao",
		"ilegal.permissao"
	},
	["CartelMdellinGG"] = {
		_config = {
			title = "Cartel Medellin Gerente Geral",
			gtype = "job"
		},
		"cartelmedellin.permissao",
		"ilegal.permissao"
	},
	["CartelMdellinG"] = {
		_config = {
			title = "Cartel Medellin Gerente",
			gtype = "job"
		},
		"cartelmedellin.permissao",
		"ilegal.permissao"
	},
	["CartelMdellinC"] = {
		_config = {
			title = "Cartel Medellin Contratado",
			gtype = "job"
		},
		"cartelmedellin.permissao",
		"ilegal.permissao"
	},
	["CartelMdellinR"] = {
		_config = {
			title = "Cartel Medellin Recruta",
			gtype = "job"
		},
		"cartelmedellin.permissao",
		"ilegal.permissao"
	},


	

}

cfg.users = {
	[0] = { "Admin" },
	[1] = { "Admin" }
}

cfg.selectors = {}

return cfg