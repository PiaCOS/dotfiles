" Sets the default vim settings. 
source $VIMRUNTIME/defaults.vim

let mapleader=" "
nnoremap <Space> <Nop>

" ------------------------------------------------------------------
" theme stuff
" ------------------------------------------------------------------
" set background=light " or 'dark', depending on your terminal's theme
set background=dark " or 'light', depending on your terminal's theme

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

" Comment and uncomment selection in visual mode (only c-like stuff)
xnoremap <leader>c :s/^/\/\/ /<CR>
xnoremap <leader>u :s/^\/\/\s\?//<CR>

