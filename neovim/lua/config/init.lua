local M = {
    debug = require('config.debug'),
    path = require('config.path'),
    apps = require('config.apps'),
    ft = require('config.ft'),
    lazy = require('config.lazy'),
}

-- If debug is enabled, then dump the config
if M.debug.enable then
  dump(M)
end

return M
