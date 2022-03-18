"plugins
call plug#begin('~/.vim/userplugins')

"Smooth scrolling
Plug 'psliwka/vim-smoothie'
"Language Server Client
Plug 'natebosch/vim-lsc'
"Improved autocomplete
Plug 'ajh17/VimCompletesMe'
"File tree viewer
Plug 'lambdalisue/fern.vim'
"Replace netrw with fern
Plug 'lambdalisue/fern-hijack.vim'

call plug#end()

nnoremap <silent> <Leader>ee :<C-u>Fern <C-r>=<SID>smart_path()<CR><CR>

"Return a parent directory of the current buffer when the buffer is a file.
"Otherwise it returns a current working directory.
function! s:smart_path() abort
  if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
    return fnamemodify('.', ':p')
  endif
  return fnamemodify(expand('%'), ':p:h')
endfunction

"augroup my-fern-startup
"  autocmd! *
"  autocmd VimEnter * ++nested Fern . -drawer
"augroup END

"interface
set number          "show line number of current line
set relativenumber	"show line numbers relative to the current line
set wildmenu		"enable a menu that shows tab completion options in the status bar
set wildchar=<TAB>  "show possible completions.
set wildmode=list:longest
set showmatch		"highlights matching brackets on cursor hover
set ruler		    "show cursor position in status bar
set showcmd		    "shows the normal mode command before it gets executed

"search
set hlsearch		"highlights searches
set incsearch		"incremental search (searches character by character)
set ignorecase		"ignores the case of a search
set smartcase		"only ignores case if there are no capital letters in search (only works after ignorecase has been set)

"indenting
set tabstop=4		"the amount of spaces that vim will equate to a tab character
set softtabstop=4	"like tabstop, but for editing operations (insert mode)
set shiftwidth=4	"used for autoindent and << and >> operators in normal mode
set autoindent		"copies indent from current line to the next line
set expandtab		"tabs will expand to whitespace characters

set clipboard=unnamed

"folding
set foldenable
set foldmethod=indent

"keys
set backspace=indent,eol,start      "allow backspacing over everything

"make vim accept commands while using russian layout
set langmap=йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ.\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>/? 

"LSC(Language Server Client) - autocomplete, rename all instances and other neat stuff, as seen in IDE's
syntax on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
let g:lsc_server_commands = {
 \  'c': {
 \    'command': 'clangd --background-index',
 \    'suppress_stderr': v:true,
 \  },
 \  'cpp': {
 \    'command': 'clangd --background-index',
 \    'suppress_stderr': v:true,
 \  }
 \}
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}
let g:lsc_enable_autocomplete  = v:true
let g:lsc_enable_diagnostics   = v:true
let g:lsc_reference_highlights = v:true
let g:lsc_trace_level          = 'off'
