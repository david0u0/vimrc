set number
set hls
set omnifunc=syntaxcomplete#Complete

set cursorline
colorscheme gruvbox

map <leader>e :e <C-r>=expand("%:p:h")<cr>/
map <leader>se :sp <C-r>=expand("%:p:h")<cr>/
map <leader>ve :vsp <C-r>=expand("%:p:h")<cr>/

let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
map gl :exe "tabn ".g:lasttab<CR>
