" Sets the default vim settings. 
source $VIMRUNTIME/defaults.vim

" ------------------------------------------------------------------
" theme stuff
" ------------------------------------------------------------------
set background=light " or 'dark', depending on your terminal's theme
set t_Co=256

" Enable syntax highlighting.
syntax on

" ------------------------------------------------------------------
" tabs setup
" ------------------------------------------------------------------

set list
set listchars=tab:··,trail:·
" set listchars=tab:»·,trail:·

autocmd FileType c setlocal tabstop=4 shiftwidth=4 noexpandtab

" ------------------------------------------------------------------
" keymaps
" ------------------------------------------------------------------
let mapleader = " "

" Comment and uncomment selection in visual mode (only c-like stuff)
xnoremap <leader>c :s/^/\/\/ /<CR>
xnoremap <leader>u :s/^\/\/\s\?//<CR>

