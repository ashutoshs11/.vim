call pathogen#infect()
call pathogen#helptags()
" => General
""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" => Colors and Fonts
" Enable syntax highlighting
syntax enable
colorscheme desert
set background=light

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
"" To edit and apply .vimrc on the fly
nmap ;v :tabnew ~/.vimrc<CR>
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
else
  nmap ;;v :source ~/.vimrc<CR>
endif     	


" Fast saving
nmap <leader>w :w!<cr>

"====[ Make the 81st column stand out ]====================
" just the 81st column of wide lines...
highlight ColorColumn ctermbg=cyan
call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.2)<cr>
nnoremap <silent> N   N:call HLNext(0.2)<cr>

highlight WhiteOnRed ctermbg=red guifg=white

" OR ELSE just highlight the match in red...
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
   redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction



"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
"exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
"set list



"====[ Swap : and ; to make colon commands easier to type ]======
nnoremap  ;  :
"    nnoremap  :  ;




"====[ Open any file with a pre-existing swapfile in readonly mode "]=========
augroup NoSimultaneousEdits
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o' 
  "    autocmd SwapExists * echomsg ErrorMsg
  autocmd SwapExists * echo 'Duplicate edit session (readonly)'
  "    autocmd SwapExists * echohl None
  autocmd SwapExists * sleep 2
augroup END 




" => VIM user interface
""""""""""""""""""""""""""""""
set so=2                       " Lines to the cursor when moving vertically
set wildmenu                   " Turn on the WiLd menu
set wildignore=*.o,*~,*.pyc    " Ignore compiled files
set ruler                      " Always show current position
set cmdheight=2                " Height of the command bar
set hid                        " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent " Configure backspace as it should act
set whichwrap+=<,>,h,l         " Wrap around for end/beg of lines"
set ignorecase                 " Ignore case when searching
set smartcase                  " When searching try to be smart about cases
set smarttab                   " Be smart when using tabs ;)
set shiftwidth=4               " 1 tab == 4 spaces
set tabstop=4                  " Number of spaces for <Tab> "
set lbr                        " Linebreak on 500 characters
set tw=500                     " textWidth"
set ai                         " Auto indent
set si                         " Smart indent
set wrap                       " Wrap lines
set expandtab                  " Use spaces instead of tabs
set shiftwidth=2               " Number of spaces for each step of (auto)indent
set nu                         " Set line numbers on"
set hlsearch                   " Highlight search results
set incsearch                  " Search : Match as typed
set lazyredraw                 " Don't redraw when executing macros:performance
set magic                      " For regular expressions turn magic on
set showmatch                  " Show matching brackets when cursor is over them
set matchtime=2                " Tenths of second to blink when matching paren
set noerrorbells               " No annoying sound on errors
set novisualbell
set t_vb=
"set tm=500

"Java and C highlights
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_functions=1
let java_mark_braces_in_parens_as_errors=1

let c_comment_strings=1






" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions+=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"" Maps Ctrl+Shift+[h,j,k,l] to resize the window splits
map <C-Up> <C-w>+ 
map <C-Down> <C-W>-
map <C-Left> <C-W><
map <C-Right> <C-w>>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
" Remember info about open buffers on close
set viminfo^=%

" Always show the status line
set laststatus=2
" Format the status line
"set statusline=\ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*


" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"========
"NERDTree 
"========
""open a NERDTree automatically when vim starts up if no files were specified?
autocmd vimenter * if !argc() | NERDTree | endif
"shortcut to open NERDTree?
map <F3> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"" Tags settings and mappings
set tags=tags;
nmap <C-]> <C-w><C-]><C-w>


"======
"TagBar
"======
let g:tagbar_usearrows = 1
nnoremap <F5> :TlistToggle<CR>

