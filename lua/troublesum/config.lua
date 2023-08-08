local M = {}

---Default config
---Overriten by the config provided in setup()
M.default_config = {
    ---Enable diagnostic summary
    enabled = true,
    ---Update diagnostic summary on DiagnosticChanged event
    autocmd = true,
    ---Formatting of every diagnostic type
    severity_format = { "E", "W", "I", "H" },
    ---Highlight of every diagnostic type
    severity_highlight = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" },
    ---Formatting function
    ---@param counts table A table of tuples { severity, count } to format
    ---@return table Same as virtual_text option in nvim_buf_set_extmark
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
    ---Display function
    ---@param bufnr number Buffer number
    ---@param ns number Namespace number
    ---@text table number Same as virtual_text option in nvim_buf_set_extmark
    display_summary = function(bufnr, ns, text)
        vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 0, {
            virt_text = text,
            virt_text_pos = "right_align"
        })
    end
}

---User provided config
---Set by override_config()
M.config = {}

---Overrides default config with the user provided one
M.override_config = function(cfg)
    M.config = vim.tbl_deep_extend("force", M.default_config, cfg or {})
end

return M
