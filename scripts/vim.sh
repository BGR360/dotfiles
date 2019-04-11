#!/bin/bash

. scripts/common.sh

vundledir=$HOME/.vim/bundle/Vundle.vim
vundlerepo=https://github.com/VundleVim/Vundle.vim.git
your_vimrc=$HOME/.vimrc
this_vimrc=${dotdir}.vimrc
tmp_vimrc=${dotdir}.tmpvimrc

begin "vim"

if [[ ! -e $your_vimrc ]] || (echo "You already have a .vimrc in your home directory." && confirm "Replace it?") ; then
	echo "Copy $this_vimrc --> $your_vimrc"
	cp $this_vimrc $your_vimrc
else
	if confirm "Do you want to prepend .vimrc to your existing .vimrc?" ; then
		echo "Prepending .vimrc to ~/.vimrc..."
		cp $this_vimrc $tmp_vimrc
		echo "" >> $tmp_vimrc
		cat $your_vimrc >> $tmp_vimrc
		cp $tmp_vimrc $your_vimrc
		rm $tmp_vimrc
		echo "done."
	else
		if ! confirm "Do you still want to install vundle plugins?" ; then
			exit 0
		fi
	fi
fi

# Install vundle?

if [[ -d $vundledir ]]; then
	echo "Vundle already installed"
else
	echo "Installing vundle..."
	echo "git clone $vundlerepo $vundledir"
	git clone $vundlerepo $vundledir
	echo "done."
fi

# Vundle plugin install
if confirm "Install Vundle plugins now? (will open vim while it installs)" ; then
	echo "Installing vundle plugins..."
	vim -c 'PluginInstall' -c 'qa!'
	echo "done."
fi

end "vim"

