
-- Resource Metadata
fx_version 'cerulean'
game 'gta5' 

author 'PLOKMJNB#8692'
description 'A single resource car pack to eliminate the rest'
repository 'https://github.com/PLOKMJNB/FiveM-Civ-Car-Pack'

files {
    'data/**/*',
    "audioconfig/*.dat151.rel",
	"audioconfig/*.dat54.rel",
	"audioconfig/*.dat10.rel",
	"sfx/**/*.awc",
}


data_file 'HANDLING_FILE'            'data/**/handling*.meta'
data_file 'VEHICLE_LAYOUTS_FILE'    'data/**/vehiclelayouts*.meta'
data_file 'VEHICLE_METADATA_FILE'    'data/**/vehicles*.meta'
data_file 'CARCOLS_FILE'            'data/**/carcols*.meta'
data_file 'VEHICLE_VARIATION_FILE'    'data/**/carvariations*.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'data/**/*unlocks.meta'
data_file 'PTFXASSETINFO_FILE' 'data/**/ptfxassetinfo.meta'
--MOD SOM----------------------------------------------------------------
--bmws1krreng moto veloz
data_file "AUDIO_SYNTHDATA" "audioconfig/bmws1krreng_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/bmws1krreng_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/bmws1krreng_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_bmws1krreng"
--mt09eng moto veloz
data_file 'AUDIO_SYNTHDATA' 'audioconfig/mt09eng_amp.dat'
data_file 'AUDIO_GAMEDATA' 'audioconfig/mt09eng_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/mt09eng_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_mt09eng'
--918spyeng carro veloz grosso
data_file 'AUDIO_SYNTHDATA' 'audioconfig/918spyeng_amp.dat'
data_file 'AUDIO_GAMEDATA' 'audioconfig/918spyeng_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/918spyeng_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_918spyeng'
--lgcy00vr6 carro intermediario
data_file "AUDIO_SYNTHDATA" "audioconfig/lgcy00vr6_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lgcy00vr6_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lgcy00vr6_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lgcy00vr6"
--a80ffeng comum
data_file "AUDIO_SYNTHDATA" "audioconfig/a80ffeng_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/a80ffeng_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/a80ffeng_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_a80ffeng"
--lg14c6vette carro veloz fino
data_file "AUDIO_SYNTHDATA" "audioconfig/lg14c6vette_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg14c6vette_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg14c6vette_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg14c6vette"
data_file "AUDIO_SYNTHDATA" "audioconfig/lg14c6vettena_amp.dat"
data_file "AUDIO_GAMEDATA" "audioconfig/lg14c6vettena_game.dat"
data_file "AUDIO_SOUNDDATA" "audioconfig/lg14c6vettena_sounds.dat"
data_file "AUDIO_WAVEPACK" "sfx/dlc_lg14c6vettena"

client_scripts {
    'vehicle_names.lua',
}  