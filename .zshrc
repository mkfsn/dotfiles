#
# Samuel's .zshrc config file
#
#          2013, 08/14 @Taipei
#                                                                      ___           ___
#                                           ___           ___         /\_ \         /\_ \ (R)
#  sssssssssssssamuelolololololololol      /\_ \         /\_ \     ___\//\ \     ___\//\ \
#    ____    __      ___ ___   __  __    __\//\ \     ___\//\ \   / __`\\ \ \   / __`\\ \ \
#   /',__\ /'__`\  /' __` __`\/\ \/\ \ /'__`\\ \ \   / __`\\ \ \ /\ \L\ \\_\ \_/\ \L\ \\_\ \_
#  /\__, `\\ \L\.\_/\ \/\ \/\ \ \ \_\ \\  __/ \_\ \_/\ \L\ \\_\ \\ \____//\____\ \____//\____\
#  \/\____/ \__/.\_\ \_\ \_\ \_\ \____/ \____\/\____\ \____//\____\/___/ \/____/\/___/ \/____/
#   \/___/ \/__/\/_/\/_/\/_/\/_/\/___/ \/____/\/____/\/___/ \/____/ by samuelololol@gmail.com
#                                                                                                            
#                                                                                                            

export PATH="/usr/local/bin:/usr/local/sbin:$PATH:/Users/mkfsn/Repository/gocode/bin"

ZSH=$HOME/dotfiles/.zsh
#export ZSH_THEME="miloshadzic"
#export ZSH_THEME="norm"
#export ZSH_THEME="funky"
#export ZSH_THEME="dogenpunk"
#export ZSH_THEME="jreese"
export ZSH_THEME="powerlevel9k/powerlevel9k"

# command line 左邊想顯示的內容
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs) # <= left prompt 設了 "dir"

# command line 右邊想顯示的內容
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time) # <= right prompt 設了 "time"

POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# POWERLEVEL9K_SHORTEN_STRATEGY='truncate_middle'

# zsh plugin settings
# --------------------------------------------
#plugins=(git vim github svn brew osx npm nvm node yum tmux virtualenv virtualenvwrapper)
#plugins=(git vim github brew osx npm nvm node virtualenv virtualenvwrapper tmux docker docker-compose zsh-navigation-tools)
plugins=(brew osx)

# [[ -s "/usr/bin/virtualenvwrapper.sh"  ]] &&\
#     plugins=(git vim github brew osx npm nvm node tmux docker docker-compose virtualenvwrapper zsh-navigation-tools)

echo "Loading oh-my-zsh settings...."
source $ZSH/oh-my-zsh.sh
#website:   http://mimosa-pudica.net/zsh-incremental.html
#file link: http://mimosa-pudica.net/src/incr-0.2.zsh
#source ~/dotfiles/incr-0.2.zsh


# alias commands
alias ll='ls -l'
alias l='ll'
alias la='l -a'
alias lh='l -h'
alias sl='ls'
alias watch='watch '
alias mk='make -f Makefile.mkfsn'
alias icdiff='icdiff --highlight'
export LC_CTYPE="zh_TW.UTF-8"

# terminal color issue
#export TERM=screen-256color
#export TERM=xterm
alias tmux='DISPLAY=:0.0 TERM=screen-256color tmux -2'
alias screen='DISPLAY=:0.0 TERM=xterm-256color screen'

#my zsh_completion
fpath=($HOME/dotfiles/zsh_completion $fpath)
autoload -U compinit
compinit


# keymap
# https://wiki.archlinux.org/index.php/Zsh#Key_bindings
[[ -s "$HOME/dotfiles/.myenvvar"  ]] && source "$HOME/dotfiles/.myenvvar"

# nvm, rvm, virtualenv
#source $HOME/dotfiles/samuel_py_rc
#source $HOME/dotfiles/samuel_node_rc
#source $HOME/dotfiles/samuel_ruby_rc
#echo ""
[[ -s "/usr/bin/screenfetch"  ]] && screenfetch

source $HOME/.gvm/scripts/gvm

[ -f $HOME/.glasnostic ] && source $HOME/.glasnostic

export GOPATH="$HOME/Repository/gocode"
export GOROOT=/usr/local/opt/go/libexec
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$NVM_DIR/versions/node/v6.9.4/bin"
# . "/usr/local/opt/nvm/nvm.sh"
REPORTTIME=10

# alias minikube-start='minikube start --vm-driver xhyve --insecure-registry localhost:5000'
alias minikube-start='minikube start --vm-driver hyperkit'
alias docker-rm='docker rm $(docker ps --all -q -f status=exited)'
alias docker-rmi='docker rmi -f $(docker images -qf "dangling=true")'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export SHUCYAN="/Users/mkfsn/Repository/github.com/mkfsn/shucyan"

# added by travis gem
[ -f /Users/mkfsn/.travis/travis.sh ] && source /Users/mkfsn/.travis/travis.sh

PATH="/Users/mkfsn/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/mkfsn/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/mkfsn/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/mkfsn/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/mkfsn/perl5"; export PERL_MM_OPT;
