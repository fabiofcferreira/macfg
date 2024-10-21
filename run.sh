#!/bin/bash

echo "Creating Hyper.js configuration..."
cp ./assets/hyper/.hyper.js ~/.hyper.js
echo "✅ Successfully moved .hyper.js."

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "✅ Installed homebrew"

echo "Installing nvm, node, git"
brew install nvm
nvm install lts
brew install git

