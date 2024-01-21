require('global')

local config = require('config')

require('settings')
require('mappings')
require('autocommands')

-- Start lazy
config.lazy.start()

-- Load project config if it exists.
require('project')
