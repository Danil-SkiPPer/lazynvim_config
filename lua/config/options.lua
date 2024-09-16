-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.smarttab = true
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

if vim.fn.executable("pwsh") == 1 then
    vim.o.shell = "pwsh"
else
    vim.o.shell = "powershell"
end

-- Setting shell command flags
vim.o.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"

-- Setting shell redirection
vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'

-- Setting shell pipe
vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'

-- Setting shell quote options
vim.o.shellquote = ""
vim.o.shellxquote = ""
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.c", "*.cpp", "*.py", "*.js", "*.html", "*.lua" }, -- укажите свои типы файлов
    callback = function()
        vim.opt.spell = true -- включает проверку орфографии
        vim.opt.spelllang = { "en", "ru" } -- задаёт языки
    end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.py", "*.cpp", "*.txt" }, -- Укажите типы файлов
    callback = function()
        vim.opt_local.spell = true
    end,
})
vim.cmd([[
    syntax spell toplevel
    syntax match MyStringSpell /\v".{-}"/ contains=@Spell
]])
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "cpp", "lua" }, -- Замените на нужные языки
    callback = function()
        vim.cmd([[
            syntax match SpellError "\v\"[^\"]+\""
            setlocal spell spelllang=en,ru
        ]])
    end,
})
