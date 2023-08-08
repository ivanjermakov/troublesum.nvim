# troublesum.nvim

Neovim plugin to show diagnostics summary in the buffer corner, similar to JetBrains' [inspections widget](https://www.jetbrains.com/idea/guide/tips/inspections-widget/).

## Installation

```lua
-- Packer:
use "ivanjermakov/troublesum.nvim"
```

## Configuration
```lua
require("troublesum.vnim").setup({
    enabled = true,
    autocmd = true,
    severity_format = { "E", "W", "I", "H" },
    severity_highlight = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" },
    format = function(counts) end,
    display_summary = function(bufnr, ns, text) end
})
```

