#!/bin/bash

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src && cd - # can fail, it's ok
~/.rbenv/bin/rbenv init
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # verify rbenv

# ruby-build for rbenv
mkdir -p "$(~/.rbenv/bin/rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(~/.rbenv/bin/rbenv root)"/plugins/ruby-build

# default-gems for rbenv
git clone https://github.com/rbenv/rbenv-default-gems.git $(~/.rbenv/bin/rbenv root)/plugins/rbenv-default-gems
ln -sf ~/dotfiles/development/default-gems $(~/.rbenv/bin/rbenv root)/default-gems

# ctags for rbenv
git clone git://github.com/tpope/rbenv-ctags.git $(~/.rbenv/bin/rbenv root)/plugins/rbenv-ctags
