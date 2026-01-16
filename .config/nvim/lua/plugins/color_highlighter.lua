-- #333
-- #33ff50
-- rgb(12,12,12)

local opts_colorizer = {
  user_default_options = {
    css = true,
    css_fn = true,
    names_opts = {
      uppercase = true, -- name:upper(), highlight `BLUE` and `RED`
    },
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    rgb_fn = true,   -- CSS rgb() and rgba() functions
    hsl_fn = true,   -- CSS hsl() and hsla() functions
  },
}

return {
  {
    "uga-rosa/ccc.nvim",
    opts = {},
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = opts_colorizer,
  },
}
