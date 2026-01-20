-- Automata Night Theme (ported from Helix)
-- Based on your custom Helix theme at ~/.config/helix/themes/automata_night.toml

local colors = {
  black = "#1A1313",
  light_black = "#30231E",
  red = "#B34750",
  light_red = "#D94B43",
  green = "#6B997B",
  light_green = "#77D989",
  yellow = "#EBA123",
  light_yellow = "#FFCA80",
  caramel = "#CC7E39",
  blue = "#7A97CC",
  light_blue = "#61B8F2",
  purple = "#9E7ACC",
  light_purple = "#CC6A84",
  aqua = "#4CD6D9",
  light_aqua = "#8DCBCC",
  white = "#E0DBC1",
  light_white = "#FAF4DE",
  bright_white = "#E6DFC3",
  whitespace = "#918E82",
  cursor_line = "#5C3016",
}

local M = {}

M.setup = function()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "automata_night"

  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Editor
  hl("Normal", { fg = colors.white, bg = colors.black })
  hl("NormalFloat", { fg = colors.white, bg = colors.black })
  hl("FloatBorder", { fg = colors.light_green, bg = colors.black })
  hl("ColorColumn", { bg = colors.light_black })
  hl("Cursor", { fg = colors.black, bg = colors.white })
  hl("CursorLine", { bg = colors.cursor_line })
  hl("CursorLineNr", { fg = colors.light_white, bg = colors.caramel, bold = true })
  hl("LineNr", { fg = colors.light_green, bg = colors.light_black })
  hl("SignColumn", { fg = colors.light_green, bg = colors.light_black })
  hl("Visual", { bg = colors.whitespace })
  hl("VisualNOS", { bg = colors.whitespace })

  -- Statusline
  hl("StatusLine", { fg = colors.black, bg = colors.caramel, bold = true })
  hl("StatusLineNC", { fg = colors.white, bg = colors.light_black })

  -- Tabs/Buffers
  hl("TabLine", { fg = colors.white, bg = colors.light_black })
  hl("TabLineFill", { bg = colors.light_black })
  hl("TabLineSel", { fg = colors.black, bg = colors.caramel, bold = true })

  -- Windows
  hl("VertSplit", { fg = colors.light_black })
  hl("WinSeparator", { fg = colors.light_black })

  -- Search
  hl("Search", { fg = colors.black, bg = colors.yellow })
  hl("IncSearch", { fg = colors.black, bg = colors.light_yellow })
  hl("CursorIM", { fg = colors.black, bg = colors.light_white })

  -- Syntax (Treesitter)
  hl("@variable", { fg = colors.white })
  hl("@variable.builtin", { fg = colors.light_yellow })
  hl("@variable.parameter", { fg = colors.light_yellow })
  hl("@variable.member", { fg = colors.light_yellow })
  hl("@constant", { fg = colors.light_yellow })
  hl("@constant.builtin", { fg = colors.light_green })
  hl("@constant.numeric", { fg = colors.yellow, bold = true })
  hl("@string", { fg = colors.light_aqua })
  hl("@string.escape", { fg = colors.light_green })
  hl("@string.special", { fg = colors.light_green })
  hl("@character", { fg = colors.light_yellow })
  hl("@boolean", { fg = colors.light_yellow })
  hl("@number", { fg = colors.yellow, bold = true })
  hl("@float", { fg = colors.yellow })

  hl("@function", { fg = colors.caramel })
  hl("@function.builtin", { fg = colors.light_blue })
  hl("@function.macro", { fg = colors.light_blue })
  hl("@function.method", { fg = colors.caramel })
  hl("@constructor", { fg = colors.yellow })
  hl("@keyword", { fg = colors.light_green })
  hl("@keyword.operator", { fg = colors.light_red })
  hl("@keyword.return", { fg = colors.white })
  hl("@keyword.function", { fg = colors.light_green })
  hl("@keyword.import", { fg = colors.light_red })
  hl("@keyword.storage", { fg = colors.blue })
  hl("@conditional", { fg = colors.white })
  hl("@repeat", { fg = colors.white })
  hl("@label", { fg = colors.blue })
  hl("@operator", { fg = colors.light_white })
  hl("@type", { fg = colors.yellow })
  hl("@type.builtin", { fg = colors.yellow })
  hl("@namespace", { fg = colors.blue })
  hl("@attribute", { fg = colors.yellow })
  hl("@property", { fg = colors.light_yellow })
  hl("@tag", { fg = colors.light_yellow })
  hl("@tag.attribute", { fg = colors.yellow })
  hl("@tag.delimiter", { fg = colors.light_white })

  -- Comments
  hl("Comment", { fg = colors.whitespace, italic = true })
  hl("@comment", { fg = colors.whitespace, italic = true })

  -- Diagnostics
  hl("DiagnosticError", { fg = colors.light_red, bold = true })
  hl("DiagnosticWarn", { fg = colors.yellow, bold = true })
  hl("DiagnosticInfo", { fg = colors.blue, bold = true })
  hl("DiagnosticHint", { fg = colors.green, bold = true })
  hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
  hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.yellow })
  hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.blue })
  hl("DiagnosticUnderlineHint", { undercurl = true, sp = colors.green })

  -- Git
  hl("DiffAdd", { fg = colors.light_green })
  hl("DiffChange", { fg = colors.light_purple })
  hl("DiffDelete", { fg = colors.light_red })
  hl("DiffText", { fg = colors.light_blue })

  -- Completion Menu
  hl("Pmenu", { fg = colors.white, bg = colors.light_black })
  hl("PmenuSel", { fg = colors.blue, bg = colors.yellow })
  hl("PmenuSbar", { bg = colors.light_black })
  hl("PmenuThumb", { bg = colors.blue })

  -- Telescope
  hl("TelescopeBorder", { fg = colors.light_green })
  hl("TelescopePromptBorder", { fg = colors.light_yellow })
  hl("TelescopeResultsBorder", { fg = colors.light_green })
  hl("TelescopePreviewBorder", { fg = colors.light_green })
  hl("TelescopeSelection", { fg = colors.blue, bg = colors.yellow })
  hl("TelescopeMatching", { fg = colors.light_yellow, bold = true })

  -- WhichKey
  hl("WhichKey", { fg = colors.light_yellow })
  hl("WhichKeyGroup", { fg = colors.light_green })
  hl("WhichKeyDesc", { fg = colors.white })
  hl("WhichKeySeparator", { fg = colors.whitespace })
  hl("WhichKeyFloat", { bg = colors.black })

  -- Neo-tree
  hl("NeoTreeNormal", { fg = colors.white, bg = colors.light_black })
  hl("NeoTreeNormalNC", { fg = colors.white, bg = colors.light_black })
  hl("NeoTreeDirectoryIcon", { fg = colors.light_blue })
  hl("NeoTreeDirectoryName", { fg = colors.light_blue })
  hl("NeoTreeFileName", { fg = colors.white })
  hl("NeoTreeFileNameOpened", { fg = colors.light_yellow })
  hl("NeoTreeGitModified", { fg = colors.light_purple })
  hl("NeoTreeGitAdded", { fg = colors.light_green })
  hl("NeoTreeGitDeleted", { fg = colors.light_red })

  -- Indent guides
  hl("IndentBlanklineChar", { fg = colors.light_black })
  hl("IndentBlanklineContextChar", { fg = colors.whitespace })

  -- GitSigns
  hl("GitSignsAdd", { fg = colors.light_green })
  hl("GitSignsChange", { fg = colors.light_purple })
  hl("GitSignsDelete", { fg = colors.light_red })
end

return M
