# troublesum.nvim

Neovim plugin to show diagnostics summary in the buffer's corner, similar to JetBrains' [inspections widget](https://www.jetbrains.com/idea/guide/tips/inspections-widget/).

![image](https://github.com/ivanjermakov/troublesum.nvim/assets/26609879/b6590aa1-4600-4113-9ca2-681c19e93874)

## Installation

```lua
-- Packer.nvim:
use "ivanjermakov/troublesum.nvim"

-- Lazy.nvim:
{
    "ivanjermakov/troublesum.nvim",
    config = function()
        require("troublesum").setup()
    end
}
```

## Configuration

```lua
require("troublesum").setup({
    enabled = true,
    autocmd = true,
    severity_format = { "E", "W", "I", "H" },
    severity_highlight = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" },
    format = function(counts) end,
    display_summary = function(bufnr, ns, text) end
})
```

## Credits

* Inspired by [trld.nvim](https://github.com/Mofiqul/trld.nvim)
* Doc generator [lemmy-help](https://github.com/numToStr/lemmy-help)
