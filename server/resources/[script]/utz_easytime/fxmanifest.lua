fx_version 'bodacious'
games { 'gta5' }


client_scripts {
    '@vrp/lib/utils.lua',
	'config.lua',
    'client/*.lua',
}

server_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'server/*.lua',
}

ui_page {
    'html/index.html',
}
files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/font/*.svg',
    'html/font/*.ttf',
    'html/font/*.eot',
    'html/font/*.woff',
    'html/font/*.woff2',
    'html/images/**/*.svg',
}
