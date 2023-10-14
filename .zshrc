# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

export PATH="$HOME/nvim-macos/bin:$PATH"
export PATH="/Applications/Docker.app/Contents/Resources/bin/:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
js(){
  javac -cp . *.java && java -cp . $1;
}
jcar(){
  javac $1.java && java $1;
  rm $1.class;  
}
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

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
load-nvmrc

start-nb(){
  python -m jupyter nbextension     enable jupyter_ascending --sys-prefix --py
  python -m jupyter serverextension enable jupyter_ascending --sys-prefix --py
  jupyter notebook $1
}
refresh(){
  source ~/.zshrc
}
get-cover-pdf(){
if ! [ -f "./cltemplate.tex" ]; then
  echo "$PWD"
  echo "the template file doesn't exist"
else
  pandoc --pdf-engine=xelatex \
  --template=./cltemplate.tex \
  -p -f markdown \
  -t latex \
  -s $1 \
  -o cover.pdf 

  echo "Done"
fi
}
eval "$(~/.rbenv/bin/rbenv init - zsh)"
eval "$(direnv hook zsh)"
# source plugins 
source ~/zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

alias allow="direnv allow ."
alias nb="start-nb"
eval "$(pyenv virtualenv-init -)"
export JAVA_HOME=$(/usr/libexec/java_home)
# export LLVM_HOME=./llvm-project/
# export LLVM_BUILD=./llvm-project/build/

export PATH="/Users/vincentcradler/commands:$PATH"
export PATH=/opt/gradle/bin:$PATH
export PATH=/usr/local/texlive/2023basic/bin:$PATH
export COMPILED_DIR=~/install/

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# set -o vi
alias c++='c++ -std=c++17'

export PATH=$HOME/bin:/usr/local/bin:$PATH
alias axbrew='arch -x86_64 /usr/local/homebrew/bin/brew'
alias rosetta="arch -x86_64 zsh"
alias wine="wine64"
alias ez="nvim ~/.zshrc"
alias tf="terraform"
alias tfp="tf plan"
alias tfa="tf apply"
