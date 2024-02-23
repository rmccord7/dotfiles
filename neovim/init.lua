require('rm.global')

local config = require('rm.config')

require('rm.settings')
require('rm.auto')
require('rm.mappings')

-- Start lazy
config.lazy.start()
