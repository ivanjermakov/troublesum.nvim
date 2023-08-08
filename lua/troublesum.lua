local c = require("troublesum.config")
local M = {}

M.update = function()
    if not c.config.enabled then return end
    local ns = vim.api.nvim_create_namespace("troublesum")

    local counts = { 0, 0, 0, 0, }
    for _, d in pairs(vim.diagnostic.get(0)) do
        counts[d.severity] = counts[d.severity] + 1
    end

    M.clear()
    c.config.display_summary(0, ns, c.config.format(counts))
end

M.clear = function()
    local ns = vim.api.nvim_get_namespaces()["troublesum"];
    if ns == nil then return end
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

M.show = function()
    c.config.enabled = true
    M.update()
end

M.hide = function()
    M.clear()
    c.config.enabled = false
end

M.setup = function(cfg)
    c.override_config(cfg or {})

    if c.config.autocmd then
        vim.api.nvim_create_autocmd('DiagnosticChanged', { callback = function() M.update() end, })
    end
end

return M
