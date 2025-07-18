local function reload()
	for name, _ in pairs(package.loaded) do
		if name:match "^end%-4%-hyprdots" then package.loaded[name] = nil end
	end
	vim.cmd [[highlight clear]]
end

describe("change colorscheme to", function()
	before_each(function() reload() end)
	it("end-4-hyprdots", function()
		vim.cmd.colorscheme "end-4-hyprdots"
		assert.equals("end-4-hyprdots", vim.g.colors_name)
	end)
end)
