local c = require("troublesum.config")
local M = {}

local display_summary = function(bufnr, ns, text)
    vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 0, {
        virt_text = { { text } },
        virt_text_pos = "right_align"
    })
end

M.show = function()
    local ns = vim.api.nvim_create_namespace("troublesum")

    local count = tostring(#vim.diagnostic.get())

    M.hide()
    display_summary(0, ns, count)
end

M.hide = function()
    local ns = vim.api.nvim_get_namespaces()["troublesum"];
    if ns == nil then return end
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

M.setup = function(cfg)
    c.override_config(cfg or {})

    vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua require("troublesum").show() ]]
end

return M
