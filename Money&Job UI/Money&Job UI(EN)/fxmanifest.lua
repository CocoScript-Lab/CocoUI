fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

author 'coco the kid'
description 'money Job UI Script'
version '1.1.0'

ui_page 'html/index.html'

client_scripts {
    'lua/config.lua',
    'lua/client.lua'
}

server_scripts {
    'lua/server.lua'
}

files {
    'html/index.html',
    'html/styles.css',
    'html/image/**/*.png'
}
