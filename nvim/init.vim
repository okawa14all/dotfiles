augroup MyAutoCmd
  autocmd!
augroup END

" dein cache dir
let $CACHE = expand('~/.cache')
if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Load dein
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein')
          \. '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

" dein configurations
let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
  call dein#begin(s:path)

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy' : 0})
  call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy' : 1})
  if has('nvim')
    call dein#load_toml('~/.config/nvim/dein_neovim.toml', {'lazy': 1})
  endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

set number
set clipboard=unnamed
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set smartindent
set title
set showmatch

set statusline+=%{fugitive#statusline()}
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive'
    \ }
\ }
function! MyFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

set background=dark
colorscheme hybrid
syntax on

" 保存時に行末のスペースを削除
autocmd BufWritePre * :%s/\s\+$//ge

" Denite key mapping
nnoremap <silent> <C-k><C-f> :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
nnoremap <silent> <C-k><C-g> :<C-u>Denite grep -highlight-mode-insert=Search<CR>
nnoremap <silent> <C-k><C-l> :<C-u>Denite line -highlight-mode-insert=Search<CR>
nnoremap <silent> <C-k><C-b> :<C-u>Denite buffer -highlight-mode-insert=Search<CR>
" ESCの代替
imap <C-j> <esc>
noremap! <C-j> <esc>
" バッファ切り替え
map <silent> <C-b><C-n> :bn<CR>
map <silent> <C-b><C-b> :bp<CR>
" ctrl + s で保存
inoremap <silent> <C-s> <Esc>:w<CR>

