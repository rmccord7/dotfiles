require('rm.global')

local M = {
    apps = require('rm.config.apps'),
    debug = require('rm.config.debug'),
    ft = require('rm.config.ft'),
    lazy = require('rm.config.lazy'),
    path = require('rm.config.path'),
}

-- If debug is enabled, then dump the config
if M.debug.enable then
  dump(M)
end

return M
