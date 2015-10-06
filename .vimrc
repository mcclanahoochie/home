set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
syntax on

:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

augroup filetype
   au! BufRead,BufNewFile *.proto setfiletype proto
augroup end
