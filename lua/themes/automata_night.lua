-- automata_night colorscheme
-- Migrated from Helix automata_night.toml

local M = {}

M.palette = {
  black        = "#1A1313",
  light_black  = "#30231E",
  red          = "#B34750",
  light_red    = "#D94B43",
  green        = "#6B997B",
  light_green  = "#77D989",
  yellow       = "#EBA123",
  light_yellow = "#FFCA80",
  caramel      = "#CC7E39",
  blue         = "#7A97CC",
  light_blue   = "#61B8F2",
  purple       = "#9E7ACC",
  light_purple = "#CC6A84",
  aqua         = "#4CD6D9",
  light_aqua   = "#8DCBCC",
  white        = "#E0DBC1",
  light_white  = "#FAF4DE",
  bright_white = "#E6DFC3",
  whitespace   = "#918E82",
  cursor_line  = "#5C3016",
  none         = "NONE",
}

function M.load()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "automata_night"

  local p = M.palette
  local hl = vim.api.nvim_set_hl

  -- ── Editor UI ──────────────────────────────────────────────────────────
  hl(0, "Normal",         { fg = p.white,       bg = p.black })
  hl(0, "NormalFloat",    { fg = p.white,       bg = p.black })
  hl(0, "FloatBorder",    { fg = p.white,       bg = p.black })
  hl(0, "NormalNC",       { fg = p.white,       bg = p.black })

  hl(0, "CursorLine",     { fg = p.white,       bg = p.cursor_line })
  hl(0, "CursorColumn",   { bg = p.cursor_line })
  hl(0, "ColorColumn",    { bg = p.whitespace })

  hl(0, "LineNr",         { fg = p.light_green, bg = p.light_black })
  hl(0, "CursorLineNr",   { fg = p.light_white, bg = p.caramel,     bold = true })
  hl(0, "SignColumn",     { fg = p.light_green, bg = p.light_black })

  hl(0, "Cursor",         { fg = p.black,       bg = p.white })
  hl(0, "CursorInsert",   { fg = p.black,       bg = p.light_white })
  hl(0, "TermCursor",     { fg = p.black,       bg = p.white })

  hl(0, "Visual",         { bg = p.whitespace })
  hl(0, "VisualNOS",      { bg = p.whitespace })

  hl(0, "StatusLine",     { fg = p.black,       bg = p.caramel,     bold = true })
  hl(0, "StatusLineNC",   { fg = p.whitespace,  bg = p.light_black })
  hl(0, "WinSeparator",   { fg = p.white,       bg = p.black })

  hl(0, "Pmenu",          { fg = p.light_green, bg = p.light_black })
  hl(0, "PmenuSel",       { fg = p.blue,        bg = p.yellow })
  hl(0, "PmenuSbar",      { bg = p.light_black })
  hl(0, "PmenuThumb",     { bg = p.blue })

  hl(0, "TabLine",        { fg = p.white,       bg = p.light_black })
  hl(0, "TabLineSel",     { fg = p.black,       bg = p.caramel })
  hl(0, "TabLineFill",    { bg = p.light_black })

  hl(0, "Search",         { fg = p.black,       bg = p.yellow })
  hl(0, "IncSearch",      { fg = p.black,       bg = p.light_yellow })
  hl(0, "CurSearch",      { fg = p.black,       bg = p.light_yellow })

  hl(0, "MatchParen",     { fg = p.black,       bg = p.yellow })

  hl(0, "Folded",         { fg = p.whitespace,  bg = p.light_black })
  hl(0, "FoldColumn",     { fg = p.whitespace,  bg = p.light_black })

  hl(0, "NonText",        { fg = p.whitespace })
  hl(0, "Whitespace",     { fg = p.whitespace })
  hl(0, "SpecialKey",     { fg = p.whitespace })
  hl(0, "EndOfBuffer",    { fg = p.light_black })

  hl(0, "Directory",      { fg = p.light_blue })
  hl(0, "Title",          { fg = p.light_red,   bold = true })

  hl(0, "WildMenu",       { fg = p.blue,        bg = p.yellow })
  hl(0, "Question",       { fg = p.light_green })
  hl(0, "MoreMsg",        { fg = p.light_green })
  hl(0, "ModeMsg",        { fg = p.white,       bold = true })
  hl(0, "ErrorMsg",       { fg = p.light_red,   bold = true })
  hl(0, "WarningMsg",     { fg = p.yellow,      bold = true })

  -- ── Diff ───────────────────────────────────────────────────────────────
  hl(0, "DiffAdd",        { fg = p.light_green })
  hl(0, "DiffChange",     { fg = p.light_purple })
  hl(0, "DiffDelete",     { fg = p.light_red })
  hl(0, "DiffText",       { fg = p.light_purple, bold = true })

  -- ── Diagnostics ────────────────────────────────────────────────────────
  hl(0, "DiagnosticError",            { fg = p.light_red,  bold = true })
  hl(0, "DiagnosticWarn",             { fg = p.yellow,     bold = true })
  hl(0, "DiagnosticInfo",             { fg = p.blue,       bold = true })
  hl(0, "DiagnosticHint",             { fg = p.green,      bold = true })
  hl(0, "DiagnosticUnnecessary",      { fg = p.whitespace })
  hl(0, "DiagnosticDeprecated",       { strikethrough = true })
  hl(0, "DiagnosticUnderlineError",   { sp = p.light_red,  undercurl = true })
  hl(0, "DiagnosticUnderlineWarn",    { sp = p.yellow,     undercurl = true })
  hl(0, "DiagnosticUnderlineInfo",    { sp = p.blue,       undercurl = true })
  hl(0, "DiagnosticUnderlineHint",    { sp = p.green,      undercurl = true })

  -- ── Syntax (legacy + Treesitter) ───────────────────────────────────────
  hl(0, "Comment",        { fg = p.whitespace })
  hl(0, "Constant",       { fg = p.light_yellow })
  hl(0, "Number",         { fg = p.yellow,      bold = true })
  hl(0, "Float",          { fg = p.yellow,      bold = true })
  hl(0, "Boolean",        { fg = p.light_green })
  hl(0, "Character",      { fg = p.light_yellow })
  hl(0, "String",         { fg = p.light_aqua })

  hl(0, "Identifier",     { fg = p.light_yellow })
  hl(0, "Function",       { fg = p.caramel })

  hl(0, "Statement",      { fg = p.white })
  hl(0, "Keyword",        { fg = p.light_green })
  hl(0, "Conditional",    { fg = p.white })
  hl(0, "Repeat",         { fg = p.white })
  hl(0, "Label",          { fg = p.blue })
  hl(0, "Operator",       { fg = p.light_white })
  hl(0, "Exception",      { fg = p.white })

  hl(0, "PreProc",        { fg = p.light_green })
  hl(0, "Include",        { fg = p.light_red })
  hl(0, "Define",         { fg = p.light_green })
  hl(0, "Macro",          { fg = p.light_blue })

  hl(0, "Type",           { fg = p.yellow })
  hl(0, "StorageClass",   { fg = p.blue })
  hl(0, "Structure",      { fg = p.yellow })
  hl(0, "Typedef",        { fg = p.yellow })

  hl(0, "Special",        { fg = p.white })
  hl(0, "SpecialChar",    { fg = p.light_yellow })
  hl(0, "Tag",            { fg = p.light_yellow })
  hl(0, "Delimiter",      { fg = p.light_white })
  hl(0, "SpecialComment", { fg = p.whitespace })

  hl(0, "Underlined",     { underline = true })
  hl(0, "Error",          { fg = p.light_red })
  hl(0, "Todo",           { fg = p.yellow,      bold = true })

  -- ── Treesitter semantic groups ─────────────────────────────────────────
  hl(0, "@tag",                    { fg = p.light_yellow })
  hl(0, "@attribute",              { fg = p.yellow })
  hl(0, "@comment",                { fg = p.whitespace })
  hl(0, "@constant",               { fg = p.light_yellow })
  hl(0, "@constant.numeric",       { fg = p.yellow,      bold = true })
  hl(0, "@constant.builtin",       { fg = p.light_green })
  hl(0, "@string.escape",          { fg = p.light_green })
  hl(0, "@constructor",            { fg = p.yellow })
  hl(0, "@function",               { fg = p.caramel })
  hl(0, "@function.builtin",       { fg = p.light_blue })
  hl(0, "@function.macro",         { fg = p.light_blue })
  hl(0, "@keyword",                { fg = p.light_green })
  hl(0, "@keyword.control",        { fg = p.white })
  hl(0, "@keyword.import",         { fg = p.light_red })
  hl(0, "@keyword.directive",      { fg = p.light_green })
  hl(0, "@keyword.storage",        { fg = p.blue })
  hl(0, "@keyword.operator",       { fg = p.light_red })
  hl(0, "@label",                  { fg = p.blue })
  hl(0, "@namespace",              { fg = p.blue })
  hl(0, "@module",                 { fg = p.blue })
  hl(0, "@operator",               { fg = p.light_white })
  hl(0, "@string",                 { fg = p.light_aqua })
  hl(0, "@string.regex",           { fg = p.light_red })
  hl(0, "@string.special",         { fg = p.light_green })
  hl(0, "@type",                   { fg = p.yellow })
  hl(0, "@variable",               { fg = p.white })
  hl(0, "@variable.builtin",       { fg = p.light_yellow })
  hl(0, "@variable.parameter",     { fg = p.light_yellow })
  hl(0, "@variable.member",        { fg = p.light_yellow })
  hl(0, "@number",                 { fg = p.yellow,      bold = true })
  hl(0, "@boolean",                { fg = p.light_green })
  hl(0, "@punctuation.delimiter",  { fg = p.light_white })
  hl(0, "@punctuation.bracket",    { fg = p.light_white })

  -- ── Markup (markdown etc.) ─────────────────────────────────────────────
  hl(0, "@markup.heading",         { fg = p.light_red,   bold = true })
  hl(0, "@markup.raw",             { fg = p.blue })
  hl(0, "@markup.bold",            { fg = p.bright_white, bold = true })
  hl(0, "@markup.italic",          { fg = p.bright_white, italic = true })
  hl(0, "@markup.strikethrough",   { strikethrough = true })
  hl(0, "@markup.list",            { fg = p.green })
  hl(0, "@markup.quote",           { fg = p.white })
  hl(0, "@markup.link.url",        { fg = p.yellow,      bold = true, underline = true })
  hl(0, "@markup.link.label",      { fg = p.light_yellow })
end

return M
