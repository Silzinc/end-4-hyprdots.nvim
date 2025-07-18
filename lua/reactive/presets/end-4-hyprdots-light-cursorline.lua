local lighten = require("end-4-hyprdots.utils.colors").lighten
local palette = require("end-4-hyprdots.palettes").get_palette "light"

return {
	name = "end-4-hyprdots-light-cursorline",
	static = {
		winhl = {
			inactive = {
				CursorLine = { bg = lighten(palette.surface0, 0.5) },
				CursorLineNr = { bg = lighten(palette.surface0, 0.5) },
			},
		},
	},
	modes = {
		i = {
			winhl = {
				CursorLine = { bg = lighten(palette.teal, 0.4) },
				CursorLineNr = { bg = lighten(palette.teal, 0.4) },
			},
		},
		n = {
			winhl = {
				CursorLine = { bg = palette.surface0 },
				CursorLineNr = { bg = palette.surface0 },
			},
		},
		no = {
			operators = {
				[{ "gu", "gU", "g~", "~" }] = {
					winhl = {
						CursorLine = { bg = palette.surface2 },
						CursorLineNr = { bg = palette.surface2 },
					},
				},
				-- delete operator
				d = {
					winhl = {
						CursorLine = { bg = lighten(palette.red, 0.3) },
						CursorLineNr = { bg = lighten(palette.red, 0.3) },
					},
				},
				-- yank operator
				y = {
					winhl = {
						CursorLine = { bg = lighten(palette.peach, 0.3) },
						CursorLineNr = { bg = lighten(palette.peach, 0.3) },
					},
				},
				-- change operator
				c = {
					winhl = {
						CursorLine = { bg = lighten(palette.blue, 0.3) },
						CursorLineNr = { bg = lighten(palette.blue, 0.3) },
					},
				},
			},
		},
		-- visual
		[{ "v", "V", "\x16" }] = {
			winhl = {
				Visual = { bg = lighten(palette.mauve, 0.3) },
			},
		},
		-- select
		[{ "s", "S", "\x13" }] = {
			winhl = {
				Visual = { bg = lighten(palette.pink, 0.3) },
			},
		},
		R = {
			winhl = {
				CursorLine = { bg = lighten(palette.flamingo, 0.2) },
				CursorLineNr = { bg = lighten(palette.flamingo, 0.2) },
			},
		},
	},
}
