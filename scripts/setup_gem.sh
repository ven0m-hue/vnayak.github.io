#!/bin/bash

# Exit on any error
set -e

echo "=== Installing dependencies ==="
sudo apt update
sudo apt install -y build-essential libssl-dev libreadline-dev zlib1g-dev git curl libsqlite3-dev

echo "=== Installing rbenv ==="
if [ ! -d "$HOME/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >>~/.bashrc
  echo 'eval "$(rbenv init -)"' >>~/.bashrc
  source ~/.bashrc
else
  echo "rbenv already installed"
fi

echo "=== Installing ruby-build plugin ==="
if [ ! -d "$HOME/.rbenv/plugins/ruby-build" ]; then
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

echo "=== Installing Ruby 3.2.2 ==="
rbenv install -s 3.2.2
rbenv global 3.2.2
ruby -v

echo "=== Updating RubyGems and Bundler ==="
gem update --system
gem install bundler
bundle -v

echo "=== Installing Jekyll ==="
gem install jekyll
jekyll -v

echo "✅ Ruby 3.2.2 + Bundler + Jekyll installed successfully!"
echo "You may need to open a new terminal or run 'source ~/.bashrc' for rbenv to take effect."
