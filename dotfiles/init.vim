" Install vim-plug using:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" In case of install issues, run the command `echo stdpath('config')` in nvim
" and see the dir its using and then ensure we have that path/autoload/plug.vim
" file present there.
"
call plug#begin('~/.config/nvim/plugins')
" Order of plugins might be important!

" Misc plugins

" project dev support
Plug 'ryanoasis/vim-devicons'

"search support
Plug 'pbogut/fzf-mru.vim'
Plug 'tpope/vim-fugitive'

"" For Golang
Plug 'fatih/vim-go'

" TODO explore this
Plug 'thaerkh/vim-workspace'

"
"" For Terraform
"Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
"Plug 'juliosueiras/vim-terraform-completion'

" For Bash
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"
"
"" TODO
""Plug 'tpope/vim-sensible'
""Plug 'ctrlpvim/ctrlp.vim'
""Plug 'Valloric/YouCompleteMe'

" For searching
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


Plug 'towolf/vim-helm'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

call plug#end()

" vim-devicons
set encoding=UTF-8


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Config for Terraform
"
"" Syntastic Config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
"" (Optional)Remove Info(Preview) window
"set completeopt-=preview
"
"" (Optional)Hide Info(Preview) window after completions
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"
"" (Optional) Enable terraform plan to be include in filter
"let g:syntastic_terraform_tffilter_plan = 1
"
"" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
"let g:terraform_completion_keys = 1
"
"" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
"let g:terraform_registry_module_completion = 0
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config for NerdTree

" Start NERDTree
"autocmd VimEnter * NERDTree " Do not stat NerdTree automatically
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NvimTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize=40

" Nerdtee highlights
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeLimitedSyntax = 1

" Nerdtree + Git integration
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"" config files show up red in NERDTree
"call NERDTreeHighlightFile('ini',     'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('config',  'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('conf',    'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('cfg',    'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('json',    'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('toml',    'Red', 'none', '#ff00ff', '#151515')
"" markdown shows up as blue
"call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
"" other file colors
"call NERDTreeHighlightFile('yaml',     'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('yml',     'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('go', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('py', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('c', 'green', 'none', 'green', '#151515')
"call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config for Python

"PEP8
set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " an hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
set formatoptions-=t

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Config for vim-go
"
"" vim-go settings
""let g:go_test_timeout= '10s'
""let g:go_play_browser_command = ''
""let g:go_play_open_browser = 1
""let g:go_auto_type_info = 0
"let g:go_info_mode='gopls'
""let g:go_auto_sameids = 0
""let g:go_updatetime = 800
""let g:go_jump_to_error = 1
"let g:go_fmt_autosave = 1
"let g:go_fmt_command = "gofmt"
""let g:go_fmt_options = ''
""let g:go_fmt_fail_silently = 0
"let g:go_fmt_experimental = 1
""let g:go_doc_keywordprg_enabled = 1
"let g:go_def_mode='gopls'
""let g:go_def_mapping_enabled = 1
"" disable vim-go :GoDef short cut (gd)
"" this is handled by LanguageClient [LC]
"let g:go_def_mapping_enabled = 0
""let g:go_def_reuse_buffer = 0
""let g:go_doc_command = "godoc"
""let g:go_doc_options = ''
""let g:go_bin_path = ""
""let g:go_snippet_engine = "ultisnips"
""let g:go_snippet_case_type = "snakecase"
""let g:go_get_update = 1
""let g:go_guru_scope = []
""let g:go_build_tags = ''
""let g:go_highlight_array_whitespace_error = 1
""let g:go_highlight_chan_whitespace_error = 1
""let g:go_highlight_extra_types = 1
""let g:go_highlight_space_tab_error = 1
""let g:go_highlight_trailing_whitespace_error = 1
"let g:go_highlight_operators = 0
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_types = 0
""let g:go_highlight_fields = 0
""let g:go_highlight_build_constraints = 0
"let g:go_highlight_generate_tags = 1
""let g:go_highlight_string_spellcheck = 1
""let g:go_highlight_format_strings = 1
""let g:go_autodetect_gopath = 1
""let g:go_textobj_enabled = 1
""let g:go_textobj_include_function_doc = 1
""
"let g:go_metalinter_autosave = 0
""let g:go_metalinter_autosave_enabled = ['vet', 'golint']
""let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
""let g:go_metalinter_excludes = []
""let g:go_metalinter_command = ""
""let g:go_metalinter_deadline = "5s"
"let g:go_list_height = 10
"let g:go_list_autoclose = 1
""let g:go_list_type = ""
""let g:go_asmfmt_autosave = 0
""let g:go_alternate_mode = "edit"
""let g:go_gorename_prefill = 1
""let g:go_gocode_autobuild = 1
""let g:go_gocode_propose_builtins = 1
""let g:go_gocode_unimported_packages = 0
""let g:go_gocode_socket_type = 'unix'
""let g:go_template_autocreate = 1
""let g:go_template_file = "hello_world.go"
"let g:go_template_use_pkg = 1
""let g:go_decls_includes = 'func,type'
""let g:go_echo_command_info = 1
""let g:go_echo_go_info = 1
""let g:go_statusline_duration = 60000
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other misc nvim configs

"set number
set number relativenumber
set termguicolors
set nocompatible
set wrapscan
set incsearch
set tabstop=4
set shiftwidth=4
set noshowcmd
set showmatch
set confirm
set backspace=2
set ruler
set laststatus=2
set cmdheight=1
set shortmess=a
set history=50
set autowrite
"set ignorecase
syntax on
syntax enable
set hlsearch " permanent highlight of search!, incremental search will
             " still highlight, use :noh[ighlight] to turn-off temporarily
set novisualbell
set errorbells
highlight Search term=reverse ctermfg=4 ctermbg=7
"" Delete all empty lines in the file
map <F5>  :g/^\s*$/d <CR>
set bg=dark
set clipboard+=unnamed

filetype plugin indent on
" highlight with red bg if the line exceeds 80 char limit
highlight OverLength ctermbg=Blue ctermfg=white guibg=#592929
match OverLength /\%80v./

" yank to global clipboard
" set guioptions+=a
set modelines=5

" Enable undo-persistence
set undodir=~/.vim/undodir
set undofile

" Enhanced search tools: ack, ag, fzf
let g:ackprg = 'ag --nogroup --nocolor --column'
if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif
"set rtp+=/usr/local/bin/fzf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"" Format .json files on save TODO
"autocmd FileType json autocmd BufWritePre <buffer> %!jq '.'

let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start']
    \ }
colorscheme vim
