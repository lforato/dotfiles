--------------------------------------------------------------------------------
--- CMD
--------------------------------------------------------------------------------

vim.cmd([[
  autocmd BufRead,BufNewFile *.html setfiletype html
]])

vim.cmd([[
  autocmd bufread,bufnewfile *.sql setfiletype sql
]])

vim.cmd([[
  autocmd BufRead,BufNewFile .env* lua vim.diagnostic.disable()
]])

vim.cmd([[
  set fillchars=horiz:\─,vert:\│,horizdown:\┬,horizup:\┴,vertright:\├,vertleft:\┤,verthoriz:\┼
]])

vim.cmd([[
  set signcolumn=yes
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.cmd([[
  set clipboard=unnamedplus
]])

vim.cmd([[
  autocmd FileType html setlocal ts=2 sts=2 sw=2
  autocmd FileType html,typescript,css,javascript,jsx,tsx setlocal omnifunc=v:lua.vim.lsp.omnifunc
]])
