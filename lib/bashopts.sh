#!/usr/bin/env bash

# Sets some Bash options to encourage well formed code.
# For example, some of the options here will cause the script to terminate as
# soon as a command fails. Another option will cause an error if an undefined
# variable is used.
# See: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html

# Any trap on ERR is inherited by shell functions, command substitutions, and
# commands executed in a subshell environment. The ERR trap is normally not
# inherited in such cases.
set -o errtrace

# Any trap on DEBUG and RETURN are inherited by shell functions, command
# substitutions, and commands executed in a subshell environment. The DEBUG and
# RETURN traps are normally not inherited in such cases.
set -o functrace

# Exit if any command exits with a non-zero exit status.
set -o errexit

# Exit if script uses undefined variables.
set -o nounset

# Prevent masking an error in a pipeline.
# Look at the end of the 'Use set -e' section for an excellent explanation.
# see: https://www.davidpashley.com/articles/writing-robust-shell-scripts/
set -o pipefail

export BANNER='
  __ _       _           _                 _
 / _(_)_ __ | |__   ___ | |_ ___        __| | _____   __
| |_| |  _ \|  _ \ / _ \| __/ __|_____ / _` |/ _ \ \ / /
|  _| | | | | |_) | (_) | |_\__ \_____| (_| |  __/\ V /
|_| |_|_| |_|_.__/ \___/ \__|___/      \__,_|\___| \_/
  '

# Colors
ESC_SEQ="\x1b["
C_BLUE="${ESC_SEQ}34;01m"
C_CYAN="${ESC_SEQ}36;01m"
C_GREEN="${ESC_SEQ}32;01m"
C_MAGENTA="${ESC_SEQ}35;01m"
C_RED="${ESC_SEQ}31;01m"
C_RESET="${ESC_SEQ}39;49;00m"
C_YELLOW="${ESC_SEQ}33;01m"

################################################################################
# TUI Functions
################################################################################

banner() {
  if [ -n "${PS1:-}" ]; then
    TERM=linux clear
  fi
  (>&2 echo -e "${C_GREEN}${BANNER}${C_RESET}")
}

action() {
  local -r msg="${1:-}"
  (>&2 echo -e "\n${C_YELLOW}[action]:${C_RESET}\n ⇒ ${msg} ...")
}

bot() {
  local -r msg="${1:-}"
  (>&2 echo -e "\n${C_GREEN}\[._.]/${C_RESET} - ${msg}")
}

die() {
  (>&2 echo "$@")
  exit 1
}

error() {
  local -r msg="${1:-}"
  (>&2 echo -e "\a${C_RED}[error]${C_RESET} ${msg}")
}

info() {
  local -r msg="${1:-}"
  (>&2 echo -e "${C_GREEN}[info]${C_RESET} ${msg}")
}

line() {
  (>&2 echo -e "------------------------------------------------------------------------------------")
}

ok() {
  local -r msg="${1:-}"
  (>&2 echo -e "${C_GREEN}[ok]${C_RESET} ${msg}")
}

running() {
  local -r msg="${1:-}"
  (>&2 echo -en "${C_YELLOW} ⇒ ${C_RESET} ${msg}:")
}

warn() {
  local -r msg="${1:-}"
  (>&2 echo -e "${C_YELLOW}[warning]${C_RESET} ${msg}")
}

confirm() {
  read -n1 -rsp $'Press Y continue or Ctrl+C to exit...\n' key
  if [ "$key" = 'Y' ]; then
    echo '' # Y pressed, continue
  else
    confirm # Anything else pressed, repeat prompt
  fi
}

git_clone_or_update() {
  if [ -d "$2/.git" ]; then
    action "update $1 master branch"
    ( cd "$2" || exit; git checkout master && git pull origin master && git submodule update --recursive > /dev/null 2>&1 )
    if git branch -a | grep -E 'remotes/origin/develop'; then
      action "update $1 develop branch"
      ( cd "$2" || exit; git checkout develop && git pull origin develop && git submodule update --recursive > /dev/null 2>&1 )
    fi
  else
    action "clone $1"
    git clone --recurse-submodules "$1" "$2" > /dev/null 2>&1
  fi
}
