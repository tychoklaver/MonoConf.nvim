-- boilerplate/init.lua

local M = {}

local template_path = vim.fn.stdpath("config") .. "/templates/"

function M.insert_template(lang)
    local file = template_path .. lang .. ".cs"
    local f = io.open(file, "r")
    if not f then
        print("Template not found: " .. file)
        return
    end

    local lines = {}
    for line in f:lines() do
        table.insert(lines, line)
    end
    f:close()

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

vim.api.nvim_create_user_command("Boilerplate", function(opts)
    M.insert_template(opts.args)
end, {
    nargs = 1,
    complete = function() return {"csharp"} end
})

return M
