"auto vundle
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"Bundle plugin setting
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'

"vim base setting
set t_Co=256
colorscheme molokai
filetype plugin indent on
set noswf               "don't use swap file all in memory
set nocompatible        "vi and vim is not comaptible
set backspace=2         "use backspace as directer key
set ttymouse=xterm2
set clipboard=unnamedplus
set titlestring=Vim\ -\ %f

"file encoding
set fencs=utf-8,big5
set fenc=utf-8
set enc=utf-8

"search setting
set hlsearch            "use hight light for search
set incsearch           "search patern immediate
set ignorecase          "ignore charector case

"programming setting
syntax on
set foldmethod=syntax   "fold by syntax
set autoindent          "auto indent
set cindent             "c indent
set number              "show line number
set nowrap              "no break line

"show setting
set showmatch           "brackets matching
set showcmd             "show command
set showmode            "show mode
set ruler               "line status

"tab setting
set shiftwidth=4        "shift tab 4 space
set tabstop=4           "use 4 space instead tab
set expandtab           "convert tab to space

"statusline setting
set ls=2
set statusline=%4*%<\%1*(%f)
set statusline+=%4*\ %5*(%{&encoding}, " encoding
set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"})%m
set statusline+=%4*%=\ %3*(%l,%c)%4*\ %2*(%P)%4*
"highlight StatusLine ctermfg=darkgray ctermbg=white
highlight User1 ctermfg=222
highlight User2 ctermfg=101
highlight User3 ctermfg=173
highlight User4 term=underline cterm=underline ctermfg=059
highlight User5 ctermfg=215

"tab page mapping
nmap <C-t> :tabnew<CR>
nmap <S-n> :tabnext<CR>
nmap <S-p> :tabprev<CR>

"highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\\+$/
autocmd BufWinLeave * call clearmatches()
highlight ExtraTab ctermbg=blue guibg=blue
match ExtraTab /\t/

"functional mapping
nmap <F5> :e!<CR>
nmap <F6> :set nu!<BAR>set nu?<CR>
nmap <F7> :if exists("syntax_on")<BAR>
    \ syntax off <BAR><CR>
    \ else <BAR>
    \ syntax on <BAR>
    \ endif <CR>
nmap <F8> :set hls!<BAR>set hls?<CR>
nmap <F9> :set paste!<BAR>set paste?<CR>

"ctrlp setting
let g:ctrlp_custom_ignore = { 'dir': '\v[\/]\.(git|hg|svn)$', 'file': '\v\.(exe|so|dll)$', 'link': 'some_bad_symbolic_links' }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard']

"xml fold by indent
autocmd FileType xml
    \ let xml_syntax_folding=1 |
    \ setlocal syntax=xml |
    \ setlocal foldmethod=syntax |
    \ setlocal foldlevel=2
