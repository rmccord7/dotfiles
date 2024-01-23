require('global')

local config = require('config')

require('settings')
require('ac')
require('mappings')

-- Start lazy
config.lazy.start()

-- Load project config if it exists.
require('project')
