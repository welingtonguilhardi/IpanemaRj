Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")

--[ CONFIGURAÇÃO ]----------------------------------------------------------------------------------------------------------------

Config.isHandcuffed = vRP.isHandcuffed

Config.carregarObjeto = vRP._CarregarObjeto

Config.stopAnim = vRP._stopAnim

Config.deletarObjeto = vRP._DeletarObjeto