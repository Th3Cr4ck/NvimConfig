return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- Soruce for text snippets 
		"hrsh7th/cmp-path",	-- source for file system paths 
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion 
		"rafamadriz/friendly-snippets", -- usefule snippets 
	},
	config = function()
		local cmp = require ("cmp")
		local luasnip = require ("luasnip")

		-- loads vscode style snippets from installed plugins (e.g friendly-snippets)
		require ("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- Configure how nvim-cm interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Sapce>"] = cmp.mapping.complete(), -- Show completion suggetions
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({select = false}),
			}),
			-- Sources for autocompletion
			sources = cmp.config.sources({
				{name = "nvim_lsp"},
				{name = "luasnip"}, --snippets 
				{name = "buffer"}, -- text within current buffer 
				{name = "path"}, --file system paths
			}),
		})
	end

}
