# 設定ファイル系の更新

BASHRC="${HOME}/.bashrc"
if test "$(grep -ce "^set -o vi" "${BASHRC}")" -eq 0 ; then
    cat << 'EOF' >> "${BASHRC}" 

export EDITOR="code --wait"
set -o vi
bind -m vi-insert '"\C-l":clear-screen'
bind -m vi-move '"\C-l":clear-screen'

source "/usr/share/bash-completion/bash_completion"
source "/usr/share/bash-completion/completions/git"
eval "$(gh completion -s bash)"
EOF
fi

TMUX_CONF="${HOME}/.tmux.conf"
if test ! -f  "${TMUX_CONF}" ;then
    cat << 'EOF' > ~/.tmux.conf
# $Id: vim-keys.conf,v 1.2 2010-09-18 09:36:15 nicm Exp $
#
# vim-keys.conf, v1.2 2010/09/12
#
# By Daniel Thau.  Public domain.
#
# This configuration file binds many vi- and vim-like bindings to the
# appropriate tmux key bindings.  Note that for many key bindings there is no
# tmux analogue.  This is intended for tmux 1.3, which handles pane selection
# differently from the previous versions

# split windows like vim
# vim's definition of a horizontal/vertical split is reversed from tmux's
bind s split-window -v
bind v split-window -h

# move around panes with hjkl, as one would in vim after pressing ctrl-w
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# resize panes like vim
# feel free to change the "1" to however many lines you want to resize by, only
# one at a time can be slow
bind < resize-pane -L 1
bind > resize-pane -R 1
bind - resize-pane -D 1
bind + resize-pane -U 1

# bind : to command-prompt like vim
# this is the default in tmux already
bind : command-prompt

# vi-style controls for copy mode
setw -g mode-keys vi

# 追加の設定
# ==========================================================================

# 256色サポート
#set-option -g default-terminal screen-256color
set -g default-terminal "screen-256color"
set-option -g set-clipboard off
set-option -g status-bg blue
set-option -g status-fg '#FFFFFF'
set-option -g status-style bg=blue,fg='#FFFFFF'
set-option -g pane-active-border-style fg=brightblue

# 24bitカラーサポート
set -ga terminal-overrides ",xterm-termite:Tc"

# 環境変数
set -g update-environment 'DISPLAY SSH_ASKPASS SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY TERM GTK_IM_MODULE XMODIFIERS=@im QT_IM_MODULE VSCODE_IPC_HOOK_CLI VSCODE_GIT_IPC_HANDLE VSCODE_GIT_ASKPASS_NODE GIT_ASKPASS VSCODE_GIT_ASKPASS_MAIN'

# vでマーク開始
bind -T copy-mode-vi v send -X begin-selection
# yでヤンク
bind -T copy-mode-vi y send -X copy-selection

# gで/path/to/file.ext:nn:nn形式のファイルを開く
#  1. 行を選択しコピーしてスクリプトにわたす.
#  2. スクリプト内でファイルパスを取り出して開く
bind -T copy-mode-vi g send -X select-line \; send -X copy-pipe-and-cancel 'go_from_pane'

# YでヤンクとVSCode上での編集(codeコマンドは待機するが、tmuxがバックグラウンドへ回すぽい)
bind -T copy-mode-vi Y send -X copy-pipe 'code -'

# カーソルキー(リピートを解除する)
unbind Up
bind Up select-pane -U
unbind Down
bind Down select-pane -D
unbind Left
bind Left select-pane -L
unbind Right
bind Right select-pane -R


# Home/Endキー
unbind -T copy-mode-vi Home
bind -T copy-mode-vi Home send -X start-of-line
unbind -T copy-mode-vi End
bind -T copy-mode-vi End send -X end-of-line

# 前後pane移動(リピートあり)
bind -r k select-pane -t :.-
bind -r j select-pane -t :.+

# paneの直接選択
bind o command-prompt -p pane "select-pane -t '%%'"

# ステータスバー
# ==========================================================================
#set -g status-right '#[default]%H:%M %m/%d(%a)#[default]'
#set -g status-utf8 on
set -g status-right "#(ts_date) %H:%M#[default]"

# SHELL の指定
set-option -g default-shell /bin/bash
set-option -g default-command /bin/bash

EOF
fi

# 各種プログラムを手動でインストール

## fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

## gh
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
 && sudo mkdir -p -m 755 /etc/apt/keyrings \
 && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
 && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
 && sudo apt update \
 && sudo apt install gh -y 

## code cli
curl -sL 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' | tar -zxf -
test -d ~/.local/bin || mkdir -p ~/.local/bin
mv code ~/.local/bin/code
