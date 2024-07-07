#! /usr/bin/env bash

set -Eeo pipefail

readonly REPO_DIR="$(dirname "$(readlink -m "${0}")")"

MY_USERNAME="${SUDO_USER:-$(logname 2> /dev/null || echo "${USER}")}"
MY_HOME=$(getent passwd "${MY_USERNAME}" | cut -d: -f6)

THEME_NAME="NoTab"

edit_firefox="false"

FIREFOX_SRC_DIR="${REPO_DIR}/src"
FIREFOX_DIR_HOME="${MY_HOME}/.mozilla/firefox"
FIREFOX_THEME_DIR="${MY_HOME}/.mozilla/firefox/firefox-themes"

export c_default="\033[0m"
export c_blue="\033[1;34m"
export c_magenta="\033[1;35m"
export c_cyan="\033[1;36m"
export c_green="\033[1;32m"
export c_red="\033[1;31m"
export c_yellow="\033[1;33m"

prompt() {
  case "${1}" in
    "-s")
      echo -e "  ${c_green}${2}${c_default}" ;;    # print success message
    "-e")
      echo -e "  ${c_red}${2}${c_default}" ;;      # print error message
    "-w")
      echo -e "  ${c_yellow}${2}${c_default}" ;;   # print warning message
    "-i")
      echo -e "  ${c_cyan}${2}${c_default}" ;;     # print info message
  esac
}

has_command() {
  command -v "$1" &> /dev/null
}

udoify_file() {
  if [[ -f "${1}" && "$(ls -ld "${1}" | awk '{print $3}')" != "${MY_USERNAME}" ]]; then
    sudo chown "${MY_USERNAME}:" "${1}"
  fi
}

install_firefox_theme() {
  local TARGET_DIR="${FIREFOX_THEME_DIR}"
  local name=${1}

  mkdir -p                                                                                    "${TARGET_DIR}"
  [[ -f "${TARGET_DIR}"/userChrome.css ]] && mv "${TARGET_DIR}"/userChrome.css "${TARGET_DIR}"/userChrome.css.bak
  cp -rf "${FIREFOX_SRC_DIR}"/userChrome-"${name}".css                                        "${TARGET_DIR}"/userChrome.css
  config_firefox
}

config_firefox() {
  local TARGET_DIR="${FIREFOX_THEME_DIR}"
  local FIREFOX_DIR="${FIREFOX_DIR_HOME}"

  killall "firefox" "firefox-bin" &> /dev/null || true

  for d in "${FIREFOX_DIR}/"*"default"*; do
    if [[ -f "${d}/prefs.js" ]]; then
      rm -rf                                                                                  "${d}/chrome"
      ln -sf "${TARGET_DIR}"                                                                  "${d}/chrome"
      udoify_file                                                                             "${d}/prefs.js"
      echo "user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);" >>     "${d}/prefs.js"
      echo "user_pref(\"browser.tabs.drawInTitlebar\", true);" >>                             "${d}/prefs.js"
      echo "user_pref(\"browser.uidensity\", 0);" >>                                          "${d}/prefs.js"
      echo "user_pref(\"layers.acceleration.force-enabled\", true);" >>                       "${d}/prefs.js"
      echo "user_pref(\"mozilla.widget.use-argb-visuals\", true);" >>                         "${d}/prefs.js"
    fi
  done
}

remove_firefox_theme() {
  [[ -f "${FIREFOX_THEME_DIR}"/userChrome.css ]] && rm -rf "${FIREFOX_THEME_DIR}"/userChrome.css
}

echo

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -r|--remove|--revert)
      uninstall='true'; shift ;;
    *)
      prompt -e "ERROR: Unrecognized tweak option '${1}'."
      shift ;;
  esac
done

if [[ "${uninstall}" == 'true' ]]; then
    prompt -i "Removing '${THEME_NAME}' Firefox theme...\n"
    remove_firefox_theme
    prompt -s "Done! '${THEME_NAME}' Firefox theme has been removed."
else
    prompt -i "Installing '${THEME_NAME}' Firefox theme...\n"
    install_firefox_theme "${name:-${THEME_NAME}}"
    prompt -s "Done! '${THEME_NAME}' Firefox theme has been installed.\n"
fi
