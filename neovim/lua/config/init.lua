local M = {
    apps = require('config.apps'),
    debug = require('config.debug'),
    ft = require('config.ft'),
    lazy = require('config.lazy'),
    path = require('config.path'),
}

-- If debug is enabled, then dump the config
if M.debug.enable then
  dump(M)
end

return M
