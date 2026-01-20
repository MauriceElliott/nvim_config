-- Automata Day Theme (ported from Helix)
-- Based on your custom Helix theme at ~/.config/helix/themes/automata_day.toml

local colors = {
  black = "#1F1E1E",
  light_black = "#33251F",
  red = "#52212C",
  light_red = "#732127",
  green = "#1B3B26",
  light_green = "#406647",
  yellow = "#B67F21",
  light_yellow = "#ADAD39",
  blue = "#3A4A67",
  light_blue = "#466A82",
  purple = "#5B437A",
  light_purple = "#8C485A",
  aqua = "#3D6B6B",
  light_aqua = "#2B797A",
  white = "#CDC8B0",
  light_white = "#EBE6D2",
  bright_white = "#DAD4BA",
  whitespace = "#918E82",
  cursor_line = "#D6A45D",
}

local M = {}

M.setup = function()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "automata_day"

  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Editor
  hl("Normal", { fg = colors.black, bg = colors.bright_white })
  hl("NormalFloat", { fg = colors.black, bg = colors.white })
  hl("FloatBorder", { fg = colors.green, bg = colors.white })
  hl("ColorColumn", { bg = colors.white })
  hl("Cursor", { fg = colors.light_black, reverse = true })
  hl("CursorLine", { bg = colors.cursor_line })
  hl("CursorLineNr", { fg = colors.light_white, bg = colors.yellow, bold = true })
  hl("LineNr", { fg = colors.green, bg = colors.white })
  hl("SignColumn", { fg = colors.green, bg = colors.white })
  hl("Visual", { bg = colors.light_white })
  hl("VisualNOS", { bg = colors.light_white })

  -- Statusline
  hl("StatusLine", { fg = colors.light_white, bg = colors.light_red })
  hl("StatusLineNC", { fg = colors.black, bg = colors.white })

  -- Tabs/Buffers
  hl("TabLine", { fg = colors.black, bg = colors.white })
  hl("TabLineFill", { bg = colors.white })
  hl("TabLineSel", { fg = colors.light_white, bg = colors.yellow, bold = true })

  -- Windows
  hl("VertSplit", { fg = colors.white })
  hl("WinSeparator", { fg = colors.white })

  -- Search
  hl("Search", { fg = colors.black, bg = colors.white })
  hl("IncSearch", { fg = colors.black, bg = colors.light_white })
  hl("CursorIM", { fg = colors.light_black, reverse = true })

  -- Syntax (Treesitter)
  hl("@variable", { fg = colors.black })
  hl("@variable.builtin", { fg = colors.light_purple })
  hl("@variable.parameter", { fg = colors.light_purple })
  hl("@variable.member", { fg = colors.light_purple })
  hl("@constant", { fg = colors.light_green })
  hl("@constant.builtin", { fg = colors.light_green })
  hl("@constant.numeric", { fg = colors.yellow, bold = true })
  hl("@string", { fg = colors.light_green })
  hl("@string.escape", { fg = colors.light_green })
  hl("@string.special", { fg = colors.light_green })
  hl("@character", { fg = colors.light_green })
  hl("@boolean", { fg = colors.light_green })
  hl("@number", { fg = colors.yellow, bold = true })
  hl("@float", { fg = colors.yellow })

  hl("@function", { fg = colors.light_green })
  hl("@function.builtin", { fg = colors.light_blue })
  hl("@function.macro", { fg = colors.light_blue })
  hl("@function.method", { fg = colors.light_green })
  hl("@constructor", { fg = colors.light_blue })
  hl("@keyword", { fg = colors.light_aqua })
  hl("@keyword.operator", { fg = colors.red })
  hl("@keyword.return", { fg = colors.light_red })
  hl("@keyword.function", { fg = colors.light_aqua })
  hl("@keyword.import", { fg = colors.light_red })
  hl("@keyword.storage", { fg = colors.blue })
  hl("@conditional", { fg = colors.light_red })
  hl("@repeat", { fg = colors.light_red })
  hl("@label", { fg = colors.blue })
  hl("@operator", { fg = colors.blue })
  hl("@type", { fg = colors.purple })
  hl("@type.builtin", { fg = colors.purple })
  hl("@namespace", { fg = colors.blue })
  hl("@attribute", { fg = colors.light_blue })
  hl("@property", { fg = colors.light_purple })
  hl("@tag", { fg = colors.light_yellow })
  hl("@tag.attribute", { fg = colors.light_blue })
  hl("@tag.delimiter", { fg = colors.blue })

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
  hl("DiffAdd", { fg = colors.green })
  hl("DiffChange", { fg = colors.purple })
  hl("DiffDelete", { fg = colors.red })
  hl("DiffText", { fg = colors.light_blue })

  -- Completion Menu
  hl("Pmenu", { fg = colors.blue, bg = colors.white })
  hl("PmenuSel", { fg = colors.blue, bg = colors.yellow })
  hl("PmenuSbar", { bg = colors.light_white })
  hl("PmenuThumb", { bg = colors.blue })

  -- Telescope
  hl("TelescopeBorder", { fg = colors.green })
  hl("TelescopePromptBorder", { fg = colors.black })
  hl("TelescopeResultsBorder", { fg = colors.green })
  hl("TelescopePreviewBorder", { fg = colors.green })
  hl("TelescopeSelection", { fg = colors.blue, bg = colors.yellow })
  hl("TelescopeMatching", { fg = colors.light_yellow, bold = true })

  -- WhichKey
  hl("WhichKey", { fg = colors.light_yellow })
  hl("WhichKeyGroup", { fg = colors.light_green })
  hl("WhichKeyDesc", { fg = colors.black })
  hl("WhichKeySeparator", { fg = colors.whitespace })
  hl("WhichKeyFloat", { bg = colors.white })

  -- Neo-tree
  hl("NeoTreeNormal", { fg = colors.black, bg = colors.white })
  hl("NeoTreeNormalNC", { fg = colors.black, bg = colors.white })
  hl("NeoTreeDirectoryIcon", { fg = colors.light_blue })
  hl("NeoTreeDirectoryName", { fg = colors.light_blue })
  hl("NeoTreeFileName", { fg = colors.black })
  hl("NeoTreeFileNameOpened", { fg = colors.light_yellow })
  hl("NeoTreeGitModified", { fg = colors.purple })
  hl("NeoTreeGitAdded", { fg = colors.green })
  hl("NeoTreeGitDeleted", { fg = colors.red })

  -- Indent guides
  hl("IndentBlanklineChar", { fg = colors.light_black })
  hl("IndentBlanklineContextChar", { fg = colors.whitespace })

  -- GitSigns
  hl("GitSignsAdd", { fg = colors.green })
  hl("GitSignsChange", { fg = colors.purple })
  hl("GitSignsDelete", { fg = colors.red })
end

return M
