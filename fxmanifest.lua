fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'The Land of Wolves'
description 'Server-side Visual Effects System for RedM - Professional-grade graphics enhancement with advanced configuration'
version '2.0.0'

-- Server scripts
server_scripts {
    'config.lua',
    'server/server.lua'
}

-- Client scripts
client_scripts {
    'config.lua',
    'client/client.lua'
}

-- Metadata
lua54 'yes'
