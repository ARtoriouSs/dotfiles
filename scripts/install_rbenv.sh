#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src && cd - # can fail, it's ok
  ~/.rbenv/bin/rbenv init
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # verify rbenv
  # ruby-build for rbenv
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install rbenv
  rbenv init
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # verify rbenv
fi

# default-gems for rbenv
git clone https://github.com/rbenv/rbenv-default-gems.git $(rbenv root)/plugins/rbenv-default-gems

# symlinks for default-gems file
ln -sf ~/dotfiles/default-gems $(rbenv root)/default-gems
