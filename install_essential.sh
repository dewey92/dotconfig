installApps () {
  # Install essentials
  printf "Installing essentials..."
  yay -S kitty neovim xsel brave bat lazygit git-delta-bin fd ripgrep fzf ranger keyd \
    picom sxhkd bspwm polybar rofi siji \
    zsh bpytop exa flmeshot pandoc playerctl;

  # Install Node through NVM
  printf "Installing NPM..."
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash;
}

setupKeyd () {
  ln -s ~/.config/keyd/default.conf /etc/keyd/default.conf;
  # Enable unicode support in the config file
  ln -s /usr/share/keyd/keyd.compose ~/.XCompose;
}

# @see https://askubuntu.com/a/623968
spinner() {
  local i sp n
  sp='/-\|'
  n=${#sp}
  printf ' '
  while sleep 0.1; do
    printf "%s\b" "${sp:i++%n:1}"
  done
}
