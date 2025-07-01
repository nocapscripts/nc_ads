fx_version ('cerulean')

lua54 ('yes')

author ('CivDev')

description ('Ads system for FiveM Servers')

version ('2.6.8')

game ('gta5')

shared_scripts ({
    '@ox_lib/init.lua',
    'config.lua'
})

client_scripts ({'client/**/*.lua'})
server_scripts ({'server/bridge/*.lua'})


ui_page({'public/index.html'})

files({
 
    'public/**',
})

escrow_ignore ({
    'config.lua'
})