fx_version "bodacious"
game "gta5"

ui_page "index.html"
client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/sv_auth.lua",
}
files {
    "index.html"
}