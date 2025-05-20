" Sets the default vim settings. 
source $VIMRUNTIME/defaults.vim

let mapleader=" "
nnoremap <Space> <Nop>

" ------------------------------------------------------------------
" theme stuff
" ------------------------------------------------------------------
" set background=light " or 'dark', depending on your terminal's theme
set background=dark " or 'light', depending on your terminal's theme

" Enable syntax highlighting.
syntax on

set t_Co=16


" Enable syntax highlighting.
syntax on

" ------------------------------------------------------------------
" tabs setup
" ------------------------------------------------------------------

" set list
" set listchars=tab:··,trail:·
" set listchars=tab:»·,trail:·

autocmd FileType c setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType lua setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType py setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType js setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType xml setlocal tabstop=4 shiftwidth=4 noexpandtab
" ------------------------------------------------------------------
" keymaps
" ------------------------------------------------------------------

" Comment and uncomment selection in visual mode (only c-like stuff)
xnoremap <leader>c :s/^/\/\/ /<CR>
xnoremap <leader>u :s/^\/\/\s\?//<CR>

