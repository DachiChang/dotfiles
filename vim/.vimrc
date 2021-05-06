"auto vundle
set nocompatible
filetype off
let vundle_install=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_install)
    echo "Installing Vundle....."
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif
set rtp+=~/.vim/bundle/Vundle.vim/
"vundle plugin setting
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'stephpy/vim-yaml'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'preservim/nerdtree'
Plugin 'ycm-core/YouCompleteMe' "Inastall Note: cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer --ts-completer
call vundle#end()

"vim base setting
set t_Co=256
colorscheme molokai
filetype plugin indent on
set noswf               "don't use swap file all in memory
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
"highlight TabLine
highlight TabLineFill ctermfg=235
highlight TabLine term=none cterm=none ctermfg=252 ctermbg=235
highlight TabLineSel term=bold cterm=bold ctermfg=255 ctermbg=238

"highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\\+$/
autocmd BufWinLeave * call clearmatches()
highlight ExtraTab ctermbg=blue guibg=blue
match ExtraTab /\t/

"tab page mapping
nmap <C-p> :tabprev<CR>
nmap <C-n> :tabnext<CR>
nmap <C-t> :tabnew<CR>
nmap <C-q> :tabclose<CR>

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

"YouCompleteMe setting
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf=0
nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gt :YcmCompleter GetType<CR>

"NERDTree setting
"o  open in current window, and focus
"go open in current window, but stay NERDTree
"t  open in new tab, and focus
"T  open in new tab, but stay NERDTree
"i  open in a new horizontal window, and focus
"gi open in a new horizontal window, but stay NERDTree
"s  open in a new vertical window, and focus
"gs open in a new vertical window, but stay NERDTree
"O  open directory recursively
nnoremap <F1> :NERDTreeToggle<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
autocmd BufWinEnter * silent NERDTreeMirror
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
