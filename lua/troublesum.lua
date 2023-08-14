---@mod troublesum Neovim plugin to show diagnostics summary in the buffer's corner

local c = require("troublesum.config")

local M = {}

---Update diagnostic summary
---Optimally, run this on DiagnosticChanged event
M.update = function()
    if type(c.config.enabled) == "function" and not c.config.enabled() then return end
    if not c.config.enabled then return end

    local ns = vim.api.nvim_create_namespace("troublesum")

    local counts = { 0, 0, 0, 0, }
    for _, d in pairs(vim.diagnostic.get(0)) do
        counts[d.severity] = counts[d.severity] + 1
    end

    M.clear()
    c.config.display_summary(0, ns, c.config.format(counts))
end

---Clear diagnostic summary
M.clear = function()
    local ns = vim.api.nvim_get_namespaces()["troublesum"];
    if ns ~= nil then
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end
end

---Show diagnostic summary
M.show = function()
    c.config.enabled = true
    M.update()
end

---Hide diagnostic summary
M.hide = function()
    M.clear()
    c.config.enabled = false
end

---Setup function
M.setup = function(cfg)
    c.override_config(cfg or {})

    if c.config.autocmd then
        vim.api.nvim_create_autocmd(
            { "DiagnosticChanged", "WinScrolled", "WinResized" },
            { callback = function() M.update() end })
    end
end

return M
