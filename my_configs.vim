set showcmd
set number
set hls
set cursorline

function! SetColorScheme()
    silent! colorscheme gruvbox
endfunction

call SetColorScheme()

map gf gF
map <leader>q :q <cr>
map <leader>e :e <C-r>=expand("%:p:h")<cr>/<c-f>
map <leader>se :sp <C-r>=expand("%:p:h")<cr>/<c-f>
map <leader>ve :vsp <C-r>=expand("%:p:h")<cr>/<c-f>
map <leader>cr :execute 'cd ' . b:LanguageClient_projectRoot<cr>:pwd<cr>
map <leader>. :%s/<C-r>///gn<cr>

noremap Y y$
noremap - g_

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
let g:LanguageClient_hoverPreview = 'always'
nmap <silent> gh <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> gu <Plug>(lcn-references)

set notimeout
set ttimeout

let g:SuperTabDefaultCompletionType = "<c-x><c-u>"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<PageDown>"
let g:UltiSnipsJumpBackwardTrigger="<PageUp>"

" DO NOT use &omnifunc, it will be something stupid like ccomplete#Complete
autocmd FileType * silent! call SuperTabChain("MySuperTabComplete", "<c-p>") 

function! MySuperTabComplete(findstart, base)
    if exists('b:LanguageClient_isServerRunning') && b:LanguageClient_isServerRunning
        return LanguageClient#complete(a:findstart, a:base)
    else
        return syntaxcomplete#Complete(a:findstart, a:base) " a sad fallback for those without lsp support.
    endif
endfunction

function! s:goyo_enter()
    RltvNmbr!
endfunction
function! s:goyo_leave()
    RltvNmbr
    call SetColorScheme()
endfunc
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! MyFormatOnSave()
    if exists('b:LanguageClient_isServerRunning') && b:LanguageClient_isServerRunning
        call LanguageClient_textDocument_formatting_sync()
    endif
endfunction
if exists('g:my_format_on_save_list')
    execute "autocmd FileType " . join(g:my_format_on_save_list, ",") . " autocmd BufWritePre * call MyFormatOnSave()"
endif

let g:ctrlp_mruf_relative = 1 "make ctrlp find mru in working dir
set completeopt=menu

" startify
let g:startify_session_persistence=1
let g:startify_session_dir="~/.vim_runtime/sessions"
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ ]

" indent
noremap { [{
noremap } ]}
autocmd BufWinEnter * silent! IndentGuidesEnable

packadd! matchit
if exists("loaded_matchit")
    if !exists("b:match_words")
        let b:match_ignorecase = 0
        let b:match_words =
                    \ '\%(\%(\%(^\|[;=]\)\s*\)\@<=\%(class\|module\|while\|begin\|until\|for\|if\|unless\|def\|case\)\|\<do\)\>:' .
                    \ '\<\%(else\|elsif\|ensure\|rescue\|when\)\>:\%(^\|[^.]\)\@<=\<end\>'
    endif
endif

nnoremap ' `

" vim-mark
let g:mw_no_mappings = 1
nmap <leader>N <Plug>MarkAllClear
nmap <leader>* <Plug>MarkSearchCurrentNext
nmap <leader>/ <Plug>MarkSearchAnyNext
nmap <leader># <Plug>MarkSearchCurrentPrev
nmap <leader>? <Plug>MarkSearchAnyPrev
nmap <leader>r <Plug>MarkRegex
nmap <leader>m <Plug>MarkSet
nmap <leader>N :MarkClear<cr>

vmap <silent> <leader>r <plug>MarkRegex

autocmd BufWinEnter * silent! highlight clear SpellBad

set foldmethod=syntax
set foldlevel=20
