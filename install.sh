#! /bin/bash
# install fd
asdf plugin add fd
asdf install fd 7.4.0
asdf global fd 7.4.0

# install ripgrep
asdf plugin add ripgrep
asdf install ripgrep 11.0.2
asdf global ripgrep 11.0.2

# install cmake
asdf plugin add cmake https://github.com/asdf-community/asdf-cmake.git

# install ninja-build
asdf plugin-add ninja https://github.com/asdf-community/asdf-ninja.git
