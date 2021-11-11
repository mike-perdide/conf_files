# history settings
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
eval `dircolors -b`
setopt append_history
# Don't add dups to the command list
#setopt hist_ignore_dups
# Don't save dups to the history file
setopt hist_save_no_dups
# Remove superfluous blanks before inserting in the history
setopt hist_reduce_blanks

autoload -U compinit
compinit

# no Beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

# >| must be used to write an existing file
setopt nullglob
# delete / on when completing, if the next character is ' '
setopt auto_remove_slash
# auto cd to the directory
setopt auto_cd
# when tab is pressed for the second time, zsh will write in the current buffer the first item of the completion list
#setopt auto_menu
unsetopt list_ambiguous

# zmv !
autoload -U zmv

# mime stuff
autoload -U zsh-mime-setup
autoload -U zsh-mime-handler
zsh-mime-setup
# extensions .log
zstyle ':mime:.log:' handler view %s
# is equivalent to :
# alias -s log=view

# completion stuff
# moving in the completion menu
zstyle ':completion:*' menu select=2
# don t propose a file if it is already in the buffer
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

# aliases
alias ls='ls -F'
alias l='ls --color=auto'
alias ll='l -lh'
alias lt='l -lht'
alias la='l -ltha'

alias -g L='|less'

alias goget='sudo apt-get install'
alias gosrch='sudo aptitude search'
alias gofile='apt-file search'
alias purgepyc='rm **/*.pyc'

# environment settings
export PATH=$PATH:$HOME/opt:$HOME/.local/bin

# Virtualenvwrapper settings
export WORKON_HOME=$HOME/.virtualenvs
VIRTUALENV_SCRIPT=/usr/share/bash-completion/completions/virtualenvwrapper
if [ -f $VIRTUALENV_SCRIPT ]
then
    source $VIRTUALENV_SCRIPT
fi

# function to delete words, stopping at "/"
slash-backward-kill-word() {
    local WORDCHARS="${WORDCHARS:s@/@}"
    zle backward-kill-word
}
zle -N slash-backward-kill-word
bindkey '^w' slash-backward-kill-word

# key bindings
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[D' backward-char
bindkey '^[[C' forward-char
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^B" push-line-or-edit

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Vi style:
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

setopt prompt_subst
autoload colors
colors

autoload -Uz vcs_info
# set some colors
for COLOR in RED GREEN YELLOW MAGENTA WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{${reset_color}%}";
# set formats
# # %b - branchname
# # %u - unstagedstr (see below)
# # %c - stangedstr (see below)
# # %a - action (e.g. rebase-i)
# # %R - repository path
# # %S - path in the repository
FMT_BRANCH="${PR_GREEN}%b%u%c${PR_RESET}" # e.g. master¹²
FMT_ACTION="(${PR_CYAN}%a${PR_RESET}%)"   # e.g. (rebase-i)
FMT_PATH="%R${PR_YELLOW}/%S"              # e.g. ~/repo/subdir

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '¹'  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr '²'    # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats "//${FMT_BRANCH}${FMT_ACTION}" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' formats       "//${FMT_BRANCH}"              "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"

function precmd {
    last_time=$cmd_time
    export cmd_time="$(date +"%s")"
    if [ x"$last_time" != x"" ]
    then
        last_took=$(expr $cmd_time - $last_time)
        if [ $last_took -gt 5 ]
        then
            echo "Last command took: $last_took seconds"
        fi
    fi
    vcs_info 'prompt'
}
function lprompt {
    local brackets=$1
    local color1=$2
    local color2=$3

    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}"

    local host="${PR_YELLOW}%m${PR_RESET}"

    local git='$vcs_info_msg_0_'
    local cwd="${PR_CYAN}%B%1~%b"

    PROMPT="${PR_RESET}${bracket_open}${host}.${cwd}${git}${bracket_close}%# ${PR_RESET}"
}

function rprompt {
    local brackets=$1
    local color1=$2
    local color2=$3

    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}${PR_RESET}"
    local colon="${color1}:"
    local at="${color1}@${PR_RESET}"
    local time="${color1}%T${PR_RESET}"

    local vcs_cwd='${${vcs_info_msg_1_%%.}/$HOME/~}'
    local cwd="${color2}%B%20<..<${vcs_cwd}%<<%b"
    local inner="${time}${colon}${cwd}"

    RPROMPT="${PR_RESET}${bracket_open}${inner}${bracket_close}${PR_RESET}"
}

lprompt '[]' $BR_BRIGHT_BLACK $PR_BLUE
rprompt '()' $BR_BRIGHT_BLACK $PR_GREEN
# PS1 and PS2
#export  PS1="$(print '%{\e[1;34m%}%m%{\e[0m%}').$(print '%{\e[0;34m%}%~%{\e[0m%}')$(__prompt_git)%# "
#export RPS1="$(print '%{\e[1;32m%}[%T]%{\e[0m%}')"
#export PS2="$(print '%{\e[0;34m%}>%{\e[0m%}')"

# PS1 and PS2
#local hostname="%{\e[0;35m%}%m%{\e[0m%}"
#local _path="%{\e[1;34m%}%~%{\e[0m%}"
#local time="%{\e[1;32m%}[%T]%{\e[0m%}"
#
#export  PS1="$(print "%{\e[1;32m%}$(git_branch)%{\e[1m%}"${hostname}).$(print ${_path})%# "
#export RPS1="$(print ${time})"
#export PS2="$(print '%{\e[0;34m%}>%{\e[0m%}')"

setopt extended_glob
preexec () {
    export cmd_time="$(date +"%s")"
    echo $$ $(date) $(pwd) $USER $(history -1) >> ~/.eternal_history
}

# Easy man access with <Esc>h
autoload run-help

alias cf='cd ~/conffiles'

export HGEDITOR=~/conffiles/hg/hgeditor
# Local definitions

if [ -f ~/.ssh/aliases ]
then
    . ~/.ssh/aliases
fi

alias pretty_grep='function _get(){ echo -e "\033[0;32m--------------------------------------------------------------------\nRECHERCHE DE : $@\n--------------------------------------------------------------------\033[0m"; git -c color.grep.filename="bold yellow" -c color.grep.linenumber="cyan" grep -ni --break --heading --fixed-strings "$@" -- "./*" ":(exclude)*.map" ":(exclude)*.min.js" ":(exclude)*/static/js/build/*"; echo ""; echo ""; echo ""; };'
