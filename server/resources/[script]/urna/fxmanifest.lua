fx_version "bodacious"
game "gta5"

ui_page "nui/index.html"
client_script {
    
    "@vrp/lib/utils.lua",
    "cl.lua",
    'Config.lua'
}
server_scripts {
	"@vrp/lib/utils.lua",
	"sv.lua",
    'Config.lua'
}

files {
    "nui/index.html"
}