fx_version "adamant"
game "gta5"
ui_page "web-side/index.html" 
ui_page_preload "yes" 

server_scripts {
    "cfg/sv_func.lua",
} 

client_scripts {
    "cfg/cl_func.lua",
} 

files {
    "web-side/*",
    "web-side/**/*",
    "web-side/**/**/*"
} 

shared_scripts {
    "@vrp/lib/utils.lua",
    "cfg/config.lua",
} 

server_script "_server.lua"

client_script "_client.lua"