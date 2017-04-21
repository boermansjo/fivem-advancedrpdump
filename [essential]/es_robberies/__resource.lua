-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

-- Banks
client_script 'client/bank.lua'
server_script 'server/bank.lua'

-- Stores
client_script 'client/holdup.lua'
server_script 'server/holdup.lua'