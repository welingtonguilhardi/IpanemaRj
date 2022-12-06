fx_version "adamant"
game "gta5"

name "Flux Anticheat"
author "suporte@fluxanticheat.com"
description "www.fluxanticheat.com"

client_script {
	"client.lua"
}

server_script {
	"@mysql-async/lib/MySQL.lua",
	"compat.lua",
	"server.lua"
}
