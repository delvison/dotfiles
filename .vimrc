let g:polyglot_disabled = ['markdown']
" plugins
" install vim :PlugInstall with vim-plug
" $ vim +PlugInstall +qall
  call plug#begin('~/.vim/plugged')
    " for dev
    Plug 'jvirtanen/vim-hcl'          " for terrform
    Plug 'fatih/vim-go'               " for golang
    Plug 'airblade/vim-gitgutter'     " git diffs on left gutter
    Plug 'dense-analysis/ale'         " syntax linter
    Plug 'sheerun/vim-polyglot'
    Plug 'Yggdroot/indentLine'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hashivim/vim-terraform'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    " for markdown
    Plug 'godlygeek/tabular'  " used for formatting tables
    Plug 'preservim/vim-markdown'
    Plug 'artempyanykh/marksman'  " for linking

    " QOL
    Plug 'mhinz/vim-startify'
    Plug 'ryanoasis/vim-devicons' 
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'ap/vim-css-color'
    Plug 'ap/vim-buftabline'          " buffer tabs
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'jiangmiao/auto-pairs'
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-commentary'
    Plug 'unkiwii/vim-nerdtree-sync'
    Plug 'jasonccox/vim-wayland-clipboard'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }

    " THEMES
    Plug 'sainnhe/everforest'
    " Plug 'catppuccin/vim', { 'as': 'catppuccin' }
    " Plug 'rebelot/kanagawa.nvim'
    " Plug 'lighthaus-theme/vim-lighthaus'
    " Plug 'wadackel/vim-dogrun'
  call plug#end()

" map leader to Space
  let mapleader = " "

  " bootstrap vim-plug
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  set updatetime=100
  set backspace=start,eol,indent
  set termguicolors
  set background=dark
  set hidden
  set t_Co=256
  set ai                              " indent on enter
  set autoread                        " reload file if changed externally
  set cc=80                         " col 80
  set colorcolumn=+1
  set copyindent                    " autoindent when pasting code
  set cursorline
  set cursorcolumn
  set enc=utf-8 nobomb              " encoding
  set expandtab
  set fillchars+=vert:#               " vertical char fill
  set hlsearch                      " highlight search terms
  set ignorecase
  set incsearch                     " incremental search
  set list
  set listchars=tab:.\ ,eol:¬       " showing hidden chars
  set mat=1
  set matchpairs+=<:>	               " html pair highlight
  set matchtime=3
  set mouse=a
  set nobackup                      " rm backups
  set nocompatible
  set nostartofline                   " don't reset cursor to start of line when moving around
  set noswapfile
  " set number
  set relativenumber
  set pastetoggle=<f2>                " toggle paste mode with f2
  set ruler
  set shiftwidth=2
  set showmatch
  set showtabline=2
  set smartcase                     " smartcase for search
  set softtabstop=2
  set splitbelow
  set splitright
  set tabstop=2                     " tabs = 2 spaces
  " set textwidth=80                  " text width
  " set tw=80
  set wildignore=*.swp,*.bak,*.pyc,*.class " ignore files
  set wildmenu                      " completion on mode-line
  set wrap                            " Wrap lines

" leader shortcuts
  map <leader>\ :Magit<CR>
  map <leader>t :tabnew<CR>
  map <leader>x :tabclose<CR>
  map <leader>f :%s///g
  map <leader>q :q<CR>

" yank to system clipboard
  if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard
    if has("unnamedplus") " X11 support
      set clipboard+=unnamedplus
      noremap <Leader>y "*y
      noremap <Leader>p "*p
      noremap <Leader>Y "+y
      noremap <Leader>P "+p
    endif
  endif

" copy/paste for x11 vim
  vmap <C-c> "+y
  nmap <C-b> "+p

" custom highlight color
  function! MyHighlights() abort
    highlight Visual     cterm=NONE ctermbg=76  ctermfg=16  gui=NONE guibg=#a7c080 guifg=#000000
    highlight search     cterm=NONE ctermbg=76  ctermfg=16  gui=NONE guibg=#33cc33 guifg=#000000
  endfunction
  augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
  augroup END

" theme
  if has('termguicolors')
    set termguicolors
  endif
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:everforest_background = 'medium'
  let g:everforest_better_performance = 1
  let g:airline_theme = 'everforest'
  colorscheme everforest
  " colorscheme catppuccin_macchiato
  " colorscheme kanagawa

" mapping for viewing open buffers
  nnoremap <F5> :buffers<CR>:buffer<Space>
  nnoremap Q <nop> " disable ex-mode

" grep
  :set grepprg=grep\ -HRIn\ $*
  vnoremap <F8> y:vimgrep "<c-r>"" %<CR>
  map <leader>gg :copen \| :grep 
  ":cnext
  ":cprev


" vim pane navigation
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

" split shortcuts
  nnoremap ,v <C-w>v
  nnoremap ,h <C-w>s

" Visually select the text that was last edited/pasted
  nnoremap gV `[v`]

" selelct what you've just pasted
  nnoremap gp `[v`]

"" tab navigation
  nnoremap tn   :tabnew<Space>
  nnoremap tk		:tabnext<CR>
  nnoremap tj		:tabprev<CR>
  nnoremap tl		:tablast<CR>

"" buffer navigation
  nnoremap <C-N> :bnext<CR>
  nnoremap <C-P> :bprev<CR>
  nnoremap <C-W> :bdelete<CR>

" color config
  highlight NonText ctermbg=none
  highlight NonText guifg=#4a4a59
  highlight SpecialKey guifg=#4a4a59
  highlight Comment cterm=italic
  highlight ColorColumn ctermbg=0 guibg=black
  highlight ruler guibg=#00EE00

" syntax hilighting
  syntax sync fromstart
  syntax enable

" AUTO MATCHING BRACKETS, PARENS
  " inoremap (  ()<Esc>i
  " inoremap [  []<Esc>i
  " inoremap '  ''<Esc>i
  " inoremap "  ""<Esc>i
  " inoremap {  {}<Esc>i
  " inoremap {<CR> {<CR>}<C-o>O
  " vnoremap . :normal .<CR>>
  " vnoremap # :s#^#\##<cr>
  " vnoremap -# :s#^\###<cr>
  " vnoremap <c>/ :s/^#\//<cr>
  " vnoremap <c>-/ :s/^\///<cr>

" PASTE MODE F5
  function! HasPaste()
    if &paste
      return 'PASTE MODE  '
    en
    return ''
  endfunction

" load plugins for files
  filetype plugin on
  filetype indent on

" alias w with W and q with Q to catch mistakes
  cnoreabbrev W w
  cnoreabbrev Wqa wqa
  cnoreabbrev Q q

" sudo catch mistakakes
  cnoremap w!! %!sudo tee > /dev/null %

" Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json setf javascript
" python
  au FileType python set sts=4 ts=4 sw=4 tw=79
  autocmd BufWritePre *.py :%s/\s\+$//e
" Make sure all markdown files have the correct filetype
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
" Make those debugger statements painfully obvious
  au BufEnter *.rb syn match error contained "\<binding.pry\>"
  au BufEnter *.rb syn match error contained "\<debugger\>"

" tmux
  " play nice with tmux
  autocmd BufLeave,FocusLost * silent! update
  " resize with tmux
  autocmd VimResized * :wincmd =

  noremap <F3> :Autoformat<CR>
  noremap <C-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR> " move line up
  noremap <C-down> ddp                " move line down

" reselect visual block after indent/outdent
    vnoremap < <gv
    vnoremap > >gv

" NERDTree
  " AUTO reload nerdtree
  au CursorHold * if exists("t:NerdTreeBufName") | call <SNR>15_refreshRoot() | endif
  " shortcut for nerdtree
  map <silent> <C-\> :NERDTreeFocus<CR>
  " autoreload nerdtree on focus
   " autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p
" let g:NERDTreeWinPos = "right"

" tagbar toggle
  nmap <F8> :TagbarToggle<CR>

" auto load vimrc on changes
  augroup myvimrc
      au!
      au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END

" move among buffers with CTRL
    " map <C-S-J> :bnext<CR>
    " map <C-S-K> :bprev<CR>
    " mini buffer explorer
    nmap <C-E> <C-^>

" minibufferexplorer
    let g:miniBufExplMapWindowNavArrows = 1

" colorcode less files
    au BufNewFile,BufRead *.less set filetype=css
    let $PAGER=''

" markdown viewer
    noremap <silent> <leader>om :call OpenMarkdownPreview()<cr>

    function! OpenMarkdownPreview() abort
      if exists('s:markdown_job_id') && s:markdown_job_id > 0
        call jobstop(s:markdown_job_id)
        unlet s:markdown_job_id
      endif
      let s:markdown_job_id = jobstart('grip ' . shellescape(expand('%:p')))
      if s:markdown_job_id <= 0 | return | endif
      call system('open http://localhost:6419')
    endfunction

au BufNewFile,BufRead *.bats set filetype=bash

" tmux italics...https://gist.github.com/gutoyr/4192af1aced7a1b555df06bd3781a722
set t_ZH=[3
set t_ZR=[23m

" for fixing home and end keys in mac
map  <C-A> <Home>
imap <C-A> <Home>
vmap <C-A> <Home>
map  <C-E> <End>
imap <C-E> <End>
vmap <C-E> <End>
map <DEL> <BS>

" nerdtree hilight
let g:NERDTreeHighlightCursorline = 1
let g:nerdtree_sync_cursorline = 1

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

" statusline
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%0*%{StatuslineGit()}
set statusline+=%#CursorColumn#
set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%m
set statusline+=%=
set statusline+=%#PmenuSel#
set statusline+=\ %y
set statusline+=%#CursorColumn#
set statusline+=%2*\ col:\ %02v\                         " Colomn number
set statusline+=%1*\ ln:\ %02l/%L\ (%3p%%)\              " Line number / total lines, percentage of document

" syntax hilighting for notes
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

" file fuzzy finder
nnoremap <C-p> :Files<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,c :Commits<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>

" shortcuts for notetaking
map <leader>d :put =strftime('%Y-%m-%d')<CR>
inoremap <C-l> - [ ]
inoremap <C-k> []()
" file history in fzf
map <leader>h :History<CR>  

" shortcuts for git
cnoremap ga :!git add %<CR>

" autostart NERDTree
" autocmd VimEnter * NERDTree
" autocmd VimEnter * 2wincmd w
augroup my_markdown
    autocmd!
    autocmd FileType markdown nnoremap <F9> :<c-u>silent call system('mdtopdf '.expand('%:p:S'))<cr>
augroup END

" Enable folding.
let g:vim_markdown_folding_disabled = 0

" Fold heading in with the contents.
let g:vim_markdown_folding_style_pythonic = 1

" Don't use the shipped key bindings.
let g:vim_markdown_no_default_key_mappings = 1

" Autoshrink TOCs.
let g:vim_markdown_toc_autofit = 1

" Indentation for new lists. We don't insert bullets as it doesn't play
" nicely with `gq` formatting. It relies on a hack of treating bullets
" as comment characters.
" See https://github.com/plasticboy/vim-markdown/issues/232
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0

" Filetype names and aliases for fenced code blocks.
let g:vim_markdown_fenced_languages = ['php', 'py=python', 'js=javascript', 'bash=sh', 'viml=vim']

" Highlight front matter (useful for Hugo posts).
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_frontmatter = 1

" Format strike-through text (wrapped in `~~`).
let g:vim_markdown_strikethrough = 1

" no bueno. hides '*' chars when bolding text...
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
