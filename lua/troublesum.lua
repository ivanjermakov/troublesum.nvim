local c = require("troublesum.config")
local M = {}

local display_summary = function(bufnr, ns, text)
    vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 0, {
        virt_text = { { text } },
        virt_text_pos = "right_align"
    })
end

local severity_format = {
    [1] = "E",
    [2] = "W",
    [3] = "I",
    [4] = "H",
}

local format = function(counts)
    local str = ""
    for severity, count in pairs(counts) do
        if count ~= 0 then
            if #str ~= 0 then
                str = str .. " "
            end
            str = str .. table.concat({ severity_format[severity], tostring(count) }, " ")
        end
    end
    return str
end

M.show = function()
    local ns = vim.api.nvim_create_namespace("troublesum")

    local counts = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
    }
    for _, d in pairs(vim.diagnostic.get(0)) do
        counts[d.severity] = counts[d.severity] + 1
    end

    M.clear()
    display_summary(0, ns, format(counts))
end

M.clear = function()
    local ns = vim.api.nvim_get_namespaces()["troublesum"];
    if ns == nil then return end
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

M.setup = function(cfg)
    c.override_config(cfg or {})

    vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua require("troublesum").show() ]]
end

return M
