-- Make utils module to be globally accessible by "DTF" name.
-- Effectively it make DTF a global variable in Lua execution environment.
_G.DTF = require('config.utils')

require('config.options')
require('config.keymaps')
require('config.lazy')
