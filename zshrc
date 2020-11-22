export ZSH=$HOME/.oh-my-zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH_THEME="sorin"

BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

plugins=(git wd zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

DEFAULT_USER="lipton"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

alias vim="nvim"
alias vi="nvim"

alias be="bundle exec"
alias c="clear"
alias rubodiff="git diff --name-only | xargs rubocop"

export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/postgresql@11/bin:/usr/local/opt/node@12/bin:$PATH"

# Added by GDK bootstrap
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:${PKG_CONFIG_PATH}"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1 --with-readline-dir=/usr/local/opt/readline"
source /Users/lipton/.asdf/asdf.sh
