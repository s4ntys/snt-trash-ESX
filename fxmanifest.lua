fx_version 'cerulean'
game 'gta5'

author 'SanTy'
description 'Trash system esx ! '
version '1.0.1'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'es_extended/locale.lua',
    'webhooks.lua',
    'server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
}

ui_page 'html/index.html'

dependencies {
    'es_extended',
    'ox_inventory',
    'ox_target'
}