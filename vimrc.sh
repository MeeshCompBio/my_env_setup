" Configuration file for vim
set modelines=0		" CVE-2007-2438
:imap kj <Esc>

"Vundle package information"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'dracula/vim', { 'name': 'dracula' }
"####Put Plugins under here####"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


set tabstop=4       " The width of a TAB is set to 4
set shiftwidth=4    " Indents will have a width of 4
set expandtab       " Expand TABs to spaces



" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

"this is for the theme"
 syntax enable
 " set background=dark
" let g:solarized_termcolors = 256
"colorscheme Tomorrow-Night-Bright
colorscheme dracula
 "autocmd FileType sh colorscheme industry
autocmd BufEnter *.sh colorscheme falcon

set number
set showcmd
set cursorline

" highlight line 80 and after line 100
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80,".join(range(120,999),",")










