shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

author 'Carioca Development'
contact 'Discord: https://discord.gg/w6wK9MW4cW'
version '1.0.1'

ui_page 'nui/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'config/config.lua',
	'config/cl_functions.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config/config.lua',
	'config/sv_functions.lua',
	'server.lua'
}

files {
	'nui/index.html',
	'nui/script.js',
	'nui/style.css',
	'nui/images/*.png',
	'nui/images/icons/*.png'
}              