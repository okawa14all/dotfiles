set number
set clipboard=unnamed

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
"  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy' : 0})
"  call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy' : 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
