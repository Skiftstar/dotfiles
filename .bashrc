alias config='/usr/bin/git --git-dir=/home/sam/.dotfiles/ --work-tree=/home/sam'
# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

#####---------- EXPORTS ----------###

export LESSHISTFILE=-
export HISTFILE="$HOME/.bash_history"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export CDPATH=".:$HOME:$HOME/.config/:$HOME/.local/:$HOME/.local/share/:$HOME/.local/programs"
export LIBVIRT_DEFAULT_URI='qemu:///system'
export CSCOPE_EDITOR="nvim"
export PATH="/home/kyu/.cargo/bin:$PATH"

eval $(dircolors ~/.dir_colors)

# Open nvim in the directory that you specify
vim() {
  if [ -d "$1" ]; then
    cd "$1" && nvim .
  elif [ -f "$1" ]; then
    cd "$(dirname "$1")" && nvim "$(basename "$1")"
  else
    echo "Error: $1 is not a valid directory or file"
  fi
}

# Wallpaper test
alias wp-test='function _test() { magick "$1" -brightness-contrast -40x0 ~/.config/ags/wallpaper.png && swww img ~/.config/ags/wallpaper.png && wallust run "$1" -C '~/.config/ags/style/wallust/wallust_dark.toml' -k -s && wallust run "$1" -k -s -C '~/.config/ags/style/wallust/wallust_light.toml' ; }; _test'

alias ls='ls --color=auto'
alias ll='ls -alh --color=auto'
alias grep='grep --color=auto'
alias neofetch='fastfetch'
alias fetch='fastfetch'
alias shutdown='shutdown -h now'
alias proc='ps auxc'

###------------------- PROMPT -----------------------###

function parse_git_dirty {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
  if echo "${STATUS}" | grep -c "renamed:"         &> /dev/null; then printf " >"; else printf ""; fi
  if echo "${STATUS}" | grep -c "branch is ahead:" &> /dev/null; then printf " !"; else printf ""; fi
  if echo "${STATUS}" | grep -c "new file::"       &> /dev/null; then printf " +"; else printf ""; fi
  if echo "${STATUS}" | grep -c "Untracked files:" &> /dev/null; then printf " ?"; else printf ""; fi
  if echo "${STATUS}" | grep -c "modified:"        &> /dev/null; then printf " *"; else printf ""; fi
  if echo "${STATUS}" | grep -c "deleted:"         &> /dev/null; then printf " -"; else printf ""; fi
  printf " ]"
}

parse_git_branch() {
  # Long form
  git rev-parse --abbrev-ref HEAD 2> /dev/null
 # Short form
  # git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}

prompt_comment() {
    DIR="$HOME/.local/share/promptcomments/"
    MESSAGE="$(find "$DIR"/*.txt | shuf -n1)"
    cat "$MESSAGE"
}

#PS1="\e[00;36m\]┌─[ \e[00;37m\]\T \d \e[00;36m\]]──\e[00;31m\]>\e[00;37m\] \u\e[00;31m\]@\e[00;37m\]\h\n\e[00;36m\]|\n\e[00;36m\]└────\e[00;31m\]> \e[00;37m\]\w \e[00;31m\]\$ \e[01;37m\]"
# PS1="\[\e[01;37m\]{ \[\e[01;34m\]\w \[\e[01;37m\]} \[\e[01;35m\]\[\$ \]\[\e[01;37m\]"
#PS1="\[\e[1;36m\]\$(parse_git_branch)\[\033[31m\]\$(parse_git_dirty)\[\033[00m\]\n\w\[\e[1;31m\] \[\e[1;36m\]\[\e[1;37m\] "PS1="\[\e[1;33m\]\$(parse_git_branch)\[\033[34m\]\$(parse_git_dirty)\n\[\033[1;36m\]  \[\e[1;37m\] \w \[\e[1;37m\]\[\e[0;37m\] "
PS1="\[\e[1;33m\]\$(parse_git_branch)\[\033[34m\]\$(parse_git_dirty)\n\[\033[1;34m\] 󰣇 \[\e[1;37m\] \w \[\e[1;36m\]\[\e[0;37m\] "

###---------- ARCHIVE EXTRACT ----------###

ex ()
{
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1   ;;
        *.tar.gz)    tar xzf $1   ;;
        *.bz2)       bunzip2 $1   ;;
        *.rar)       unrar x $1   ;;
        *.gz)        gunzip $1    ;;
        *.tar)       tar xf $1    ;;
        *.tbz2)      tar xjf $1   ;;
        *.tgz)       tar xzf $1   ;;
        *.zip)       unzip $1     ;;
        *.Z)         uncompress $1;;
        *.7z)        7za e x $1   ;;
        *.deb)       ar x $1      ;;
        *.tar.xz)    tar xf $1    ;;
        *.tar.zst)   unzstd $1    ;;
        *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


### ---------- OTHER ----------###

HISTSIZE=10000
#SAVEHIST=10000

export LESS_TERMCAP_mb=$'\e[1;36m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[1;37m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;34m'

### ---- npm packages ----- ###
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

###-------- gnupg -------###
export GPG_TTY=$(tty)
# google-cloud-cli gcloud
# source /etc/profile.d/google-cloud-cli.sh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export PATH=/home/kyu/.cargo/bin:/home/kyu/.bun/bin:/usr/bin/flutter/bin:/home/kyu/.nvm/versions/node/v22.4.0/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/kyu/.npm-packages/bin:/opt/purevpn-cli/bin
export PATH=~/.npm-global/bin:$PATH 

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'
