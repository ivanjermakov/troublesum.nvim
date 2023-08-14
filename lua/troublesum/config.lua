---@mod troublesum.config

---@class Config
---@field enabled boolean|function Enable diagnostic summary
---@field autocmd boolean Update diagnostic summary on DiagnosticChanged event
---@field severity_format table Formatting of every diagnostic type
---@field severity_highlight table Highlight of every diagnostic type
---@field format function Formatting function
---@field display_summary function Display function

local M = {}

---Default config
---Overriten by the config provided in setup()
---@type Config
M.default_config = {
    enabled = true,
    autocmd = true,
    severity_format = { "E", "W", "I", "H" },
    severity_highlight = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" },
    format = function(counts)
        local text = {}
        for severity, count in pairs(counts) do
            if count ~= 0 then
                if #text ~= 0 then
                    table.insert(text, { " ", "Normal" })
                end
                table.insert(text, {
                    table.concat({ M.config.severity_format[severity], tostring(count) }, " "),
                    M.config.severity_highlight[severity]
                })
            end
        end
        return text
    end,
    display_summary = function(bufnr, ns, text)
        local line = vim.fn.line("w0") - 1
        vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
            virt_text = text,
            virt_text_pos = "right_align"
        })
    end
}

---User provided config
---Set by override_config()
---@type Config
M.config = {}

---Overrides default config with the user provided one
M.override_config = function(cfg)
    M.config = vim.tbl_deep_extend("force", M.default_config, cfg or {})
end

return M
