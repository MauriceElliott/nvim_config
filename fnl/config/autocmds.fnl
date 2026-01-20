;; Autocommands
(local augroup vim.api.nvim_create_augroup)
(local autocmd vim.api.nvim_create_autocmd)

;; Highlight on yank
(autocmd :TextYankPost
  {:group (augroup :highlight_yank {:clear true})
   :callback (fn [] (vim.highlight.on_yank {:timeout 200}))})

;; Remove trailing whitespace on save
(autocmd :BufWritePre
  {:group (augroup :trim_whitespace {:clear true})
   :pattern "*"
   :callback (fn []
               (let [save-cursor (vim.fn.getpos ".")]
                 (vim.cmd ":%s/\\s\\+$//e")
                 (vim.fn.setpos "." save-cursor)))})

;; Close certain filetypes with q
(autocmd :FileType
  {:group (augroup :close_with_q {:clear true})
   :pattern ["qf" "help" "man" "lspinfo" "checkhealth"]
   :callback (fn []
               (vim.keymap.set :n :q ":close<CR>" {:buffer true :silent true}))})

;; Set specific indentation for file types
(autocmd :FileType
  {:group (augroup :filetype_indent {:clear true})
   :pattern ["lua" "fennel"]
   :callback (fn []
               (set vim.opt_local.tabstop 2)
               (set vim.opt_local.shiftwidth 2)
               (set vim.opt_local.softtabstop 2))})

(autocmd :FileType
  {:group (augroup :yaml_indent {:clear true})
   :pattern ["yaml" "yml"]
   :callback (fn []
               (set vim.opt_local.tabstop 2)
               (set vim.opt_local.shiftwidth 2)
               (set vim.opt_local.softtabstop 2))})

;; Auto-format on save for specific file types (only if LSP is attached)
(autocmd :BufWritePre
  {:group (augroup :auto_format {:clear true})
   :pattern ["*.tf" "*.hcl" "*.yaml" "*.yml" "*.json"]
   :callback (fn []
               (let [(ok _) (pcall vim.lsp.buf.format {:async false})]
                 (when (not ok) nil)))})
