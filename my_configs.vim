set number
set hls
set omnifunc=syntaxcomplete#Complete

set cursorline
colorscheme gruvbox

map <leader>e :e <C-r>=expand("%:p:h")<cr>/
map <leader>se :sp <C-r>=expand("%:p:h")<cr>/
map <leader>ve :vsp <C-r>=expand("%:p:h")<cr>/

map Y y$

let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
map gl :exe "tabn ".g:lasttab<CR>
map gr gT

let g:rainbow_active = 1

silent! set termwinsize=15x0
silent! tnoremap <Esc> <C-\><C-n>:set nonumber<cr>
map <leader>` :below terminal<cr>

let g:ack_mappings = {'H': '<C-W><CR><C-W>K<C-W>b', 'go': '<CR><C-W>p', 't': '<C-W><CR><C-W>T', 'q': ':cclose<CR>',
        \ 's': '<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t', 'gs': '<C-W><CR><C-W>H<C-W>b<C-W>J', 'i': '<C-W><CR><C-W>K', 'gt': '<C-W><CR><C-W>TgT<C-W>j',
        \ 'O': '<CR><C-W>p<C-W>c', 'o': '<CR>'}

set notimeout notimeout

autocmd BufWinEnter * silent! RltvNmbr
" remap backward search, since we map , as leader
map g; <Plug>Sneak_,

set hidden
set runtimepath+=~/.vim_runtime/my_plugins/LanguageClient-neovim
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

set notimeout
set ttimeout
