resource_type 'gametype' { name = 'Advanced RP' }

-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

-- Config
server_script 'config/jobs.lua'
client_script 'config/jobs.lua'
client_script 'config/config.lua'
server_script 'config/config.lua'

-- General
client_script 'cl_roleplay.lua'
server_script 'sv_roleplay.lua'

-- Roleplay area
server_script 'server/roleplay_area.lua'
client_script 'client/roleplay_area.lua'

-- Jobs
server_script 'server/jobs.lua'
client_script 'client/jobs.lua'
server_script 'server/jobs/police.lua'
client_script 'client/jobs/police.lua'