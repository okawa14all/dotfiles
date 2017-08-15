# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定

#bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする
setopt nonomatch

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

# zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=100              # メモリに保存されるヒストリの件数
SAVEHIST=2000              # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=hxfxcxdxbxegedabagacad

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}[%n@%m]% %(!.#.$) %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[cyan]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

# ------------------------------
# Other Settings
# ------------------------------
### Aliases ###
alias ll='ls -lG'
alias mvim="/Applications/MacVim.app/Contents/MacOS/Vim -g"
alias atom="/Applications/Atom.app/Contents/MacOS/Atom"

### git aliases ###
alias gst='git status'
alias gad='git add'
alias gdi='git diff'
alias gco='git commit'
alias gps='git push'
alias gpl='git pull'
alias gch='git checkout'
alias gfe='git fetch'
alias gbr='git branch'
alias glog='git log'
alias gloga="git log --graph --all --color --pretty='%x09%h %cn%x09%s %Cred%d'"

### iPhone Simulator list alias
alias iphonesimlist='/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/simctl list'

### java ###
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

### 環境変数設定 ###
# for pythonbrew
export VIRTUALENV_USE_DISTRIBUTE=true
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

### ruby ###
eval "$(rbenv init -)"

### Direnv ###
eval "$(direnv hook zsh)"

### postgresql
export PGDATA=/usr/local/var/postgres

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

### nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

### oracle
# export DYLD_LIBRARY_PATH=/opt/oracle/instantclient_12_1
# export ORACLE_HOME=/opt/oracle/instantclient_12_1
export OCI_DIR=$(brew --prefix)/lib
export NLS_LANG=Japanese_Japan.JA16SJIS
