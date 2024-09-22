# keaysxyz
#
# Author: Keays
# License: MIT

# ------------------------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------------------------

SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true

# ------------------------------------------------------------------------------
# CUSTOM SECTIONS
# ------------------------------------------------------------------------------

# Full-screen line
SPACESHIP_LINE_SHOW=true
SPACESHIP_LINE_COLOR="white"

spaceship_line() {
  [[ $SPACESHIP_LINE_SHOW == false ]] && return
  local line=$(printf '%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '_')
  spaceship::section --color "$SPACESHIP_LINE_COLOR" "$line"
}

# Bird symbol
SPACESHIP_BIRD_SHOW=true
SPACESHIP_BIRD_SYMBOL="𓅓 "
SPACESHIP_BIRD_COLOR="blue"

spaceship_bird() {
  [[ $SPACESHIP_BIRD_SHOW == false ]] && return
  spaceship::section --color "$SPACESHIP_BIRD_COLOR" "$SPACESHIP_BIRD_SYMBOL"
}

# Custom user and host section
spaceship_user_host() {
  local user_host_info="${USER} ✦ "
  spaceship::section --color "blue" "$user_host_info"
}

# IP Address
SPACESHIP_IP_SHOW=true
SPACESHIP_IP_PREFIX=""
SPACESHIP_IP_SUFFIX=""
SPACESHIP_IP_COLOR="white"

spaceship_ip() {
  [[ $SPACESHIP_IP_SHOW == false ]] && return
  local ip_address=$(hostname -I | awk '{print $1}')
  [[ -z "$ip_address" ]] && return
  spaceship::section --color "$SPACESHIP_IP_COLOR" --prefix "$SPACESHIP_IP_PREFIX" --suffix "$SPACESHIP_IP_SUFFIX" "$ip_address"
}

# Custom directory prefix
spaceship_dir() {
  local dir_info=" ${PWD/#$HOME/}"
  spaceship::section --color "blue" "$dir_info"
}

# ------------------------------------------------------------------------------
# PROMPT ORDER
# ------------------------------------------------------------------------------

SPACESHIP_PROMPT_ORDER=(
  line
  bird
  user_host
  dir
  git
  line_sep
  char
)

SPACESHIP_RPROMPT_ORDER=(
  time
  ip
)

# ------------------------------------------------------------------------------
# SPACESHIP PROMPT COMPONENTS
# ------------------------------------------------------------------------------

# Include the default Spaceship prompt components
source "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh"

# ------------------------------------------------------------------------------
# CUSTOMIZATIONS
# ------------------------------------------------------------------------------

SPACESHIP_CHAR_SYMBOL=""
SPACESHIP_SUDO_SHOW=true
SPACESHIP_SUDO_SYMBOL=""
SPACESHIP_CHAR_COLOR_SUCCESS="green"
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always
SPACESHIP_DIR_TRUNC=0

# PS2 (continuation interactive prompt)
PS2="$SPACESHIP_CHAR_SYMBOL"

# Add an empty line before the right prompt
precmd() {
  print ''
}

# Construct the prompt
spaceship_prompt() {
  RETVAL=$?
  for section in "${SPACESHIP_PROMPT_ORDER[@]}"; do
    spaceship::section::render "$section"
  done
}

spaceship_rprompt() {
  for section in "${SPACESHIP_RPROMPT_ORDER[@]}"; do
    spaceship::section::render "$section"
  done
}

# Expose the prompt
PROMPT='$(spaceship_prompt)'
RPROMPT='$(spaceship_rprompt)'


