return function(flavour)
	local C = require("end-4-hyprdots.palettes").get_palette(flavour)
	local O = require("end-4-hyprdots").options
	local end4hyprdots = {}

	local transparent_bg = O.transparent_background and "NONE" or C.mantle

	end4hyprdots.normal = {
		a = { bg = C.blue, fg = C.mantle, gui = "bold" },
		b = { bg = C.surface0, fg = C.blue },
		c = { bg = transparent_bg, fg = C.text },
	}

	end4hyprdots.insert = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
	}

	end4hyprdots.terminal = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
	}

	end4hyprdots.command = {
		a = { bg = C.peach, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.peach },
	}

	end4hyprdots.visual = {
		a = { bg = C.mauve, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.mauve },
	}

	end4hyprdots.replace = {
		a = { bg = C.red, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.red },
	}

	end4hyprdots.inactive = {
		a = { bg = transparent_bg, fg = C.blue },
		b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
		c = { bg = transparent_bg, fg = C.overlay0 },
	}

	return end4hyprdots
end
