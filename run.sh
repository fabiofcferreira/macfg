#!/bin/bash

echo "Creating Hyper.js configuration..."
cp ./assets/hyper/.hyper.js ~/.hyper.js
echo "✅ Successfully moved .hyper.js."

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "✅ Successfully installed homebrew"

echo "Installing terminal highlights"
brew install zsh-syntax-highlighting
echo "✅ Installed terminal highlighting"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing nvm, node, git"
brew install nvm

echo 'export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc

echo 'autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc' >> ~/.zshrc
echo "✅ Installed and configured NVM"

nvm install --lts
echo "✅ Installed default node version"

brew install git
git config --global core.editor "nano"
echo "✅ Installed git"

echo 'export VISUAL=nano
export EDITOR="$VISUAL"' >> ~/.zshrc

git config --global user.name "Fábio Ferreira"
git config --global user.email ffcfpten@gmail.com

echo "Installing git-cz"
npm install -g git-cz
echo "✅ Installed git-cz"

echo "Installing yarn"
npm install --global yarn
corepack enable
echo "✅ Installed yarn"

echo "Adding useful git shortcuts"
echo '# Custom Git commands' >> ~/.zprofile
echo 'alias l="ls -lAh"
alias gpull="git pull;"
alias gpullupdate="git pull; yarn;"
alias gbranch="git branch;"
alias gdone="git checkout master || git checkout main; git branch -D @{-1};"
alias gpr="git checkout -b "$@""
alias ggo="gitcz"
alias gstatus="git status"
alias grevlast="git reset HEAD~1"
alias gcatchup="git checkout master || git checkout main; gpullupdate; git checkout -"' >> ~/.zshrc
