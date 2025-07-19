local function report_error(msg) vim.notify("end-4-hyprdots theme cannot load: " .. msg, vim.diagnostic.severity.ERROR) end
local blend = require("end-4-hyprdots.utils.colors").blend

local join = vim.fs.joinpath
local isdir = vim.fn.isdirectory
local isfile = vim.fn.filereadable

local home = vim.env.HOME or os.getenv "HOME"

local xdg_state_home = os.getenv "XDG_STATE_HOME" or join(home, ".local", "state")

if not isdir(xdg_state_home) then
	report_error(string.format("State directory '%s' does not exist.", xdg_state_home))
	return
end

local colors_path = join(xdg_state_home, "quickshell", "user", "generated", "material_colors.scss")
if not isfile(colors_path) then
	report_error(string.format("Colors file '%s' does not exist.", colors_path))
	return
end

local colors = {}

for color in io.lines(colors_path) do
	color = tostring(color)
	local name, hex = color:match "%$([%w_%-]+):%s*([^%s]+);$"
	colors[name] = hex
end

local dark_mode = colors.darkmode == "True"

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
	text = colors["onBackground"],
	subtext1 = colors["onSurface"],
	subtext0 = colors["onSurfaceVariant"],
	overlay2 = gradient[1],
	overlay1 = gradient[2],
	overlay0 = gradient[3],
	surface2 = gradient[4],
	surface1 = gradient[5],
	surface0 = gradient[6],
	base = colors["background"],
	mantle = colors["surfaceContainerLow"],
	crust = colors["surfaceContainerLowest"],
},
	dark_mode and "dark" or "light"
