#!/usr/bin/env zsh

OPT=~/opt
mkdir -p $OPT

# Jump around - https://github.com/rupa/z
git clone git@github.com:rupa/z.git $OPT/z

# https://github.com/zsh-users/zsh-autosuggestions
brew install zsh-autosuggestions

# https://github.com/zsh-users/zsh-completions
brew install zsh-completions
rm -f ~/.zcompdump-* .zcompdump-*
./etc/compinit.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
brew install zsh-syntax-highlighting

# fd is a simple, fast and user-friendly alternative to find.
# https://github.com/sharkdp/fd
alias fd=fdfind

