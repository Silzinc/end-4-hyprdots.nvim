local palette = require("end-4-hyprdots.palettes").get_palette "light"
local presets = require "end-4-hyprdots.utils.reactive"

local preset = presets.cursor("end-4-hyprdots-light-cursor", palette)

preset.modes.R.hl.ReactiveCursor = { bg = palette.flamingo }

return preset
