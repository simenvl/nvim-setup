return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			-- "onsails/lspkind-nvim",
			"hrsh7th/cmp-cmdline",
			"dmitmel/cmp-cmdline-history",
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local neogen = require("neogen")
			local icons = require("config.icons")
			local compare = require("cmp.config.compare")

			local border_opts = {
				border = "single",
				winhighlight = "Normal:Normal,FloatBorder:BorderBg,CursorLine:Visual,Search:None",
			}

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Git
			-- require("cmp_git").setup({ filetypes = { "NeogitCommitMessage" } })

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						compare.score,
						compare.recently_used,
						compare.offset,
						compare.exact,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
				window = {
					completion = cmp.config.window.bordered(border_opts),
					documentation = cmp.config.window.bordered(border_opts),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping({
						i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
						c = function(fallback)
							if cmp.visible() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
					}),
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif neogen.jumpable() then
							neogen.jump_next()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, {
						"i",
						"s",
						"c",
					}),
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						elseif neogen.jumpable(true) then
							neogen.jump_prev()
						else
							fallback()
						end
					end, {
						"i",
						"s",
						"c",
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
				}),
				formatting = {
					-- fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						local max_width = 0
						local duplicates = {
							buffer = 1,
							path = 1,
							nvim_lsp = 0,
							luasnip = 1,
						}
						local duplicates_default = 0
						if max_width ~= 0 and #item.abbr > max_width then
							item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
						end
						item.kind = icons.kinds[item.kind]
						item.dup = duplicates[entry.source.name] or duplicates_default
						-- return require("tailwindcss-colorizer-cmp").formatter(entry, item)
						return item
					end,
				},
			}
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			{
				"honza/vim-snippets",
				config = function()
					require("luasnip.loaders.from_snipmate").lazy_load()

					-- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
					-- are stored in `ls.snippets._`.
					-- We need to tell luasnip that "_" contains global snippets:
					require("luasnip").filetype_extend("all", { "_" })
				end,
			},
		},
		build = "make install_jsregexp",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
    -- stylua: ignore
    keys = {
      {
        "<C-j>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-j>"
        end,
        expr = true,
        remap = true,
        silent = true,
        mode = "i",
      },
      { "<C-j>", function() require("luasnip").jump(1) end,  mode = "s" },
      { "<C-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
		config = function(_, opts)
			require("luasnip").setup(opts)

			local snippets_folder = vim.fn.stdpath("config") .. "/lua/plugins/completion/snippets/"
			require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_folder })

			vim.api.nvim_create_user_command("LuaSnipEdit", function()
				require("luasnip.loaders.from_lua").edit_snippet_files()
			end, {})
		end,
	},
}
-- opts = function()
-- 	local cmp = require("cmp")
--
-- 	-- vim.cmd("highlight! BorderBG guibg=NONE guifg=#ebbcba")
--
-- 	local border_opts = {
-- 		border = "single",
-- 		winhighlight = "Normal:Normal,FloatBorder:BorderBg,CursorLine:Visual,Search:None",
-- 	}
--
-- 	return {
-- 		completion = {
-- 			completeopt = "menu,menuone,noinsert",
-- 		},
--
-- 		snippet = {
-- 			expand = function(args)
-- 				require("luasnip").lsp_expand(args.body)
-- 			end,
-- 		},
--
-- 		window = {
-- 			completion = cmp.config.window.bordered(border_opts),
-- 			documentation = cmp.config.window.bordered(border_opts),
-- 		},
--
-- 		enabled = function()
-- 			-- disable completion in comments
-- 			local context = require("cmp.config.context")
-- 			-- keep command mode completion enabled when cursor is in a comment
-- 			if vim.api.nvim_get_mode().mode == "c" and not vim.bo.buftype == "prompt" then
-- 				return true
-- 			else
-- 				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
-- 			end
-- 		end,
--
-- 		mapping = cmp.mapping.preset.insert({
-- 			["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
-- 			["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
-- 			["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 			["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 			["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
-- 			["<C-e>"] = cmp.mapping.abort(), -- close completion window
-- 			["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 		}),
--
-- 		sources = cmp.config.sources({
-- 			{ name = "nvim_lsp" },
-- 			{ name = "luasnip" },
-- 			{ name = "buffer" },
-- 			{ name = "nvim_lua" },
-- 			{ name = "path" },
-- 		}),
--
-- 		formatting = {
-- 			format = function(entry, item)
-- 				local icons = require("config.icons").icons.kinds
--
-- 				if icons[item.kind] then
-- 					item.kind = icons[item.kind] .. item.kind
-- 				end
--
-- 				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
-- 			end,
-- 		},
--
-- 		experimental = {
-- 			ghost_text = false,
-- 		},
--
-- 		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- 		cmp.setup.cmdline({ "/", "?" }, {
-- 			mapping = cmp.mapping.preset.cmdline(),
-- 			sources = {
-- 				{ name = "buffer" },
-- 			},
-- 		}),
--
-- 		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- 		cmp.setup.cmdline(":", {
-- 			mapping = cmp.mapping.preset.cmdline(),
-- 			sources = cmp.config.sources({
-- 				{ name = "path" },
-- 			}, {
-- 				{ name = "cmdline" },
-- 			}),
-- 		}),
-- 	}
-- end,
