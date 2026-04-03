-- Load core settings
require("core.options")
require("core.keymaps")

-- Load theme (before plugins so colours are ready on startup)
require("themes.automata_night").load()

-- Load plugins via Lazy.nvim
require("plugins")
