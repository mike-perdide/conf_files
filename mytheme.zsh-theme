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
#zstyle ':vcs_info:*:prompt:*' check-for-changes true
#zstyle ':vcs_info:*:prompt:*' unstagedstr '¹'  # display ¹ if there are unstaged changes
#zstyle ':vcs_info:*:prompt:*' stagedstr '²'    # display ² if there are staged changes
#zstyle ':vcs_info:*:prompt:*' actionformats "//${FMT_BRANCH}${FMT_ACTION}" "${FMT_PATH}"
#zstyle ':vcs_info:*:prompt:*' formats       "//${FMT_BRANCH}"              "${FMT_PATH}"
#zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"

function lprompt {
    local brackets=$1
    local color1=$2
    local color2=$3

    local bracket_open="${color1}${brackets[1]}${PR_RESET}"
    local bracket_close="${color1}${brackets[2]}"

    local host="${PR_YELLOW}%m${PR_RESET}"

    local git='$(git_prompt_info)'
    local cwd="${PR_CYAN}%B%1~%b"

    PROMPT="${PR_RESET}${bracket_open}${host}.${cwd}${PR_RESET}${git}${bracket_close}%# ${PR_RESET}"
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
    local cwd="${color2}%B%20~%b"
    local inner="${time}${colon}${cwd}"

    RPROMPT="${PR_RESET}${bracket_open}${inner}${bracket_close}${PR_RESET}"
}

lprompt '[]' $BR_BRIGHT_BLACK $PR_BLUE
rprompt '()' $BR_BRIGHT_BLACK $PR_GREEN

ZSH_THEME_GIT_PROMPT_PREFIX="//%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNSTAGED="¹"
ZSH_THEME_GIT_PROMPT_STAGED="²"
