return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji", -- add cmp source as dependency of cmp
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- modify the sources part of the options table
    opts.sources = cmp.config.sources {
      { name = "copilot", priority = 1000 },
      { name = "nvim_lsp", priority = 900 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "emoji", priority = 700 }, -- add new source
    }
    opts.mapping["<C-space>"] = cmp.mapping.select_next_item()
    cmp.setup {
      mapping = {
        ["<M-;>"] = cmp.mapping(
          function(fallback)
            vim.api.nvim_feedkeys(
              vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)),
              "n",
              true
            )
          end
        ),
      },
    }
  end,
}
