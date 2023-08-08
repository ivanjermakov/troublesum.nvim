local M = {}

M.default_config = {
    enabled = true,
    autocmd = true,
    severity_format = { "E", "W", "I", "H", },
    format = function(counts)
        local str = ""
        for severity, count in pairs(counts) do
            if count ~= 0 then
                if #str ~= 0 then
                    str = str .. " "
                end
                str = str .. table.concat({ M.config.severity_format[severity], tostring(count) }, " ")
            end
        end
        return str
    end,
    display_summary = function(bufnr, ns, text)
        vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 0, {
            virt_text = { { text } },
            virt_text_pos = "right_align"
        })
    end
}

M.config = {}

M.override_config = function(cfg)
    M.config = vim.tbl_deep_extend("force", M.default_config, cfg or {})
end

return M
