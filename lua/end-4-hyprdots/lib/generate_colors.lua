local blend = require("end-4-hyprdots.utils.colors").blend
local decode = require("end-4-hyprdots.utils.json").decode
local hash = require("end-4-hyprdots.lib.hashing").hash

local join = vim.fs.joinpath
local isdir = vim.fn.isdirectory
local isfile = vim.fn.filereadable

local home = vim.env.HOME or os.getenv "HOME"

local xdg_state_home = os.getenv "XDG_STATE_HOME" or join(home, ".local", "state")
local xdg_config_home = os.getenv "XDG_CONFIG_HOME" or join(home, ".config")

local config_path = join(xdg_config_home, "illogical-impulse", "config.json")
local config_file = io.open(config_path)
if not config_file then
	vim.notify(
		"end-4-hyprdots theme cannot load: "
			.. string.format("illogical-impulse config file '%s' does not exist.", config_path),
		vim.diagnostic.ERROR
	)
	return
end

local config = decode(config_file:read "*a")
config_file:close()

local scheme = config.appearance.palette.type
local bg_path = config.background.wallpaperPath
local termscheme = join(xdg_config_home, "quickshell", "ii", "scripts", "colors", "terminal", "scheme-base.json")
local colorgen_cache = join(xdg_state_home, "quickshell", "user", "generated", "color.txt")
local colorgen_script = join(xdg_config_home, "quickshell", "ii", "scripts", "colors", "generate_colors_material.py")

-- It takes about half a second to load the material colors from the python script.
-- Since it only depends on the background image and the illogical-impulse scheme,
-- the results are not queried if these settings did not change.
-- The actual colors are also stored by catppuccin's compilation routine. Storing
-- them again is redundant, but it was the easiest way to program it.
local cache_path = join(require("end-4-hyprdots").options.compile_path, "illogical-impulse-params")
local f = loadfile(cache_path)

-- Check if the stored and current values are equal and return the stored palettes if so.
local hash = hash { scheme, bg_path }
if f then
	local stored_vals = f()
	if stored_vals[1] == hash then return stored_vals[2] end
end

---@param mode "light" | "dark"
---@return table
local function get_palette(mode)
	local src = vim.system({
		"python3",
		colorgen_script,
		"--path",
		bg_path,
		"--mode",
		mode,
		"--scheme",
		scheme,
		"--termscheme",
		termscheme,
		"--blend_bg_fg",
		"--cache",
		colorgen_cache,
	}, { text = true }):wait()

	local colors = {}

	if src.code ~= 0 then
		vim.notify(
			"end-4-hyprdots theme cannot load: "
				.. string.format(
					[[failed to generate the palette of flavour '%s'.
STDERR: %s]],
					mode,
					src.stderr
				),
			vim.diagnostic.severity.ERROR
		)
		return {}
	end

	for color in src.stdout:gmatch "[^\n]+" do
		local name, hex = color:match "%$([%w_%-]+):%s*([^%s]+);$"
		colors[name] = hex
	end

	local dark_mode = mode == "dark"

	local steps = 5 -- number of colors = steps + 1
	local gradient = {}

	local bright_surface = colors["outline"]
	local dark_surface = colors["surfaceContainerHighest"]

	for step = 0, steps do
		local alpha = 1.0 - step / steps
		gradient[step + 1] = blend(bright_surface, dark_surface, alpha)
	end

	return {
		flamingo = dark_mode and "#f0c6c6" or "#dd7878",
		rosewater = dark_mode and "#f4dbd6" or "#dc8a78",
		pink = colors["term5"],
		mauve = colors["term13"],
		red = colors["term1"],
		maroon = colors["term9"],
		peach = colors["term3"],
		yellow = colors["term11"],
		green = colors["term2"],
		teal = colors["term10"],
		sky = colors["term6"],
		sapphire = colors["term14"],
		blue = colors["term4"],
		lavender = colors["term12"],
		text = colors["term7"],
		subtext1 = colors["onSurface"],
		subtext0 = colors["onSurfaceVariant"],
		overlay2 = gradient[1],
		overlay1 = gradient[2],
		overlay0 = gradient[3],
		surface2 = gradient[4],
		surface1 = gradient[5],
		surface0 = gradient[6],
		base = colors["term0"],
		mantle = colors["surfaceContainerLow"],
		crust = colors["surfaceContainerLowest"],
	}
end

local palettes = { dark = get_palette "dark", light = get_palette "light" }

-- Else, save the params for the next load. string.dump hardcodes its content as a string,
-- without compiling it (key_str would be stored as 'key_str'). loadstring bypasses this
-- by evaluating its input as lua code.
local bin = string.dump(assert(loadstring(string.format("return %s", vim.inspect { hash, palettes }))))

local cache_file = assert(
	io.open(cache_path, "wb"),
	"end-4-hyprdots theme cannot load: failed to open illogical-impulse params cache file '" .. cache_path .. "'."
)
cache_file:write(bin)
cache_file:close()

return palettes
