;; Plugin manager configuration
(local lazy (require :lazy))

(lazy.setup :plugins

  ;; lazy.nvim options
  {:ui {:border :rounded}
   :checker {:enabled true :notify false}
   :change_detection {:notify false}
   :performance {:rtp {:disabled_plugins [:gzip
                                          :matchit
                                          :matchparen
                                          :netrwPlugin
                                          :tarPlugin
                                          :tohtml
                                          :tutor
                                          :zipPlugin]}}})
