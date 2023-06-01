fx_version 'adamant'

game 'gta5'

lua54 'yes'

description 'npc doctor'

version '1.0.0'

client_script {
    'client/client.lua'
}

server_script {
    'server/server.lua'
}

shared_script {
    'config/config.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

dependencies {
  'ox_lib',
  'ox_inventory' 
}

escrow_ignore {
    'config.lua'
}