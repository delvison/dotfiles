# ##########
# prompt
# ##########

autoload -Uz vcs_info # enable vcs_info
precmd () { vcs_info } # always load before displaying the prompt
zstyle ':vcs_info:*' formats ' %s(%b)' # git(main)
PS1='%n@%F{magenta}%m %F{green}%~%f$vcs_info_msg_0_ $ '
