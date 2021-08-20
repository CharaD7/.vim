" .vimrc
" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Synstastic loading
execute pathogen#infect()

nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

function! FindConfig(prefix, what, where)
    let cfg = findfile(a:what, escape(a:where, ' ') . ';')
    return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

autocmd FileType javascript let b:syntastic_javascript_jscs_args =
    \ get(g:, 'syntastic_javascript_jscs_args', '') .
    \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))


" ============================================================================

" ---- PLUGINS ----------------------------------------------------------------
"
" https://github.com/junegunn/vim-plug
" install plugins with :PlugInstall
" clean unused plugins :PlugClean
"
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'      " color scheme
Plug 'tpope/vim-fugitive'   " git integration
Plug 'lyuts/vim-rtags'      " C++
Plug 'mbbill/undotree'
" Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dense-analysis/ale'
Plug 'zxqfl/tabnine-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
" Trying to use telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Config to support C#
Plug 'OmniSharp/omnisharp-vim'
"--------------------------------------------------------------"
Plug 'frazrepo/vim-rainbow'
Plug 'chrisbra/vim-commentary'
Plug 'vim-scripts/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
" nvim v0.5.0
Plug 'kdheepak/lazygit.nvim'
" Use release branch (recommend)
Plug 'yggdroot/indentline'
Plug 'tpope/vim-unimpaired'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'valloric/youcompleteme'
Plug 'tmsvg/pear-tree' " For pairing tags and parentheses
" Debugger plugins"
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" NERDTree Plugins
" ================================================================================================
" Adds syntax highlighting to NERDTree based on filetype
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Saves and restores the state of the NERDTree between sessions
Plug 'scrooloose/nerdtree-project-plugin'
" Highlights open files in a different color, CLoses a buffer directly from NERDTree
Plug 'PhilRunninger/nerdtree-buffer-ops'
" Enables NERDTree to open, delete, move, or copy multiple Visually-selected files at once
Plug 'PhilRunninger/nerdtree-visual-selection'
" Adds filetype-specific icons to NERDTree files and folders
Plug 'ryanoasis/vim-devicons'

" Airline (status bar on the bottom)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
" -----------------------------------------------------------------------------

" ============================================================================
" Install plugins the first time vim runs
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif
" ============================================================================


" mouse
set mouse-=a               " disable custom mouse in vim (so that we can select
"if has("mouse")
"    set mouse=a             " control cursor with the mouse
"endif
set guifont=FiraCode-Retina:h14
syntax on                   " syntax highlighting

set encoding=utf-8

" hides buffers instead of closing them. This means that you can have unwritten
" changes to a file and open a new file using :e, without being forced to write
" or undo your changes first
"set hidden

"set nocompatible           " useless

set visualbell
set noerrorbells            " no sounds
set tabstop=4               " size of tabs   (set ts=4 also works)
set shiftwidth=4            " indent using '>' uses 4 spaces
set softtabstop=4
set expandtab               " tabs => spaces
set smartindent
set number                  " line numbers (set nu)
set relativenumber
set nowrap                  " no wrapping of long lines
set noswapfile
set nobackup                " because undodir/undofile
if has('persistent_undo')
    set undodir=~/.vim/undodir
    set undofile
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
endif

set hlsearch                " highlight search terms
set incsearch               " incremental search
set ignorecase
set smartcase               " ignore case if search pattern is all lowercase,
                            " case-sensitive otherwise

set cmdheight=2             " more space for displaying msgs

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" colours/theme
set background=dark

" use 256 colors when possible
if has('gui_running') || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || (&term =~? 'mlterm\|fbterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    colorscheme gruvbox
    "colorscheme desert     "moche
else
    colorscheme delek       "tres moche
endif

set cursorline              " highlight the line of the cursor
" if exists("&colorcolumn")
" set colorcolumn=120          " highlight column #80
" endif
" highlight ColorColumn ctermbg=0 guibg=lightgrey
" highlight text beyond column 120
" highlight OverLength ctermbg=71 ctermfg=white guibg=#592929
" match OverLength /\%121v.\+/


" the default file browser in vim is netrw (cmd :Explore)
" https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0          " remove banner (key `I`)
let g:netrw_browse_split = 2    " open files in a new vertical split
let g:netrw_winsize = 25        " sets the width to 25% of the page
let g:netrw_liststyle = 3       " default list style (key `i`)


let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']





let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Use vim-devicons
let g:fzf_preview_use_dev_icons = 1

" Use fzf history option
" let g:fzf_preview_history_dir = false
let g:fzf_preview_history_dir = '~/.fzf'

" devicons character width
let g:fzf_preview_dev_icon_prefix_string_length = 3

" Devicons can make fzf-preview slow when the number of results is high
" By default icons are disable when number of results is higher that 5000
let g:fzf_preview_dev_icons_limit = 5000

" The theme used in the bat preview
let g:fzf_preview_preview_bat_theme = 'ansi'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)


" Setting the shell
set shell=/bin/zsh
let $SHELL = "/bin/zsh"

" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" Configuration for lazygit
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 0 " fallback to 0 as neovim-remote is not installed

" setup mapping to call :LazyGit to load up the configuration right from vim,
" run :LazyGitConfig<CR>
nnoremap <silent> <leader>gg :LazyGit<CR>

" Making use of neovim-remote for lazygit comment editor instance in vim
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif


autocmd FileType apache set commentstring=#\ %s

" Emmet Configuration
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key='<C-N>'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_<filetype>_checkers = ['<checker-name>']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']
let g:syntastic_aggregate_errors = 1
let g:syntastic_ruby_mri_args = "--my --args --here"
let g:syntastic_always_populate_loc_list = 1


" NERDTree trigger
map <leader>e :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTree<CR>
nnoremap <S-f> :NERDTreeFind<CR>
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Registering lightline components
let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

" Setting color to the components
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

" Adding components to the lightline
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }
let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
	    \            [ 'percent' ],
	    \            [ 'fileformat', 'fileencoding', 'filetype'] ] }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"


" Plugin Settings {
" Airline {
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" Theme ( github.com/vim-airline/vim-airline-themes
let g:airline_theme= 'gruvbox'
" }

" Experimental {
" Search and Replace
nmap <leader>s :%s//g<Left><Left>
" }


" Customizing Indentlines
let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_enabled = 1
let g:indentLine_char = '\u206'

" Use the stdio version of OmniSharp-roslyn - this is the default
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
let g:OmniSharp_selector_findusages = 'fzf'
" let g:OmniSharp_popup_mappings.close = '<Esc>'
" Configuring popup options
let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [1],
\ 'border': [1]
\}

if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Enable snippet completion, using the ultisnips plugin
" let g:OmniSharp_want_snippet=1




" Keybindings {
" Save file
nmap <leader>w :w<CR>
vmap <leader>w :w<CR>
" nnoremap <leader>w :w<CR>
"Copy and paste from system clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P


"Use this variable to change symbols.

"vim
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'✹',
    \ 'Staged'    :'✚',
    \ 'Untracked' :'✭',
    \ 'Renamed'   :'➜',
    \ 'Unmerged'  :'═',
    \ 'Deleted'   :'✖',
    \ 'Dirty'     :'✗',
    \ 'Ignored'   :'☒',
    \ 'Clean'     :'✔︎',
    \ 'Unknown'   :'?',
    \ }
let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0
let g:NERDTreeGitStatusShowIgnored = 1 " a heavy feature may cost much more time. default: 0
let g:NERDTreeGitStatusUntrackedFilesMode = 'all' " a heavy feature too. default: normal
let g:NERDTreeGitStatusShowClean = 1 " default: 0
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0
let NERDTreeShowHidden=1 " Show hidden files in NERDTree


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Always show the signcolumn, otherwise it would shift the text each time
set signcolumn=yes

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
" set signcolumn=number
" else
" set signcolumn=yes
" endif


" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual


" For adding multiple characters
nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>



" For editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" defines a `leader key` for custom shortcuts
let mapleader=" "


" REMAPs

" move cursor to other splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" open explorer
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
" resize splits
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
nmap <leader>hs <Plug>GitGutterStageHunk
nmap <leader>hu <Plug>GitGutterUndoHunk


" Use <C-L> to clear the highlighting of :set hlsearch.
 if maparg('<C-L>', 'n') ==# ''
   nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
 endif

" Cycle through buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Spread buffer on tabline
let g:buftabline_numbers = 1

" Vim Commentary
" nnoremap <C-/> :Commentary<CR>
nmap <leader>/ :Commentary<CR>
nnoremap <leader>/ :Commentary<CR>
vmap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>
" vnoremap <C-/> :Commentary<CR>

" Using supertabs and previews for youcompleteme
let g:SuperTabClosePreviewOnPopupClose = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_completion = 0


 " Remove newbie crutches in Command Mode
" cnoremap <Down> <Nop>
" cnoremap <Left> <Nop>
" cnoremap <Right> <Nop>
" cnoremap <Up> <Nop>

" Remove newbie crutches in Insert Mode
" inoremap <Down> <Nop>
" inoremap <Left> <Nop>
" inoremap <Right> <Nop>
" inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
" nnoremap <Down> <Nop>
" nnoremap <Left> <Nop>
" nnoremap <Right> <Nop>
" nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
" vnoremap <Down> <Nop>
" vnoremap <Left> <Nop>
" vnoremap <Right> <Nop>
" vnoremap <Up> <Nop>
