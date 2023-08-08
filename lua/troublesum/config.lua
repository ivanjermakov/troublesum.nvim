local M = {}

M.default_config = {}

M.config = {}

M.override_config = function(cfg)
    M.config = vim.tbl_deep_extend("force", M.default_config, cfg or {})
end

return M
