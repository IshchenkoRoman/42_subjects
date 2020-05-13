#!
ZSH_PATH=$HOME/.zshrc

RBVER=2.4.2
PYVER=3.6.5

function install_brew {
  printf '%s\n' "Installing Homebrew"
	mkdir $HOME/.brew && curl -fsSL https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $HOME/.brew
	mkdir -p /tmp/.$(whoami)-brew-locks
	mkdir -p $HOME/.brew/var/homebrew
	ln -s /tmp/.$(whoami)-brew-locks $HOME/.brew/var/homebrew/locks
	#export PATH="$HOME/.brew/bin:$PATH"
	echo 'mkdir -p /tmp/.$(whoami)-brew-locks' >> $ZSH_PATH
	echo 'export PATH="$HOME/.brew/bin:$PATH"' >> $ZSH_PATH
  source $ZSH_PATH
  printf '%s\n' "Done Installing Homebrew"
}

function install_rbenv {
  printf '%s\n' "Installing Rbenv"
	brew install rbenv
	rbenv install $RBVER
	echo 'export RBENV_VERSION="'$RBVER'"' >> $ZSH_PATH
  echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> $ZSH_PATH
	#echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $ZSH_PATH
	source $ZSH_PATH
}

function install_pyenv {
  printf '%s\n' "Installing Pyenv"
  brew install readline xz
	brew install pyenv
	pyenv install $PYVER
	echo 'export PYENV_VERSION="'$PYVER'"' >> $ZSH_PATH
	echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> $ZSH_PATH
	source $ZSH_PATH
}

xcode-select --install > /dev/null 2>&1

if [ ! -d "$HOME/.brew" ]; then
    install_brew
fi
printf '%s\n' "Updating Homebrew"
brew update && brew upgrade
printf '%s\n' "Homebrew update complete"
command -v rbenv >/dev/null 2>&1 || install_rbenv
printf '%s\n' "Rbenv Installed"
command -v pyenv >/dev/null 2>&1 || install_pyenv
printf '%s\n' "Pyenv Installed"

exec /bin/zsh
