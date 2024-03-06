"plugins
call plug#begin('~/.vim/userplugins')

"Smooth scrolling
Plug 'psliwka/vim-smoothie'

"clang-format integration
Plug 'rhysd/vim-clang-format'

"Language Server Client
Plug 'natebosch/vim-lsc'

"CMake integration
Plug 'cdelledonne/vim-cmake'

"File tree viewer
Plug 'lambdalisue/fern.vim', { 'branch' : 'main' }

"Replace netrw with fern
Plug 'lambdalisue/fern-hijack.vim'

"Fancy statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Better autocompletion control
Plug 'ervandew/supertab'

"Better C++ syntax highlight
Plug 'bfrg/vim-cpp-modern', { 'do': 'mkdir -p ~/.vim/after/syntax;cp ~/.vim/userplugins/vim-cpp-modern/after/syntax/* ~/.vim/after/syntax' }

call plug#end()

nnoremap <silent> <Leader>ee :<C-u>Fern <C-r>=<SID>smart_path()<CR><CR>

"session save options
set ssop=buffers,curdir,folds,tabpages,winsize
nnoremap <C-s> :wa <bar> :mks!<CR><CR>

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
set wildmenu		    "enable a menu that shows tab completion options in the status bar
set wildchar=^I     "show possible completions.
set wildmode=longest:full,full "complete the next full match using the longest common string
set wildoptions=pum "show complietion options in a pop up menu
set showmatch		    "highlights matching brackets on cursor hover
set ruler		        "show cursor position in status bar
set showcmd		      "shows the normal mode command before it gets executed

"search
set hlsearch		"highlights searches
set incsearch		"incremental search (searches character by character)
set ignorecase		"ignores the case of a search
set smartcase		"only ignores case if there are no capital letters in search (only works after ignorecase has been set)

"indenting
set tabstop=2		"the amount of spaces that vim will equate to a tab character
set softtabstop=2	"like tabstop, but for editing operations (insert mode)
set shiftwidth=2	"used for autoindent and << and >> operators in normal mode
set autoindent		"copies indent from current line to the next line
set expandtab		"tabs will expand to whitespace characters

set clipboard=unnamed

"folding
set foldenable
set foldmethod=indent

"airline - also enable for tabline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#buffers_label = 'b'

"keys
set backspace=indent,eol,start      "allow backspacing over everything

"make vim accept commands while using russian layout
set langmap=йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ.\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>/? 

"c++ syntax highlight
" Enable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1
" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1
" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

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
 \  },
 \  'cmake': {
 \    'command': 'cmake-language-server',
 \    'suppress_stderr': v:true,
 \  }
 \}

let g:lsc_auto_map = {
 \  'defaults': v:true,
 \  'GoToDefinition': 'gd',
 \  'Completion': 'omnifunc',
 \  'SignatureHelp': 'gm'
 \}
let g:lsc_enable_autocomplete  = v:true
let g:lsc_enable_diagnostics   = v:true
let g:lsc_reference_highlights = v:true
let g:lsc_trace_level          = 'off'

"Supertab scroll from top
let g:SuperTabDefaultCompletionType        = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

"Configure clang-format
let g:clang_format#code_style = "llvm"
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_format = 1
let g:clang_format#detect_style_file = 1
