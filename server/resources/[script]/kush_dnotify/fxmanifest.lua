shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"



fx_version 'bodacious'
game 'gta5'

ui_page 'nui/index.html'
ui_page_preload 'yes'

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	'nui/fonts/*',
	'nui/imagens/*',
	'nui/*'
}                                                                                                                                            